# test_django_models.py
import pytest
from myapp.models import MyModel

@pytest.mark.django_db
def test_create_and_query_model():
    # Создание объекта модели
    MyModel.objects.create(name="Test Object")

    # Запрос объекта из базы данных
    query_result = MyModel.objects.get(name="Test Object")
    
    assert query_result is not None
    assert query_result.name == "Test Object"
