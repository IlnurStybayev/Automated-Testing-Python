# Dockerfile

# Используем официальный образ Python как базовый образ
FROM python:3.8-slim-buster

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Копируем содержимое текущей директории в контейнер в /app
COPY . /app

# Устанавливаем необходимые пакеты, указанные в requirements.txt
RUN apt-get update && \
    apt-get install -y postgresql-client && \
    pip install --no-cache-dir -r requirements.txt

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
