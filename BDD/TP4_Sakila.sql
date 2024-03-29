USE sakila

--Afficher les 5 premiers Records de la table Actor
SELECT first_name, last_name
FROM actor
LIMIT 5

--Récupérer dans une colonne Actor_Name le full_name des acteurs sous le format: first_name + " " + last_name
SELECT CONCAT(first_name, " ",last_name) AS full_name
FROM actor

--Récupérer dans une colonne Actor_Name le full_name des acteurs sous le format: first_name en minuscule + "." + last_name en majuscule
SELECT CONCAT(LOWER(first_name), ".",UPPER(last_name)) AS full_name
FROM actor

--Récupérer dans une colonne Actor_Name le full_name des acteurs sous le format: last_name en majuscule + "." + premiere lettre du first_name en majuscule
SELECT CONCAT(UPPER(last_name), ".",UPPER(LEFT(first_name, 1))) AS full_name
FROM actor

--Trouver le ou les acteurs appelé(s) "JENNIFER"
SELECT *
FROM actor
WHERE first_name = "JENNIFER"

--Trouver les acteurs ayant des prénoms de 3 charactères.
SELECT first_name
FROM actor
WHERE LENGTH(first_name) = 3

--Afficher les acteurs (actor_id, first_name, last_name, nbre char first_name, nbre char last_name )par ordre décroissant de longueur de prénoms
SELECT *
FROM actor
ORDER BY LENGTH(first_name) DESC

--Afficher les acteurs (actor_id, first_name, last_name, nbre char first_name, nbre char last_name )par ordre décroissant de longueur de prénoms et croissant de longuer de noms
SELECT actor_id, first_name, last_name, LENGTH(first_name) AS nbre_char_first_name, LENGTH(last_name) AS nbre_char_last_name
FROM actor
ORDER BY LENGTH(first_name) DESC, last_name ASC

--Trouver les acteurs ayant dans leurs last_names la chaine: "SON
SELECT *
FROM actor
WHERE last_name LIKE "%SON%"

--Trouver les acteurs ayant des last_names commençant par la chaine: "JOH"
SELECT *
FROM actor
WHERE last_name LIKE "JOH%"

--Afficher par ordre alphabétique croissant les last_names et les first_names des acteurs ayant dans leurs last_names la chaine "LI"
SELECT last_name, first_name
FROM actor
WHERE last_name LIKE "%LI%"
ORDER BY last_name ASC, first_name ASC

--trouver dans la table country les countries "China", "Afghanistan", "Bangladesh"
SELECT *
FROM country
WHERE country IN ("China", "Afghanistan", "Bangladesh")

--Ajouter une colonne middle_name entre les colonnes first_name et last_name
ALTER TABLE actor
ADD middle_name VARCHAR(45) AFTER first_name

--Changer le data type de la colonne middle_name au type blobs
ALTER TABLE actor
MODIFY COLUMN middle_name BLOB;

--Supprimer la colonne middle_name
ALTER TABLE actor
DROP middle_name

--Trouver le nombre des acteurs ayant le meme last_name Afficher le resultat par ordre décroissant
SELECT last_name, COUNT(last_name) as nbr_actor
FROM actor
GROUP BY last_name
HAVING nbr_actor >= 2
ORDER BY last_name DESC

--Trouver le nombre des acteurs ayant le meme last_name Afficher UNIQUEMENT les last_names communs à au moins 3 acteurs Afficher par ordre alph. croissant
SELECT last_name, COUNT(last_name) AS nbr_actor
FROM actor
GROUP BY last_name
HAVING nbr_actor >= 3
ORDER BY last_name ASC

--Trouver le nombre des acteurs ayant le meme first_name Afficher le resultat par ordre alph. croissant
SELECT first_name, COUNT(first_name) AS nbr_actor
FROM actor
GROUP BY first_name
HAVING nbr_actor >= 2
ORDER BY first_name ASC

--Insérer dans la table actor ,un nouvel acteur , faites attention à l'id!
INSERT INTO actor (first_name, last_name, last_update)
 VALUES ('Emma', 'Watson', '2024-02-15 04:34:33')


SELECT *
FROM actor
WHERE first_name IN ('Emma')

 --Modifier le first_name du nouvel acteur à "Jean"
UPDATE actor
SET first_name = 'Jean'
WHERE actor_id = '201'

