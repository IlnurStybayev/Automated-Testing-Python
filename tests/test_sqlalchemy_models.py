# test_sqlalchemy_models.py
import pytest
from myapp.models import MyModel
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

@pytest.fixture
def session():
    # Используем память SQLite для тестов
    engine = create_engine('sqlite:///:memory:')
    MyModel.metadata.create_all(engine)
    Session = sessionmaker(bind=engine)
    return Session()

def test_create_and_query_model(session):
    # Создание объекта модели
    test_object = MyModel(name="Test Object")
    session.add(test_object)
    session.commit()

    # Запрос объекта из базы данных
    query_result = session.query(MyModel).filter_by(name="Test Object").first()
    
    assert query_result is not None
    assert query_result.name == "Test Object"
