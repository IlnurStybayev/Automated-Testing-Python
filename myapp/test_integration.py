import pytest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import logging

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

@pytest.fixture
def browser():
    logger.info("Инициализация драйвера браузера")
    driver = webdriver.Chrome()
    driver.implicitly_wait(10)
    yield driver
    logger.info("Закрытие браузера")
    driver.quit()

@pytest.mark.parametrize("task_name", ["Новая задача через Selenium", "Еще одна задача через Selenium"])
def test_add_task(browser, task_name):
    logger.info(f"Тестирование добавления задачи: {task_name}")
    browser.get('http://localhost:8002')
    
    new_task_input = WebDriverWait(browser, 10).until(
        EC.presence_of_element_located((By.ID, 'new-task-title'))
    )
    
    new_task_input.send_keys(task_name + Keys.ENTER)
    
    task_list = WebDriverWait(browser, 10).until(
        EC.presence_of_element_located((By.ID, 'task-list'))
    )
    
    tasks = task_list.find_elements(By.TAG_NAME, 'li')
    assert any(task_name in task.text for task in tasks), f"Задача '{task_name}' не найдена в списке задач"
    logger.info(f"Задача '{task_name}' успешно добавлена")
