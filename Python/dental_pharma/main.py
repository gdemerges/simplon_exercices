import pandas as pd

country_profile_df = pd.read_csv('/Users/guillaumedemerges/code/dental_pharma/data/cleaned_BigPharma-CountryProfile.csv')
project_data_df = pd.read_csv('/Users/guillaumedemerges/code/dental_pharma/data/cleaned_BigPharma-ProjectData.csv')

# Fusionner les deux datasets pour inclure l'information régionale dans les données des projets
merged_df = pd.merge(project_data_df, country_profile_df, on='Country', how='left')

# Calculer les indicateurs requis
merged_df['Cost_Progress'] = (merged_df['Actual_Cost'] / merged_df['Planned_Cost']) * 100
merged_df['Deadline_Progress'] = (merged_df['Actual_Duration'] / merged_df['Planned_Duration']) * 100

# Résumé global
global_summary = merged_df[['Var_Deliverables', 'Cost_Progress', 'Deadline_Progress']].mean()

# Résumé régional
regional_summary = merged_df.groupby('Region').agg({
    'Var_Deliverables': 'mean',
    'Cost_Progress': 'mean',
    'Deadline_Progress': 'mean'
})

# Résumé national
national_summary = merged_df.groupby('Country').agg({
    'Var_Deliverables': 'mean',
    'Cost_Progress': 'mean',
    'Deadline_Progress': 'mean'
})

# Affichage des résumés
print("Résumé global :\n", global_summary)
print("\nRésumé régional :\n", regional_summary)
print("\nRésumé national :\n", national_summary)

global_summary.to_csv('global_summary.csv', index=False)
regional_summary.to_csv('regional_summary.csv')
national_summary.to_csv('national_summary.csv')
