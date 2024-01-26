# Dockerfile

# Используем официальный образ Python как базовый образ
FROM python:3.8-slim-buster

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Копируем содержимое текущей директории в контейнер в /app
COPY . /app

# Устанавливаем необходимые пакеты, включая зависимости для psycopg2
RUN apt-get update && \
    apt-get install -y postgresql-client libpq-dev build-essential && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Копируем скрипт entrypoint в контейнер и делаем его исполняемым
COPY docker-entrypoint.sh /app/docker-entrypoint.sh
RUN chmod +x /app/docker-entrypoint.sh

# Открываем порт 8000 для внешнего мира
EXPOSE 8000

# Определяем переменные окружения
ENV NAME World
ENV POSTGRES_USER myappuser
ENV POSTGRES_PASSWORD myapppassword
ENV POSTGRES_DB myappdb
ENV DATABASE_URL postgres://myappuser:myapppassword@db:5432/myappdb

# Запускаем скрипт entrypoint
CMD ["/app/docker-entrypoint.sh", "db", "python", "manage.py", "runserver", "0.0.0.0:8000"]

# Этот `Dockerfile` выполняет следующие действия:

# 1. Берет базовый образ `python:3.8-slim-buster`.
# 2. Устанавливает рабочую директорию в `/app`.
# 3. Копирует содержимое текущей директории в `/app` внутри контейнера.
# 4. Выполняет обновление списка пакетов и устанавливает `postgresql-client`, `libpq-dev` (необходимо для `psycopg2`) и `build-essential`, после чего устанавливает зависимости Python из `requirements.txt`. Затем очищает кэш `apt` и удаляет списки пакетов для уменьшения размера образа.
# 5. Копирует и делает исполняемым скрипт `docker-entrypoint.sh`.
# 6. Открывает порт 8000.
# 7. Определяет переменные окружения.
# 8. Запускает скрипт `docker-entrypoint.sh` в качестве команды по умолчанию.
