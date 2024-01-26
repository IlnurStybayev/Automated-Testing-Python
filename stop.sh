#!/bin/bash

#chmod +x stop.sh
# source stop.sh

# Скрипт для остановки Docker-контейнеров, очистки ресурсов Docker и деактивации виртуального окружения.

echo "Остановка Docker-контейнеров и удаление их..."
docker-compose down

if [ $? -eq 0 ]; then
    echo "Docker-контейнеры успешно остановлены и удалены."

    echo "Удаление томов данных (по желанию)..."
    docker volume prune -f

    echo "Удаление сетей, созданных для контейнеров (по желанию)..."
    docker network prune -f

    echo "Удаление неиспользуемых образов Docker (по желанию)..."
    docker image prune -a -f

    echo "Деактивация виртуального окружения..."
    deactivate

    echo "Очистка завершена."
else
    echo "Ошибка: Не удалось остановить Docker-контейнеры. Пожалуйста, проверьте настройки Docker и конфигурацию."
fi

