#!/bin/bash
# start_project.sh

LOG_FILE="start_project_log.txt"

# Логирование
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" | tee -a "$LOG_FILE"
}

# Список выполненных команд
declare -A command_status

# Получаем абсолютный путь к текущей директории
PROJECT_DIR=$(pwd)

log "Запуск Docker-контейнера с базой данных..."
if docker-compose up -d db; then
    log "Docker-контейнер с базой данных запущен успешно."
    command_status["Docker-контейнер с базой данных"]="Выполнено"
else
    log "Ошибка: Не удалось запустить Docker-контейнер с базой данных."
    command_status["Docker-контейнер с базой данных"]="Ошибка"
    exit 1
fi

log "Ожидание запуска базы данных..."
sleep 10
command_status["Ожидание запуска базы данных"]="Выполнено"

# Проверяем наличие виртуального окружения. Если его нет, создаем.
if [ ! -d "venv" ]; then
    log "Виртуальное окружение не найдено. Создание нового..."
    if python3 -m venv venv; then
        log "Виртуальное окружение создано успешно."
        command_status["Создание виртуального окружения"]="Выполнено"
    else
        log "Не удалось создать виртуальное окружение."
        command_status["Создание виртуального окружения"]="Ошибка"
        exit 1
    fi
else
    command_status["Проверка виртуального окружения"]="Пропущено (уже существует)"
fi

# Активация виртуального окружения
log "Активация виртуального окружения..."
if source venv/bin/activate; then
    log "Виртуальное окружение активировано."
    command_status["Активация виртуального окружения"]="Выполнено"
else
    log "Не удалось активировать виртуальное окружение."
    command_status["Активация виртуального окружения"]="Ошибка"
    exit 1
fi

# Устанавливаем зависимости из файла requirements.txt
if [ -f requirements.txt ]; then
    log "Установка зависимостей из файла requirements.txt..."
    if python3 -m pip install -r requirements.txt; then
        log "Все зависимости из requirements.txt установлены."
        command_status["Установка зависимостей"]="Выполнено"
    else
        log "Не удалось установить зависимости из requirements.txt."
        command_status["Установка зависимостей"]="Ошибка"
        exit 1
    fi
else
    log "Файл requirements.txt не найден. Установка зависимостей пропущена."
    command_status["Установка зависимостей"]="Пропущено (файл не найден)"
fi

# Применяем миграции
log "Применение миграций..."
if python manage.py migrate; then
    log "Миграции применены успешно."
    command_status["Применение миграций"]="Выполнено"
else
    log "Ошибка применения миграций."
    command_status["Применение миграций"]="Ошибка"
    exit 1
fi

# Функция для сохранения зависимостей в requirements.txt
save_requirements() {
    if pip freeze > requirements.txt; then
        log "Зависимости сохранены в requirements.txt"
        command_status["Сохранение зависимостей"]="Выполнено"
    else
        log "Ошибка при сохранении зависимостей."
        command_status["Сохранение зависимостей"]="Ошибка"
    fi
}

# Проверяем аргументы скрипта
if [[ "$1" == "save-req" ]]; then
    save_requirements
fi

log "Запуск сервера разработки..."
if python manage.py runserver 0.0.0.0:8002 &; then
    SERVER_PID=$!
    log "Сервер разработки запущен на порту 8002. PID: $SERVER_PID"
    command_status["Запуск сервера разработки"]="Выполнено"
else
    log "Ошибка при запуске сервера разработки."
    command_status["Запуск сервера разработки"]="Ошибка"
    exit 1
fi

# Удаление кеша и временных файлов pytest
if [ -d .pytest_cache ]; then
    rm -rf .pytest_cache
    log "Кеш и временные файлы pytest удалены."
    command_status["Удаление кеша pytest"]="Выполнено"
else
    log "Кеш pytest не найден. Удаление пропущено."
    command_status["Удаление кеша pytest"]="Пропущено (не найден)"
fi

# Открытие веб-сайта в браузере
open_site() {
    log "Открытие веб-сайта в браузере по адресу $1..."
    case "$OSTYPE" in
        "darwin"*)  open $1;;
        "linux-gnu"*) xdg-open $1;;
        "msys"*) start $1;;
        *) log "Неизвестная операционная система";;
    esac
}

# Открываем сайт в браузере, если сервер запущен
if [ -n "$SERVER_PID" ]; then
    open_site http://localhost:8002
    command_status["Открытие сайта"]="Выполнено"
else
    log "Сервер разработки не был запущен. Открытие сайта пропущено."
    command_status["Открытие сайта"]="Пропущено (сервер не запущен)"
fi

# Выводим список выполненных команд
log "Список выполненных команд:"
for cmd in "${!command_status[@]}"; do
    log "$cmd: ${command_status[$cmd]}"
done


# export DJANGO_SETTINGS_MODULE=mini_project.settings