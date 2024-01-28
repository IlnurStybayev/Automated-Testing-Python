#!/bin/bash

# debug_info.sh

# chmod +x debug_info.sh Делаем скрипт исполняемым.
# source debug_info.sh Запускаем
# ls -l debug_info.sh проверяем точно ли файл debug_info.sh стал исполняемым

#!/bin/bash

# debug_info.sh

# Функция для добавления разделителя
{
print_divider() {
  echo "=================================================="
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

echo "==== Используемая версия Python ===="
which python
python3 --version

print_divider

echo "==== Установленные пакеты Python (pip list) ===="
pip list

print_divider

echo "==== Замороженные зависимости (pip freeze) ===="
pip freeze

print_divider

echo "==== Информация о системе ===="
uname -a

print_divider

echo "==== Состояние сетевых интерфейсов ===="
ifconfig

print_divider

echo "==== Текущие сетевые соединения ===="
netstat -plntu

print_divider

echo "==== Активные порты ===="
lsof -i -P -n | grep LISTEN

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

print_divider

echo "==== Конец отладочной информации ===="

# Сохранение лога в файл
} >> debug_log.txt 2>&1
