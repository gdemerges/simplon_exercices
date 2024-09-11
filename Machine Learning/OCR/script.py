import json
import pytesseract
from pdf2image import convert_from_path
from PIL import Image
import psycopg2

# Charger les informations de connexion depuis le fichier config.json
with open('config.json', 'r') as config_file:
    config = json.load(config_file)

pdf_path = 'data/data-6537686d14dbc038702417.pdf'

# Convertir le PDF en images
images = convert_from_path(pdf_path)

extracted_text = []

for i, image in enumerate(images):
    # Extraction du texte de chaque image
    text = pytesseract.image_to_string(image, lang='eng')
    extracted_text.append(text)

# Fusion du texte de toutes les pages
full_text = "\n".join(extracted_text)

print(full_text)

# Extraire les données des voitures à partir du texte extrait
lines = full_text.split('\n')

headers = ["model", "mpg", "cyl", "disp", "hp", "drat", "wt", "qsec", "vs", "am", "gear", "carb"]

# Trouver la ligne où commencent les données des voitures
start_index = None
for i, line in enumerate(lines):
    if line.startswith("Mazda RX4"):
        start_index = i
        break

if start_index is not None:
    car_data = []
    for line in lines[start_index:]:
        # Diviser chaque ligne en colonnes basées sur les espaces
        columns = line.split()

        # Si la ligne contient le bon nombre de colonnes, l'ajouter aux données
        if len(columns) == len(headers):
            car_data.append(columns)
        else:
            break

    for car in car_data:
        print(car)

# Connexion à la base de données PostgreSQL en utilisant les informations de connexion du fichier config.json
conn = psycopg2.connect(
    dbname=config["dbname"],
    user=config["user"],
    password=config["password"],
    host=config["host"],
    port=config["port"]
)
cur = conn.cursor()

for car in car_data:
    query = """
    INSERT INTO cars (model, mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    cur.execute(query, car)

conn.commit()
cur.close()
conn.close()
