#python test_selenium.py

from selenium import webdriver

driver = webdriver.Chrome()
driver.get("http://www.google.com")
print(driver.title)  # Должно вывести заголовок страницы Google
driver.quit()
