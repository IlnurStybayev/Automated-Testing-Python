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

RUN chmod +x /app/runserver.sh

# Открываем порт 8000 для внешнего мира
# EXPOSE 8000

# Определяем переменные окружения
ENV NAME World
ENV POSTGRES_USER myappuser
ENV POSTGRES_PASSWORD myapppassword
ENV POSTGRES_DB myappdb
ENV DATABASE_URL postgres://myappuser:myapppassword@db:5432/myappdb

# Запускаем скрипт runserver.sh
ENTRYPOINT ["/app/runserver.sh"]
