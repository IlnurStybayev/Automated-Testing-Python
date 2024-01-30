from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from django.contrib.staticfiles.testing import StaticLiveServerTestCase
import logging
import unittest

# Настройка логирования
logger = logging.getLogger('selenium_tests')
logger.setLevel(logging.INFO)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# Консольный вывод
console_handler = logging.StreamHandler()
console_handler.setFormatter(formatter)
logger.addHandler(console_handler)

# Файловый вывод
file_handler = logging.FileHandler('selenium_tests.log')
file_handler.setFormatter(formatter)
logger.addHandler(file_handler)

class TaskSeleniumTests(StaticLiveServerTestCase):
    @classmethod
    def setUpClass(cls):
        super().setUpClass()
        # Если вы используете Chrome, убедитесь, что chromedriver установлен и находится в PATH.
        cls.selenium = webdriver.Chrome()
        cls.selenium.implicitly_wait(20)  # Увеличиваем время ожидания до 20 секунд
        logger.info('Настройка веб-драйвера завершена.')

    def test_create_task(self):
        # Шаг 1: Открытие главной страницы
        self.open_main_page()

        # Шаг 2: Добавление новой задачи
        task_name = 'New task'
        self.add_new_task(task_name)

        # Шаг 3: Проверка наличия задачи в списке
        self.verify_task_presence(task_name)

        # Шаг 4: Удаление задачи и проверка её отсутствия
        self.delete_task_and_verify(task_name)

    def open_main_page(self):
        logger.info("Шаг 1: Открытие главной страницы.")
        self.selenium.get(self.live_server_url)

    def add_new_task(self, task_name):
        logger.info("Шаг 2: Поиск поля ввода и кнопки для добавления задачи.")
        task_input = self.selenium.find_element(By.ID, 'new-task-title')
        submit_button = self.selenium.find_element(By.ID, 'add-task-button')

        logger.info(f"Шаг 3: Ввод текста задачи '{task_name}' и нажатие кнопки добавления.")
        task_input.send_keys(task_name)
        submit_button.click()

        logger.info("Шаг 4: Ожидание появления списка задач.")
        WebDriverWait(self.selenium, 20).until(
            EC.presence_of_element_located((By.ID, 'task-list'))
        )

    def verify_task_presence(self, task_name):
        logger.info("Шаг 5: Поиск элементов задачи и извлечение текста.")
        task_items = self.selenium.find_elements(By.CLASS_NAME, 'task-item')
        task_titles = [item.find_element(By.CLASS_NAME, 'task-title').text.strip() for item in task_items]

        logger.info(f"Извлеченные заголовки задач: {task_titles}")
        logger.info(f"Проверка наличия '{task_name}' в заголовках задач.")
        assert task_name in task_titles, f"'{task_name}' не найден в списке задач."

    def delete_task_and_verify(self, task_name):
        logger.info("Шаг 6: Удаление задачи и проверка её отсутствия.")
        task_items = self.selenium.find_elements(By.CLASS_NAME, 'task-item')
        for item in task_items:
            task_title = item.find_element(By.CLASS_NAME, 'task-title').text.strip()
            if task_name == task_title:
                delete_button = item.find_element(By.CLASS_NAME, 'delete-task-button')
                delete_button.click()
                break

        # Ожидание удаления задачи из списка
        WebDriverWait(self.selenium, 20).until_not(
            EC.text_to_be_present_in_element((By.ID, 'task-list'), task_name)
        )

if __name__ == '__main__':
    unittest.main()
