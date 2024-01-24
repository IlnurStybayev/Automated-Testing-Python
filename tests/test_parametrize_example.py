# test_parametrize_example.py

import pytest

# Тест с параметрами
@pytest.mark.parametrize("input_data, expected", [(1, 2), (2, 4), (3, 6)])
def test_multiply_by_two(input_data, expected):
    result = input_data * 2
    assert result == expected


# @pytest.mark.parametrize: Маркировка, указывающая параметры теста и их ожидаемые значения.