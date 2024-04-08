import webbrowser
from prettytable import PrettyTable
from rembg import remove
from PIL import Image

# PrettyTable
table = PrettyTable(["Nom de la ville", "Pays", "Population"])

table.add_row(["Paris", "France", "2,148,271"])
table.add_row(["Tokyo", "Japon", "9,273,000"])
table.add_row(["New York", "USA", "8,336,817"])

print(table)

# Google Earth
def find_city_on_google_earth(city_name):
    google_earth_url = f'https://earth.google.com/web/search/{city_name}'

    webbrowser.open(google_earth_url)

find_city_on_google_earth("New York City")

# Remove background
input_path = '/Users/guillaumedemerges/code/simplon/Veille/img/team.jpg'
output_path = '/Users/guillaumedemerges/code/simplon/Veille/img/output3.png'
input = Image.open(input_path)
output = remove(input)
output.save(output_path)
