# test_calculator.py
import calculator

def test_add():
    assert calculator.add(1, 2) == 5

def test_subtract():
    assert calculator.subtract(3, 1) == 6
    
def test_subtract2():
    assert calculator.subtract(4, 1) == 2
