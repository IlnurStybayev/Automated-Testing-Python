# myapp/tests.py
#python manage.py test myapp

import pytest
from django.urls import reverse
from django.test import TestCase, Client
from myapp.models import Task


       
class TaskAppTests(TestCase):

    def setUp(self):
        # Настройка перед каждым тестом
        self.client = Client()
        self.list_url = reverse('task_list')

    def test_task_list_GET(self):
        # Тестирование GET запроса на страницу списка задач
        response = self.client.get(self.list_url)

        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'myapp/task_list.html')

    # Добавьте здесь дополнительные тесты, например:
    def test_task_creation_POST(self):
        # Тестирование создания задачи через POST запрос
        response = self.client.post(self.list_url, {'title': 'New test task'})
        
        self.assertEquals(response.status_code, 302)  # Проверка редиректа после создания
        self.assertEquals(Task.objects.last().title, 'New test task')  # Проверка создания задачи в БД


