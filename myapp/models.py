# myapp/models.py (Django версия)
from django.db import models

class Task(models.Model):
    name = models.CharField(max_length=255)
    # другие поля, если необходимы

    def __str__(self):
        return self.name