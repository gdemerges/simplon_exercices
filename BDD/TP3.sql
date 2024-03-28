CREATE DATABASE villes_france_db

USE villes_france_db

--Obtenir la liste des 10 villes les plus peuplées en 2012
SELECT ville_nom, ville_population_2012
FROM villes
ORDER BY ville_population_2012 DESC
LIMIT 10

--Obtenir la liste des 50 villes ayant la plus faible superficie
SELECT ville_nom, ville_surface
FROM villes
ORDER BY ville_surface
LIMIT 50

--Obtenir la liste des départements d’outres-mer, c’est-à-dire ceux dont le numéro de département commencent par “97”
SELECT departement_nom
FROM departement
WHERE departement_code LIKE '97%'

--Obtenir le nom des 10 villes les plus peuplées en 2012, ainsi que le nom du département associé
SELECT ville_nom, ville_departement, ville_population_2012
FROM villes
ORDER BY ville_population_2012 DESC
LIMIT 10

--Obtenir la liste du nom de chaque département, associé à son code et du nombre de commune au sein de ces département, en triant afin d’obtenir en priorité les départements qui possèdent le plus de communes
SELECT d.departement_nom, d.departement_code, COUNT(v.ville_nom) as nombre_communes
FROM departement d JOIN villes v ON d.departement_code = v.ville_departement
GROUP BY d.departement_nom, d.departement_code
ORDER BY nombre_communes DESC

--Obtenir la liste des 10 plus grands départements, en terme de superficie
SELECT d.departement_nom, SUM(v.ville_surface) as superficie
FROM departement d JOIN villes v ON d.departement_code = v.ville_departement
GROUP BY d.departement_nom, d.departement_code
ORDER BY superficie DESC
LIMIT 10

--Compter le nombre de villes dont le nom commence par “Saint”
SELECT ville_nom, COUNT(ville_nom)
FROM villes
WHERE ville_nom LIKE "Saint%"
GROUP BY ville_nom

--Obtenir la liste des villes qui ont un nom existants plusieurs fois, et trier afin d’obtenir en premier celles dont le nom est le plus souvent utilisé par plusieurs communes
SELECT ville_nom, COUNT(*) AS list_villes
FROM villes
GROUP BY ville_nom
HAVING COUNT(*) > 1
ORDER BY list_villes DESC, ville_nom;

--Obtenir en une seule requête SQL la liste des villes dont la superficie est supérieur à la superficie moyenne
SELECT ville_nom, ville_surface
FROM villes
WHERE ville_surface > (
    SELECT AVG(ville_surface) AS surface_moyenne
    FROM villes
)
ORDER BY ville_surface DESC;

--Obtenir la liste des départements qui possèdent plus de 2 millions d’habitants
SELECT d.departement_nom
FROM departement d JOIN villes v ON d.departement_code = v.ville_departement
WHERE ville_population_2012 > 2000000

--Remplacez les tirets par un espace vide, pour toutes les villes commençant par “SAINT-” (dans la colonne qui contient les noms en majuscule)
UPDATE villes
SET ville_nom = REPLACE(ville_nom, 'SAINT-', 'SAINT ')
WHERE ville_nom LIKE 'SAINT-%';
