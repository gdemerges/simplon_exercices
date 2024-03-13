from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
import time
import pandas as pd

driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()))

url = "https://www.welcometothejungle.com/fr/jobs?refinementList%5Boffices.country_code%5D%5B%5D=FR&refinementList%5Bcontract_type%5D%5B%5D=apprenticeship&page=1&query=data%20engineer"
driver.get(url)

time.sleep(5)

job_listings = driver.find_elements(By.CSS_SELECTOR, 'h4')
for title in job_listings[1:]:
    job_offer = title.text.strip()
    print(title.text)
    job_listings.append({
            "Titre": job_offer,
        })

df_jobs = pd.DataFrame(job_listings)
print(df_jobs.to_string)

driver.quit()
