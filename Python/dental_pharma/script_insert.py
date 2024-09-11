from sqlalchemy import create_engine, text
import pandas as pd
import os

# Définir le chemin relatif des fichiers CSV par rapport à la racine du projet
base_path = os.path.dirname(__file__)  # Chemin de la racine du projet
country_profile_path = os.path.join(base_path, 'data', 'cleaned_BigPharma-CountryProfile.csv')
project_data_path = os.path.join(base_path, 'data', 'cleaned_BigPharma-ProjectData.csv')

# Charger les données des CSV
country_profile_df = pd.read_csv(country_profile_path)
project_data_df = pd.read_csv(project_data_path)

print("CountryProfile Columns:", country_profile_df.columns)
print("ProjectData Columns:", project_data_df.columns)

# Créer une connexion à la base de données PostgreSQL
engine = create_engine('postgresql://guillaumedemerges:@localhost:5433/dental_pharma')

# Insérer les données dans la table CountryProfile
try:
    country_profile_df.to_sql('CountryProfile', engine, if_exists='append', index=False)
    print("Data inserted successfully into CountryProfile.")
except Exception as e:
    print(f"Error during data insertion into CountryProfile: {e}")

# Insérer les données dans la table ProjectData
try:
    project_data_df.to_sql('ProjectData', engine, if_exists='append', index=False)
    print("Data inserted successfully into ProjectData.")
except Exception as e:
    print(f"Error during data insertion into ProjectData: {e}")

# Vérifier le nombre de lignes insérées dans la table CountryProfile
try:
    with engine.connect() as connection:
        result = connection.execute(text("SELECT COUNT(*) FROM CountryProfile"))
        row_count = result.scalar()
        print(f"Number of rows in CountryProfile: {row_count}")
except Exception as e:
    print(f"Error during SQL execution: {e}")

# Vérifier le nombre de lignes insérées dans la table ProjectData
try:
    with engine.connect() as connection:
        result = connection.execute(text("SELECT COUNT(*) FROM ProjectData"))
        row_count = result.scalar()
        print(f"Number of rows in ProjectData: {row_count}")
except Exception as e:
    print(f"Error during SQL execution: {e}")
