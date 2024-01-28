#!/bin/bash
# start_project.sh

# chmod +x start_project.sh Делаем скрипт исполняемым.
# source start_project.sh Запускаем
# ls -l start_project.sh проверяем точно ли файл Setup стал исполняемым

echo "Запуск Docker-контейнера с базой данных..."
docker-compose up -d db

if [ $? -ne 0 ]; then
  echo "Ошибка: Не удалось запустить Docker-контейнер с базой данных."
  exit 1
fi

echo "Ожидание запуска базы данных..."
sleep 10 # Ожидание нескольких секунд, чтобы убедиться, что база данных полностью запущена

# Проверяем наличие директории виртуального окружения
if [ ! -d "venv" ]; then
  echo "Виртуальное окружение не найдено. Пожалуйста, создайте его с помощью 'python -m venv venv'."
  exit 1
fi

# Активируем виртуальное окружение
source venv/bin/activate

if [ $? -ne 0 ]; then
  echo "Не удалось активировать виртуальное окружение."
  exit 1
fi

# Устанавливаем зависимости из файла requirements.txt
if ! pip install -r requirements.txt; then
  echo "Ошибка установки зависимостей из requirements.txt."
  exit 1
fi

echo "Все зависимости из requirements.txt установлены успешно."

# Применяем миграции
if ! python manage.py migrate; then
  echo "Ошибка применения миграций."
  exit 1
fi

echo "Миграции применены успешно."

# python manage.py collectstatic

# Запускаем сервер разработки
if ! python manage.py runserver 0.0.0.0:8002; then
  echo "Не удалось запустить сервер разработки."
  exit 1
fi
echo "Сервер разработки запущен на порту 8002."


# Удаление кеша и временных файлов pytest
rm -rf .pytest_cache

echo "Виртуальное окружение активировано и все зависимости установлены."


echo "Открытие веб-сайта в браузере по адресу http://localhost:8002..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    open http://localhost:8002
echo "Открытие веб-сайта в браузере по адресу http://localhost:8002..."
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open http://localhost:8002
echo "Открытие веб-сайта в браузере по адресу http://localhost:8002..."
elif [[ "$OSTYPE" == "msys"* ]]; then
    start http://localhost:8002
else
    echo "Неизвестная операционная система"
fi

echo "Открытие веб-сайта в браузере по адресу http://localhost:8002..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    open http://127.0.0.1:8002
echo "Открытие веб-сайта в браузере по адресу http://localhost:8002..."
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open http://127.0.0.1:8002
echo "Открытие веб-сайта в браузере по адресу http://localhost:8002..."
elif [[ "$OSTYPE" == "msys"* ]]; then
    start http://127.0.0.1:8002
else
    echo "Неизвестная операционная система"
fi


echo "Открытие веб-сайта в браузере по адресу http://localhost:8081..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    open http://localhost:8081
echo "Открытие веб-сайта в браузере по адресу http://localhost:8081..."
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open http://localhost:8081
echo "Открытие веб-сайта в браузере по адресу http://localhost:8081..."
elif [[ "$OSTYPE" == "msys"* ]]; then
    start http://localhost:8081
else
    echo "Неизвестная операционная система"
fi
