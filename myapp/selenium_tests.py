# python manage.py test myapp.selenium_tests

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from django.contrib.staticfiles.testing import StaticLiveServerTestCase

class TaskSeleniumTests(StaticLiveServerTestCase):
    @classmethod
    def setUpClass(cls):
        super().setUpClass()
        cls.selenium = webdriver.Chrome()
        cls.selenium.implicitly_wait(10)

    @classmethod
    def tearDownClass(cls):
        cls.selenium.quit()
        super().tearDownClass()

    def test_create_task(self):
        print("Step 1: Opening the main page.")
        self.selenium.get(self.live_server_url)

        print("Step 2: Finding input field and submit button.")
        task_input = self.selenium.find_element(By.ID, 'new-task-title')
        submit_button = self.selenium.find_element(By.ID, 'add-task-button')

        print("Step 3: Entering task text and clicking the submit button.")
        task_input.send_keys('New task')
        submit_button.click()

        print("Step 4: Waiting for the task list to appear.")
        WebDriverWait(self.selenium, 10).until(
            EC.presence_of_element_located((By.CLASS_NAME, 'task-item'))
        )

        print("Step 5: Finding task items and extracting text.")
        task_items = self.selenium.find_elements(By.CLASS_NAME, 'task-item')
        task_titles = [item.text for item in task_items]

        print(task_titles)

        print("Asserting that 'New task' is in task titles.")
        self.assertIn('New task', task_titles)
