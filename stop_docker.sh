#!/bin/bash
# stop_project.sh

#chmod +x stop_docker.sh
# source stop_docker.sh
# ls -l stop_docker.sh проверяем точно ли файл stop_docker.sh стал исполняемым

# Скрипт для остановки Docker-контейнеров, очистки ресурсов Docker и деактивации виртуального окружения.

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
echo "Удаление временных файлов и директорий..."
find . -type d -name __pycache__ -exec rm -r {} +  # Удаление кеша __pycache__
find . -type d -name "*.temp" -exec rm -r {} +  # Удаление временных директорий

# Деактивация виртуального окружения (если скрипт запущен из активированного виртуального окружения)
if [ "$VIRTUAL_ENV" != "" ]; then
    echo "Деактивация виртуального окружения..."
    deactivate
fi

echo "Проект успешно остановлен и очищен."

# Дополнительные команды для работы с Docker (закомментированы для безопасности)
# echo "Удаление всех образов Docker..."
# docker rmi $(docker images -q) -f  # Осторожно, это удалит все образы!

# echo "Удаление всех остановленных контейнеров..."
# docker rm $(docker ps -a -q)  # Осторожно, это удалит все остановленные контейнеры!
