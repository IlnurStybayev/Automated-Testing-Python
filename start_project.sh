#!/bin/bash
# start_project.sh
# source start_project.sh

# Скрипт для запуска Docker-контейнеров и применения миграций Django.
# Он предназначен для быстрого развёртывания проекта.

echo "Запуск Docker-контейнеров в фоновом режиме..."
docker-compose up -d

if [ $? -eq 0 ]; then
    echo "Docker-контейнеры успешно запущены."

    echo "Применение миграций Django..."
    python manage.py makemigrations
    docker-compose exec web python manage.py migrate

    echo "Запуск сервера Django..."
    docker-compose exec web python manage.py runserver 0.0.0.0:8000

    # Опционально: Создание суперпользователя Django
    # echo "Создание суперпользователя Django..."
    # docker-compose exec web python manage.py createsuperuser

    echo "Сбор статических файлов Django..."
    docker-compose exec web python manage.py collectstatic --noinput

    echo "Запуск тестов Django..."
    docker-compose exec web python manage.py test

    echo "Открытие веб-сайта в браузере по адресу http://localhost:8000..."
    open http://localhost:8000
    echo "Открытие веб-сайта в браузере по адресу http://127.0.0.1:8000..."
    open http://127.0.0.1:8000
    echo "Открытие веб-сайта в браузере по адресу http://localhost:8081..."
    open http://localhost:8081
   
else
    echo "Ошибка: Не удалось запустить Docker-контейнеры. Пожалуйста, проверьте настройки Docker и конфигурацию."
fi
