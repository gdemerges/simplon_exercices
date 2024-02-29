import requests
import json

def appel_api(nombre):
    url = f'https://api.breakingbadquotes.xyz/v1/quotes/{nombre}'
    try:
        response = requests.get(url)
        response.raise_for_status()
        print(response)
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"Erreur lors de l'appel à l'API : {e}")
        return None

response_data = appel_api("2")
if response_data:
    print("Réponse de l'API :", response_data)
else:
    print("Erreur lors de la récupération des informations sur les citations.")
