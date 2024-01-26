# myapp/sqlalchemy_models.py (SQLAlchemy версия)
from sqlalchemy import Column, Integer, String, Boolean
from sqlalchemy.orm import declarative_base


Base = declarative_base()

class SQLAlchemyTask(Base):
    __tablename__ = 'task'
    id = Column(Integer, primary_key=True)
    title = Column(String(255))
    completed = Column(Boolean, default=False)
