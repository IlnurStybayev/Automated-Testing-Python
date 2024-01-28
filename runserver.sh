#!/bin/bash

# runserver.sh

source venv/bin/activate

# Устанавливаем зависимости из файла requirements.txt
if pip install -r requirements.txt; then
  echo "Все зависимости из requirements.txt установлены успешно."
else
  echo "Ошибка установки зависимостей из requirements.txt."
  exit 1
fi

python manage.py migrate

python manage.py runserver 0.0.0.0:8002