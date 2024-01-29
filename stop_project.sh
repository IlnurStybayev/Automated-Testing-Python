#!/bin/bash
# stop_project.sh

LOG_FILE="stop_project_log.txt"

# Функция логирования
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" | tee -a "$LOG_FILE"
}

# Массив для хранения выполненных команд
executed_commands=()

log "Начало остановки проекта..."

# Включение отладочного вывода для отслеживания команд
# set -x

# Установка строгого режима для немедленного завершения при ошибках
set -euo pipefail

log "Остановка локального сервера разработки..."

# Получаем список PID-ов процессов, запущенных с помощью команды `manage.py runserver`
PIDS=$(ps aux | grep '[m]anage.py runserver' | awk '{print $2}')

# Проверяем, что сервер разработки запущен
if [ -z "$PIDS" ]; then
    log "Сервер разработки не был запущен."
    executed_commands+=("Проверка сервера разработки (не запущен)")
else
    log "PID-ы сервера разработки для остановки: $PIDS"
    # Завершаем процессы
    echo $PIDS | xargs kill || log "Ошибка при остановке сервера(ов) разработки."
    log "Сервер(ы) разработки остановлен(ы)."
    executed_commands+=("Остановка сервера разработки")
fi

log "Проверка установки Docker Compose..."
if command -v docker-compose &>/dev/null; then
    log "Остановка Docker-контейнеров..."
    docker-compose down || log "Ошибка при остановке Docker-контейнеров."
    log "Docker-контейнеры остановлены."
    executed_commands+=("Остановка Docker-контейнеров")
else
    log "Docker Compose не установлен. Остановка контейнеров пропущена."
    executed_commands+=("Проверка Docker Compose (не установлен)")
fi

log "Проверка существования кеша pytest..."
if [ -d ".pytest_cache" ]; then
    log "Удаление кеша pytest..."
    rm -rf .pytest_cache || log "Ошибка при удалении кеша pytest."
    log "Кеш pytest удален."
    executed_commands+=("Удаление кеша pytest")
else
    log "Кеш pytest не существует. Удаление пропущено."
    executed_commands+=("Проверка кеша pytest (не существует)")
fi

log "Проверка существования каталога __pycache__..."
if find . -type d -name __pycache__; then
    log "Удаление кеша pycache..."
    find . -type d -name __pycache__ -exec rm -rf {} + || log "Ошибка при удалении кеша pycache."
    log "Кеш pycache удален."
    executed_commands+=("Удаление кеша pycache")
else
    log "Каталог __pycache__ не существует. Удаление пропущено."
    executed_commands+=("Проверка кеша pycache (не существует)")
fi

log "Проверка существования виртуального окружения..."
if [ -d "venv" ]; then
    log "Удаление виртуального окружения..."
    deactivate || true  # Деактивация виртуального окружения
    rm -rf venv || log "Ошибка при удалении виртуального окружения."
    log "Виртуальное окружение удалено."
    executed_commands+=("Удаление виртуального окружения")
else
    log "Виртуальное окружение не существует. Удаление пропущено."
    executed_commands+=("Проверка виртуального окружения (не существует)")
fi

# Вывод списка выполненных команд в лог
log "Список выполненных команд:"
for cmd in "${executed_commands[@]}"; do
    log "$cmd"
done

log "Проект успешно остановлен и очищен."

# Отключение отладочного вывода
# set +x
