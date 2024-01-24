# test_exceptions.py

import pytest

# Тестирование исключения
def test_exception():
    with pytest.raises(ZeroDivisionError):
        result = 1 / 0

# pytest.raises(ZeroDivisionError): 
# С использованием этого контекстного менеджера мы проверяем, что выполнение кода внутри with вызовет исключение ZeroDivisionError.