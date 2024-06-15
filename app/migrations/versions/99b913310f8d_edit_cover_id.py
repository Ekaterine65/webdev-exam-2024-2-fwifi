"""edit cover_id

Revision ID: 99b913310f8d
Revises: 1b312a1f4320
Create Date: 2024-06-13 11:13:07.262233

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '99b913310f8d'
down_revision = '1b312a1f4320'
branch_labels = None
depends_on = None


def upgrade():
    # Drop the existing foreign key constraint
    with op.batch_alter_table('books', schema=None) as batch_op:
        batch_op.drop_constraint('fk_books_cover_id_covers', type_='foreignkey')
    
    # Alter the column id in covers to be string type
    with op.batch_alter_table('covers', schema=None) as batch_op:
        batch_op.alter_column('id',
               existing_type=mysql.INTEGER(display_width=11),
               type_=sa.String(length=100),
               existing_nullable=False)

    # Alter the column cover_id in books to be string type
    with op.batch_alter_table('books', schema=None) as batch_op:
        batch_op.alter_column('cover_id',
               existing_type=mysql.INTEGER(display_width=11),
               type_=sa.String(length=100),
               existing_nullable=False)

    # Recreate the foreign key constraint with the new column types
    with op.batch_alter_table('books', schema=None) as batch_op:
        batch_op.create_foreign_key('fk_books_cover_id_covers', 'covers', ['cover_id'], ['id'])


def downgrade():
    # Drop the existing foreign key constraint
    with op.batch_alter_table('books', schema=None) as batch_op:
        batch_op.drop_constraint('fk_books_cover_id_covers', type_='foreignkey')

    # Alter the column cover_id in books to revert back to integer type
    with op.batch_alter_table('books', schema=None) as batch_op:
        batch_op.alter_column('cover_id',
               existing_type=sa.String(length=100),
               type_=mysql.INTEGER(display_width=11),
               existing_nullable=False)

    # Alter the column id in covers to revert back to integer type
    with op.batch_alter_table('covers', schema=None) as batch_op:
        batch_op.alter_column('id',
               existing_type=sa.String(length=100),
               type_=mysql.INTEGER(display_width=11),
               existing_nullable=False)

    # Recreate the foreign key constraint with the original column types
    with op.batch_alter_table('books', schema=None) as batch_op:
        batch_op.create_foreign_key('fk_books_cover_id_covers', 'covers', ['cover_id'], ['id'])