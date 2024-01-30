## Mini Project
## Введение
Этот проект представляет собой веб-приложение, разработанное для демонстрации возможностей автоматизированного тестирования с использованием Pytest и Selenium. 
## Цель проекта 
- облегчить процесс тестирования веб-интерфейсов и баз данных для QA.
## Технологии
- Django для backend
- Pytest для написания тестов
- Selenium для автоматизации тестов веб-интерфейса
- Docker для контейнеризации приложения
## Требования
Для работы с проектом вам потребуется:
- Python (версия 3.8 или выше)
- Django (версия 3.1 или выше)
- Pytest (версия 6.0 или выше)
- Selenium WebDriver
## Использование
После запуска проекта, вы можете перейти к следующим URL:
- `http://localhost:8002` - Главная страница веб-приложения.
- `http://localhost:8081` - Интерфейс базы данных.
Для входа в систему используйте предварительно созданные учетные данные или зарегистрируйтесь для создания новой учетной записи.
## Примеры работы с приложением:
1. Создание нового пользователя:
   Перейдите на страницу регистрации `/register` и введите требуемые данные.
2. Вход в систему:
   Откройте страницу входа `/login` и введите свои учетные данные.
## Контрибуция
Если вы хотите внести свой вклад в проект, пожалуйста, следуйте следующему процессу:
1. Форкните репозиторий.
2. Создайте новую ветку для ваших изменений.
3. Сделайте коммиты в вашей ветке.
4. Отправьте pull request.
## Безопасность
Если вы обнаружите проблему безопасности, пожалуйста, сообщите об этом немедленно через приватное сообщение.
## Контактная информация
Для поддержки или вопросов свяжитесь с Ilnur по адресу ilnur.stybayev@gmail.com.
## Лицензия
Этот проект распространяется под лицензией MIT, полный текст которой можно найти в файле LICENSE в корне репозитория.
## Структура проекта
Описание структуры проекта и основных компонентов.
`config/`
- `settings.py`:        Настройки проекта Django.
- `urls.py`    :        Определение URL-адресов проекта.
`myapp/`
- `models.py`  :        Определения моделей Django.
- `views.py`   :        Определения представлений Django.
`docker-compose.yml`
Файл для запуска проекта с использованием Docker.

## Автоматизация тестирования
Инструкции по запуску тестов с использованием Pytest и Selenium.
pytest
pytest path/to/test_file.py
pytest --html=report.html


## Установка

1. Clone the repository:

git clone git@github.com:IlnurStybayev/Automated-Testing-Python.git

cd config

2.  Install dependencies:

pip install -r requirements.txt

3. Getting Started

Запуск проекта (включая веб-приложение, базу данных и миграции) одной командой:
chmod +x start_project.sh Делаем скрипт исполняемым.
ls -l start_project.sh проверяем точно ли файл start_project.sh стал исполняемым


source start_project.sh Запускаем проект
export DJANGO_SETTINGS_MODULE=config.settings
python manage.py collectstatic 


4. Running Migrations

docker-compose exec web python manage.py migrate

5. Starting the Database Container

docker-compose up -d db

6. Stopping the Project

docker-compose down -v

## Addition
1. Запуск и остановка контейнеров
docker-compose up                                                  - Запуск контейнеров в фоновом режиме.
                                                                   - Это означает, что они будут продолжать работать даже после закрытия терминала.
docker-compose up -d                                               - Запуск контейнеров в фоновом режиме с пересозданием образов.
                                                                   - Это означает, что контейнеры будут перезапущены, даже если они уже запущены.
docker-compose down                                                - Остановка и удаление контейнеров, а также удаление объемов и сетей, созданных docker-compose up.
                                                                   - Это означает, что все данные, созданные в контейнерах, будут потеряны.
docker-compose down -v                                             - Остановка и удаление контейнеров, сетей и объемов, но сохранение данных в объемах.
docker-compose rm -sv                                              - Удаление контейнеров, сетей и объемов, без остановки их работы.
docker rm -f $(docker ps -aq)                                      - Принудительное удаление всех контейнеров.
docker rmi -f $(docker images -aq)                                 - Принудительное удаление всех образов Docker.
2. Просмотр логов
docker-compose ps
docker-compose logs                                                - Просмотр логов
docker-compose logs db                                             - Просмотр логов контейнера базы данных.
docker-compose logs web                                            - Просмотр логов контейнера веб-приложения.
docker-compose restart python_test-web-1
docker-compose restart python_test-db-1
3. Подключение к базе данных
psql -h db -U myappuser -d myappdb                                 - Подключение к базе данных из хост-машины с использованием psql.
docker-compose exec web psql -h db -U myappuser -d myappdb         - Подключение к базе данных из контейнера веб-приложения с использованием psql.
jdbc:postgresql://db:5432/myappdb                                  - JDBC URL для подключения к базе данных из инструментов.
docker-compose exec web python -c "import psycopg2; conn = psycopg2.connect('dbname=myappdb user=myappuser password=myapppassword host=db'); conn.close()"                                                           - Проверка подключения к базе данных из хост-машины.
4. Работа с миграциями
docker-compose exec web python manage.py migrate                    - Запуск миграций Django.
5. Просмотр информации о сети
docker network inspect config_default                         - Просмотр информации о сети Docker.
tcpdump -n -i any port 5432                                         - Просмотр сетевого трафика между контейнерами с помощью tcpdump
nc -z db 5432                                                       - Проверка доступности порта базы данных.
lsof -i :8000                                                       - Проверка занятости порта 8000.
ps aux | grep PROCESS_NAME
kill 8000
kill -9 8000
6. Миграции 
docker-compose exec web python manage.py makemigrations myapp       - Создание Новых Миграций
docker-compose exec web python manage.py migrate                    - Применение Миграций:
python manage.py runserver










