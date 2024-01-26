# tests/test_sqlalchemy_models.py
import pytest
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from myapp.sqlalchemy_models import SQLAlchemyTask, Base

@pytest.fixture
def session():
    engine = create_engine('sqlite:///:memory:')
    Base.metadata.create_all(engine)
    Session = sessionmaker(bind=engine)
    session = Session()
    yield session
    session.close()

def test_create_and_query_sqlalchemy_model(session):
    # Создание объекта модели
    test_object = SQLAlchemyTask(title="Test Object", completed=False)
    session.add(test_object)
    session.commit()

    # Запрос объекта из базы данных
    query_result = session.query(SQLAlchemyTask).filter_by(title="Test Object").first()

    assert query_result is not None
    assert query_result.title == "Test Object"
