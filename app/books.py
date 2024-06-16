from flask import send_from_directory, Blueprint, render_template, request, flash, redirect, url_for
from flask_login import login_required, current_user
from sqlalchemy.exc import IntegrityError
from models import db, Book, Genre, Cover, Review
import os
from tools import ImageSaver
from config import UPLOAD_FOLDER
from datetime import datetime
import markdown
import bleach

def sanitize_html(text):
    return bleach.clean(text, tags=[], attributes={}, protocols=[], strip=True)

bp = Blueprint('books', __name__, url_prefix='/books')

BOOK_PARAMS = ['title', 'short_desc', 'year', 'publisher', 'author', 'pages']

def params():
    sanitized_params = { p: sanitize_html(request.form.get(p) or '') for p in BOOK_PARAMS }
    return sanitized_params

def get_genre_ids():
    return request.form.getlist('genre_ids')

@bp.route('/')
def index():
    books_query = db.session.query(Book).order_by(Book.year.desc())
    pagination = db.paginate(books_query, page=request.args.get('page', 1, type=int), per_page=10)
    books = pagination.items
    genres = db.session.execute(db.select(Genre)).scalars().all()
    return render_template('books/index.html', books=books, genres=genres, pagination=pagination)

@bp.route('/new')
@login_required
def new():
    if current_user.role.name != 'Администратор':
        flash('У вас недостаточно прав для выполнения данного действия', 'danger')
        return redirect(url_for('books.index'))
    genres = db.session.execute(db.select(Genre)).scalars().all()
    return render_template('books/form.html', book={}, genres=genres, endpoint='books.create', is_edit=False)

@bp.route('/create', methods=['POST'])
@login_required
def create():
    if current_user.role.name != 'Администратор':
        flash('У вас недостаточно прав для выполнения данного действия', 'danger')
        return redirect(url_for('books.index'))
    
    try:
        book = Book(**params())
        genre_ids = get_genre_ids()
        if genre_ids:
            book.genres = db.session.query(Genre).filter(Genre.id.in_(genre_ids)).all()
        
        # Обработка загрузки файла
        cover_img = request.files.get('cover_img')
        if cover_img:
            cover = ImageSaver(cover_img).save()
            book.cover_id = cover.id
        
        db.session.add(book)
        db.session.commit()
        
        flash(f'Книга {book.title} была успешно добавлена!', 'success')
    except IntegrityError as err:
        db.session.rollback()
        flash(f'При сохранении данных возникла ошибка. Проверьте корректность введённых данных. ({err})', 'danger')
    
    return redirect(url_for('books.index'))



@bp.route('/<int:book_id>/edit')
@login_required
def edit(book_id):
    book = db.get_or_404(Book, book_id)
    if current_user.role.name not in ['Администратор', 'Модератор']:
        flash('У вас недостаточно прав для выполнения данного действия', 'danger')
        return redirect(url_for('books.index'))
    genres = db.session.execute(db.select(Genre)).scalars().all()
    return render_template('books/form.html', book=book, genres=genres, endpoint='books.update', is_edit=True)

@bp.route('/<int:book_id>/update', methods=['POST'])
@login_required
def update(book_id):
    book = db.get_or_404(Book, book_id)
    if current_user.role.name not in ['Администратор', 'Модератор']:
        flash('У вас недостаточно прав для выполнения данного действия', 'danger')
        return redirect(url_for('books.index'))
    try:
        for key, value in params().items():
            setattr(book, key, value)
        genre_ids = get_genre_ids()
        if genre_ids:
            book.genres = db.session.query(Genre).filter(Genre.id.in_(genre_ids)).all()
        db.session.commit()
        flash(f'Книга {book.title} была успешно обновлена!', 'success')
    except IntegrityError as err:
        db.session.rollback()
        flash(f'При сохранении данных возникла ошибка. Проверьте корректность введённых данных. ({err})', 'danger')
    return redirect(url_for('books.index'))

@bp.route('/<int:book_id>/delete', methods=['POST'])
@login_required
def delete(book_id):
    book = db.get_or_404(Book, book_id)
    if current_user.role.name != 'Администратор':
        flash('У вас недостаточно прав для выполнения данного действия', 'danger')
        return redirect(url_for('books.index'))
    
    cover_path = os.path.join(UPLOAD_FOLDER, book.cover.storage_filename)

    try:
        db.session.delete(book)
        db.session.commit()

        if os.path.exists(cover_path):
            os.remove(cover_path)

        flash(f'Книга {book.title} была успешно удалена!', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'При удалении книги произошла ошибка: {str(e)}', 'danger')
    
    return redirect(url_for('books.index'))

@bp.route('/<int:book_id>')
def show(book_id):
    book = db.get_or_404(Book, book_id)
    current_user_review = None

    book.short_desc_html = markdown.markdown(book.short_desc)

    for review in book.reviews:
        review.text_html = markdown.markdown(review.text)

    if current_user.is_authenticated:
        current_user_review = db.session.query(Review).filter_by(book_id=book_id, user_id=current_user.id).first()
        current_user_review.text_html = markdown.markdown(current_user_review.text)
    return render_template('books/show.html', book=book, current_user_review=current_user_review)

@bp.route('/<int:book_id>/review')
@login_required
def review(book_id):
    book = db.get_or_404(Book, book_id)
    return render_template('books/add_review.html', book=book)

@bp.route('/<int:book_id>/add_review', methods=['POST'])
@login_required
def add_review(book_id):
    rating = int(request.form.get('rating'))
    text = request.form.get('text')

    if rating is None or text is None or not (0 <= rating <= 5):
        flash('Некорректные данные для отзыва.', 'danger')
        return redirect(url_for('books.show', book_id=book_id))

    existing_review = db.session.query(Review).filter_by(book_id=book_id, user_id=current_user.id).first()
    if existing_review:
        flash('Вы уже оставили отзыв для этой книги.', 'danger')
        return redirect(url_for('books.show', book_id=book_id))

    new_review = Review(
        rating=rating,
        text=text,
        created_at=datetime.now(),
        book_id=book_id,
        user_id=current_user.id
    )

    book = db.session.get(Book, book_id)
    book.rating_sum += rating
    book.rating_num += 1

    db.session.add(new_review)
    db.session.commit()

    flash('Ваш отзыв был добавлен!', 'success')
    return redirect(url_for('books.show', book_id=book_id))