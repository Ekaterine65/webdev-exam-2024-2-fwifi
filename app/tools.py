import hashlib
import uuid
import os
from werkzeug.utils import secure_filename
from flask import current_app
from models import db, Review, Cover

class ImageSaver:
    def __init__(self, file):
        self.file = file

    def save(self):
        self.img = self.__find_by_md5_hash()
        if self.img is not None:
            return self.img
        file_name = secure_filename(self.file.filename)
        self.img = Cover(
            id=str(uuid.uuid4()),
            file_name=file_name,
            mime_type=self.file.mimetype,
            md5_hash=self.md5_hash)
        self.file.save(
            os.path.join(current_app.config['UPLOAD_FOLDER'],
                         self.img.storage_filename))
        db.session.add(self.img)
        db.session.commit()
        return self.img

    def __find_by_md5_hash(self):
        self.md5_hash = hashlib.md5(self.file.read()).hexdigest()
        self.file.seek(0)
        return db.session.execute(db.select(Cover).filter(Cover.md5_hash == self.md5_hash)).scalar()

    
class ReviewsFilter:
    def __init__(self, course_id, sort_order):
        self.course_id = course_id
        self.sort_order = sort_order
        self.query = db.session.query(Review).filter_by(course_id=course_id)

    def perform(self):
        if self.sort_order == 'positive':
            self.query = self.query.order_by(Review.rating.desc(), Review.created_at.desc())
        elif self.sort_order == 'negative':
            self.query = self.query.order_by(Review.rating.asc(), Review.created_at.desc())
        else:
            self.query = self.query.order_by(Review.created_at.desc())

        return self.query

