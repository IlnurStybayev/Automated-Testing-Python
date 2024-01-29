#!/bin/bash

# debug_info.sh

LOG_FILE="debug_log.txt" # Имя файла для сохранения лога

# Сохраняем лог в файл
{
# Функция для добавления разделителя
print_divider() {
  echo "=================================================="
}

# Функция для проверки наличия команды
check_command() {
  if ! command -v "$1" &> /dev/null; then
    echo "Команда $1 не найдена."
    return 1
  fi
  return 0
}

# Функция для вывода информации о команде
print_command_info() {
  if check_command "$1"; then
    echo "Используемая версия $1: $($1 --version)"
    echo "Путь к $1: $(which "$1")"
  fi
}

echo "==== Дата и время ===="
date

print_divider

echo "==== Пользователь, выполняющий скрипт ===="
whoami

print_divider

echo "==== Текущая директория ===="
pwd

print_divider

echo "==== Состояние виртуальной среды Python ===="
if [ -d "venv" ]; then
  echo "Виртуальная среда найдена в директории 'venv'."
else
  echo "Виртуальная среда не найдена."
fi

print_divider

echo "==== Список запущенных процессов Python ===="
ps aux | grep python

print_divider

echo "==== Используемая версия Python и путь ===="
print_command_info python3

print_divider

if check_command pip; then
  echo "==== Установленные пакеты Python (pip list) ===="
  pip list
  
  print_divider
  
  echo "==== Замороженные зависимости (pip freeze) ===="
  pip freeze
fi

print_divider

echo "==== Информация о системе ===="
uname -a

print_divider

echo "==== Состояние сетевых интерфейсов ===="
if check_command ifconfig; then
  ifconfig
fi

print_divider

echo "==== Текущие сетевые соединения ===="
if check_command netstat; then
  netstat -plntu
fi

print_divider

echo "==== Активные порты ===="
if check_command lsof; then
  lsof -i -P -n | grep LISTEN
fi

print_divider

echo "==== Состояние использования диска ===="
df -h

print_divider

echo "==== Использование памяти и процессора ===="
top -l 1 | head -n 10  # Только первые 10 строк для macOS

print_divider

echo "==== Проверка доступности интернета (ping google.com) ===="
ping -c 4 google.com

print_divider

if check_command docker; then
  echo "==== Информация о Docker ===="
  docker info

  print_divider

  echo "==== Состояние Docker контейнеров ===="
  docker ps -a

  print_divider

  echo "==== Использование ресурсов Docker контейнерами ===="
  docker stats --no-stream

  print_divider

  echo "==== Логи Docker контейнеров ===="
  # Замените "container_name" на имя вашего контейнера
  # docker logs container_name
fi

print_divider

echo "==== Конец отладочной информации ===="
} >> "$LOG_FILE" 2>&1
