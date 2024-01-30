# test_markers.py

import pytest

# Пропуск теста с пояснением
@pytest.mark.skip(reason="Этот тест временно пропущен")
def test_skipped_function():
    pass

# @pytest.mark.skip: Маркировка для пропуска теста с пояснением причины.