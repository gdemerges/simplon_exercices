import requests
from bs4 import BeautifulSoup
import pandas as pd

url = open('Emplois_Data_Engineer_Lyon.html')

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36',
    'Accept-Language': 'FR, en;q=0.5',
}

response = requests.get(url, headers=headers)
htmlData = response.content
if response.status_code == 200:
    soup = BeautifulSoup(htmlData, 'html.parser')

    jobs = soup.select('.css-zu9cdh li')

    jobs_data = []

    for job in jobs:

        poste = job.find('h2', class_ = "jobTitle").text


        jobs_data.append({'Poste': poste})

    df_jobs = pd.DataFrame(jobs_data)
    print(df_jobs.to_string())
    df_jobs.to_csv('jobs_indeed.csv', index=False)
else:
    print(f"Erreur lors de la récupération de la page : {response.status_code}")
