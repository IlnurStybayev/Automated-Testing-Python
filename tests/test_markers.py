# test_markers.py

import pytest

# Маркировка теста как медленного
@pytest.mark.slow
def test_slow_function():
    pass

# Пропуск теста с пояснением
@pytest.mark.skip(reason="Этот тест временно пропущен")
def test_skipped_function():
    pass

# @pytest.mark.slow: Маркировка теста как медленного.
# @pytest.mark.skip: Маркировка для пропуска теста с пояснением причины.