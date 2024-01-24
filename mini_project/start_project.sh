#!/bin/bash
# start_project.sh

# Этот скрипт используется для запуска Docker-контейнеров и применения миграций Django.
# Он предназначен для быстрого развёртывания проекта.
# Запустить контейнеры (в фоновом режиме) и применить миграции

docker-compose up -d
docker-compose exec web python manage.py migrate