--Supprimer le dernier acteur inséré de la table actor
DELETE FROM actor
WHERE actor_id = '201'

--Corriger le first_name de l'acteur HARPO WILLIAMS qui était accidentellement inséré à GROUCHO WILLIAMS
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = "WILLIAMS"

--Mettre à jour le first_name dans la table actor pour l'actor_id 173 comme suit: si le first_name ="ALAN" alors remplacer le par "ALLAN" sinon par "MUCHO ALLAN"
UPDATE actor
SET first_name = CASE
    WHEN first_name = 'ALAN' THEN 'ALLAN'
    ELSE 'MUCHO ALLAN'
END
WHERE actor_id = 173;

--Trouver les first_names,last names et l'adresse de chacun des membre staff RQ: utiliser join avec les tables staff & address:
SELECT s.first_name, s.last_name, a.address
FROM staff s JOIN address a ON s.address_id = a.address_id

--Afficher pour chaque membre du staff ,le total de ses salaires depuis Aout 2005. RQ: Utiliser les tables staff & payment.
SELECT s.staff_id, s.first_name, s.last_name, SUM(p.amount) AS total_salaires
FROM staff s JOIN payment p ON s.staff_id = p.staff_id
WHERE p.payment_date >= '2005-08-01'
GROUP BY s.staff_id, s.first_name, s.last_name
ORDER BY total_salaires DESC;

--Afficher pour chaque film ,le nombre de ses acteurs
SELECT f.film_id, f.title, SUM(fa.actor_id)
FROM film_actor fa JOIN film f ON fa.film_id = f.film_id
GROUP BY film_id

--Trouver le film intitulé "Hunchback Impossible"
SELECT *
FROM film
WHERE title IN ("Hunchback Impossible")

--combien de copies exist t il dans le systme d'inventaire pour le film Hunchback Impossible
SELECT f.title, COUNT(i.inventory_id) as nbr_copies
FROM film f JOIN inventory i ON f.film_id = i.film_id
WHERE title IN ("Hunchback Impossible")

--Afficher les titres des films en anglais commençant par 'K' ou 'Q'
SELECT f.title
FROM film f JOIN language l ON f.language_id = l.language_id
WHERE l.name = 'English'
AND (f.title LIKE 'K%' OR f.title LIKE 'Q%');

--Afficher les first et last names des acteurs qui ont participé au film intitulé 'ACADEMY DINOSAUR'
SELECT a.first_name, a.last_name
FROM actor a JOIN film_actor fa ON a.actor_id = fa.actor_id
              JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'ACADEMY DINOSAUR'

--Trouver la liste des film catégorisés comme family films.
SELECT f.title
FROM film f JOIN film_category fc ON f.film_id = fc.film_id
              JOIN category c ON fc.category_id = c.category_id
WHERE c.name = "Family"

--Afficher le top 5 des films les plus loués par ordre decroissant
SELECT f.title, COUNT(r.rental_id) as film_loue
FROM film f JOIN inventory i ON f.film_id = i.film_id
              JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY film_loue DESC
LIMIT 5

--Afficher la liste des stores : store ID, city, country
SELECT s.store_id, c.city, co.country
FROM store s JOIN address a ON s.address_id = a.city_id
              JOIN city c ON a.city_id = c.city_id
                JOIN country co ON c.country_id = co.country_id

--Afficher le chiffre d'affaire par store. RQ: le chiffre d'affaire = somme (amount)
SELECT s.store_id, SUM(p.amount)
FROM store s JOIN staff st ON s.store_id = st.store_id
              JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id

--Lister par ordre décroissant le top 5 des catégories ayant le plus des revenues. RQ utiliser les tables : category, film_category, inventory, payment, et rental
SELECT c.name, SUM(p.amount) as cat_revenu
FROM category c JOIN film_category fc ON c.category_id = fc.category_id
                  JOIN inventory i ON fc.film_id = i.film_id
                    JOIN store s ON i.store_id = s.store_id
                      JOIN customer cu ON s.store_id = cu.store_id
                        JOIN payment p ON cu.customer_id = p.customer_id
                          JOIN rental r ON p.rental_id = r.rental_id
GROUP BY c.category_id, c.name
ORDER BY cat_revenu DESC
LIMIT 5;
