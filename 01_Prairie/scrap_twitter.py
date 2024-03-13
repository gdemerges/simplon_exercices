from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
import time
import pandas as pd

driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()))

url = "https://twitter.com/jobs/1750677768784982016?q=data%20engineer&lid=1721619397612322903&lval=Lyon%2C%20FR&lstr="
driver.get(url)

time.sleep(5)

job_listings = driver.find_elements(By.CSS_SELECTOR, 'span')
for title in job_listings[1:]:
    print(title.text)

driver.quit()
