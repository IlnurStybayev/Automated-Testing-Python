import logging
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
import pytest

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

@pytest.mark.parametrize("task_name, updated_task_name", [
    ("Новая задача через Selenium", "Обновленная задача через Selenium"),
    ("Еще одна задача через Selenium", "Еще одна обновленная задача через Selenium")
])
def test_edit_task(browser, task_name, updated_task_name):
    logger.info(f"Тестирование добавления и редактирования задачи: {task_name} -> {updated_task_name}")
    browser.get('http://localhost:8002')
    logger.info("Открыта главная страница")

    # Добавление новой задачи
    new_task_input = WebDriverWait(browser, 10).until(
        EC.presence_of_element_located((By.ID, 'new-task-title'))
    )
    logger.info(f"Элемент ввода для новой задачи найден: {new_task_input}")
    new_task_input.send_keys(task_name + Keys.ENTER)
    logger.info(f"Введено название задачи и нажат Enter: {task_name}")

    # Проверка, что задача добавлена
    task_list = WebDriverWait(browser, 10).until(
        EC.presence_of_element_located((By.ID, 'task-list'))
    )
    logger.info(f"Список задач найден: {task_list}")
    tasks = task_list.find_elements(By.TAG_NAME, 'li')
    assert any(task_name in task.text for task in tasks), f"Задача '{task_name}' не найдена в списке задач"
    logger.info(f"Задача '{task_name}' успешно добавлена")

    # Открытие формы редактирования задачи
    edit_button = browser.find_element(By.CLASS_NAME, 'edit-task-button')
    logger.info(f"Найдена кнопка для редактирования задачи: {edit_button}")
    edit_button.click()
    logger.info("Кнопка редактирования задачи нажата")

    # Изменение названия задачи
    edit_task_input = WebDriverWait(browser, 10).until(
        EC.presence_of_element_located((By.ID, 'edit-task-title'))
    )
    logger.info(f"Элемент ввода для редактирования задачи найден: {edit_task_input}")
    edit_task_input.clear()
    logger.info("Поле ввода для редактирования задачи очищено")
    edit_task_input.send_keys(updated_task_name)
    logger.info(f"Введено новое название задачи: {updated_task_name}")

    # Сохранение изменений
    save_button = browser.find_element(By.ID, 'save-edit-task')
    logger.info(f"Найдена кнопка для сохранения изменений задачи: {save_button}")
    save_button.click()
    logger.info("Кнопка сохранения изменений задачи нажата")

    # Проверка, что название задачи изменилось
    try:
        WebDriverWait(browser, 10).until_not(
            EC.text_to_be_present_in_element((By.ID, 'task-list'), task_name)
        )
        logger.info(f"Название задачи изменено с '{task_name}' на '{updated_task_name}'")
    except TimeoutException:
        logger.error(f"Название задачи не было изменено в течение ожидаемого времени")

    task_list = browser.find_element(By.ID, 'task-list')
    tasks = task_list.find_elements(By.TAG_NAME, 'li')
    assert any(updated_task_name in task.text for task in tasks), f"Задача не была обновлена на '{updated_task_name}'"
    logger.info(f"Задача '{task_name}' успешно обновлена на '{updated_task_name}'")
