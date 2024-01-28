#!/bin/bash

#chmod +x stop_docker.sh
# source stop_docker.sh
# ls -l stop_docker.sh проверяем точно ли файл stop_docker.sh стал исполняемым

# Скрипт для остановки Docker-контейнеров, очистки ресурсов Docker и деактивации виртуального окружения.

#!/bin/bash
# stop_project.sh

echo "Остановка локального сервера разработки..."

# Определение и остановка процесса сервера разработки
PID=$(ps aux | grep 'manage.py runserver' | grep -v grep | awk '{print $2}')
if [ -z "$PID" ]; then
    echo "Сервер разработки не был запущен."
else
    kill $PID
    echo "Сервер разработки остановлен."
fi

echo "Остановка Docker-контейнеров..."
docker-compose down

echo "Очистка неиспользуемых Docker ресурсов..."
docker system prune -a -f --volumes

# Удаление кеша pytest
echo "Удаление кеша pytest..."
rm -rf .pytest_cache
echo "Кеш pytest удален."

# Удаление временных файлов и директорий
# echo "Удаление временных файлов..."
# rm -rf some_temp_directory

# echo "Деактивация виртуального окружения..."
# deactivate

echo "Проект успешно остановлен и очищен."



# docker images - просмотреть список всех образов 
# docker ps -a - просмотреть 
# docker rm [CONTAINER ID или NAME]
# docker rmi [IMAGE ID или NAME:TAG] - Удаление образа Docker
# docker rmi -f [IMAGE ID или NAME:TAG] - Это принудительно удалит образ и любые зависимые от него образы.





