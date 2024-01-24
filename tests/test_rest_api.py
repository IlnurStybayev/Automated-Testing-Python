# test_rest_api.py
import requests
import pytest

def test_get_request():
    response = requests.get("https://jsonplaceholder.typicode.com/todos/1")
    assert response.status_code == 200
    assert "userId" in response.json()
    assert "id" in response.json()
    assert "title" in response.json()
    assert "completed" in response.json()

def test_post_request():
    data = {"title": "foo", "body": "bar", "userId": 1}
    response = requests.post("https://jsonplaceholder.typicode.com/posts", json=data)
    assert response.status_code == 201
    assert "id" in response.json()
