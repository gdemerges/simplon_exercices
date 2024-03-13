import requests
from bs4 import BeautifulSoup
import pandas as pd

url = 'https://www.imdb.com/chart/top/'

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36',
    'Accept-Language': 'FR, en;q=0.5',
}

response = requests.get(url, headers=headers)
htmlData = response.content
if response.status_code == 200:
    soup = BeautifulSoup(htmlData, 'html.parser')

    films = soup.select('.ipc-metadata-list li')

    films_data = []

    for film in films:
        metadata_div = film.find('div', class_='sc-b0691f29-7 hrgukm cli-title-metadata')
        metadata_items = metadata_div.find_all('span', class_='sc-b0691f29-8 ilsLEX cli-title-metadata-item')

        titre = film.find('h3').text

        annee = metadata_items[0].text

        duree = metadata_items[1].text

        score_test = film.find('span', class_ = 'ipc-rating-star--base')
        score = score_test.get_text().split('\xa0')[0]

        films_data.append({'Titre': titre, 'Année': annee, 'Durée': duree, 'Score' : score})

    df_films = pd.DataFrame(films_data)
    print(df_films)
    df_films.to_csv('out.csv', index=False)
else:
    print(f"Erreur lors de la récupération de la page : {response.status_code}")
