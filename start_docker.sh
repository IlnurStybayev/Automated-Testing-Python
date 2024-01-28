#!/bin/bash
# start_docker.sh

# source start_docker.sh
# chmod +x start_docker.sh Делаем скрипт исполняемым.
# source start_docker.sh Запускаем
# ls -l start_docker.sh проверяем точно ли файл Setup стал исполняемым

# Скрипт для запуска Docker-контейнеров и применения миграций Django.
# Он предназначен для быстрого развёртывания проекта.

# echo "Запуск Docker-контейнеров в фоновом режиме..."
# docker-compose up -d

echo "Запуск Docker-контейнеров в фоновом режиме db"
docker-compose up -d db

if [ $? -eq 0 ]; then
    echo "Docker-контейнеры успешно запущены."

    # echo "Применение миграций Django..."
    # docker-compose exec web python manage.py migrate

    # echo "Запуск сервера Django..."
    # docker-compose exec web python manage.py runserver 0.0.0.0:8000

    # Опционально: Создание суперпользователя Django
    # echo "Создание суперпользователя Django..."
    # docker-compose exec web python manage.py createsuperuser

    # echo "Сбор статических файлов Django..."
    # docker-compose exec web python manage.py collectstatic --noinput

    # echo "Запуск тестов Django..."
    # docker-compose exec web python manage.py test

    # echo "Открытие веб-сайта в браузере по адресу http://localhost:8002..."
    # open http://localhost:8002
    # echo "Открытие веб-сайта в браузере по адресу http://127.0.0.1:8002..."
    # open http://127.0.0.1:8002
    # echo "Открытие веб-сайта в браузере по адресу http://localhost:8081..."
    # open http://localhost:8081
   
else
    echo "Ошибка: Не удалось запустить Docker-контейнеры. Пожалуйста, проверьте настройки Docker и конфигурацию."
fi
