# test_fixture_example.py

import pytest

# Фикстура для установки и завершения
@pytest.fixture
def setup_and_teardown():
    print("\nSetup - выполняется перед тестом")
    yield
    print("\nTeardown - выполняется после теста")

# Тест, использующий фикстуру
def test_example_with_fixture(setup_and_teardown):
    print("Тест выполняется")
    assert True
    
# @pytest.fixture: Аннотация, которая обозначает функцию фикстуры.
# yield: Место, где тест выполняется, и после этого будет выполнен код, следующий за yield.
# test_example_with_fixture: Функция теста, которая использует фикстуру.
