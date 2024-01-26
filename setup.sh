# setup.sh

# chmod +x setup.sh Делаем скрипт исполняемым.
# source setup.sh Запускаем
# ls -l setup.sh проверяем точно ли файл Setup стал исполняемым
# which python
# pip freeze
# pip list
# rm -rf .pytest_cache




#!/bin/bash
# Активируем виртуальное окружение
source venv/bin/activate

# Устанавливаем зависимости из файла requirements.txt
if pip install -r requirements.txt; then
  echo "Все зависимости из requirements.txt установлены успешно."
else
  echo "Ошибка установки зависимостей из requirements.txt."
  exit 1
fi

# Установка Django
if pip install Django; then
  echo "Django успешно установлен."
else
  echo "Ошибка установки Django."
  exit 1
fi

# Установка psycopg2
if pip install psycopg2; then
  echo "psycopg2 успешно установлен."
else
  echo "Ошибка установки psycopg2."
  exit 1
fi

# Установка selenium
if pip install selenium; then
  echo "selenium успешно установлен."
else
  echo "Ошибка установки selenium."
  exit 1
fi

# Установка djangorestframework
if pip install djangorestframework; then
  echo "djangorestframework успешно установлен."
else
  echo "Ошибка установки djangorestframework."
  exit 1
fi

# Установка requests
if pip install requests; then
  echo "requests успешно установлен."
else
  echo "Ошибка установки requests."
  exit 1
fi

# Установка pytest
if pip install pytest; then
  echo "pytest успешно установлен."
else
  echo "Ошибка установки pytest."
  exit 1
fi

# Установка pytest-django
if pip install pytest-django; then
  echo "pytest-django успешно установлен."
else
  echo "Ошибка установки pytest-django."
  exit 1
fi

# Установка pytest-asyncio
if pip install pytest-asyncio; then
  echo "pytest-asyncio успешно установлен."
else
  echo "Ошибка установки pytest-asyncio."
  exit 1
fi

# Удаление кеша и временных файлов
rm -rf .pytest_cache

# Выводим сообщение о завершении установки
echo "Виртуальное окружение активировано и все зависимости установлены."