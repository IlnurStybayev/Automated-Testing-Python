#!/bin/bash
# stop_project.sh

# chmod +x stop_project.sh Делаем скрипт исполняемым.
# source stop_project.sh Запускаем
# ls -l stop_project.sh проверяем точно ли файл Setup стал исполняемым

# Функция для остановки pgAdmin 4
# echo "Остановка локального pgAdmin 4"

# stop_pgadmin() {
#   echo "Остановка pgAdmin 4..."
#   pkill -f "pgAdmin 4"
#   echo "pgAdmin 4 остановлен."
# }

# # Обработка сигнала завершения
# trap 'stop_pgadmin' EXIT
# echo "pgAdmin 4 остановлен"

echo "Остановка локального сервера разработки..."

# Определение и остановка процесса сервера разработки
PID=$(ps aux | grep 'manage.py runserver' | grep -v grep | awk '{print $2}')
if [ -z "$PID" ]; then
    echo "Сервер разработки не был запущен."
else
    kill $PID
    echo "Сервер разработки остановлен."
fi

# Удаление кеша pytest
echo "Удаление кеша pytest..."
rm -rf .pytest_cache
echo "Кеш pytest удален."

# Удаление временных файлов
# Можно добавить другие команды для удаления временных файлов, если это необходимо
# Например: rm -rf some_temp_directory

# Дополнительные действия по очистке, если они требуются


echo "Деактивация виртуального окружения..."
deactivate

echo "Проект успешно остановлен и очищен."
