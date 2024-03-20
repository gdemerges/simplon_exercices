--Requêtes SQL pour une veille

--Création de la base de donnée
CREATE DATABASE school

USE school;

--Création tables

-- Création de la table Enseignants
CREATE TABLE Enseignants (
    ID_Enseignant INT PRIMARY KEY,
    Nom VARCHAR(100),
    Prenom VARCHAR(100),
    Specialite VARCHAR(100)
);

-- Création de la table Classes
CREATE TABLE Classes (
    ID_Classe INT PRIMARY KEY,
    NomClasse VARCHAR(50),
    ID_EnseignantPrincipal INT,
    FOREIGN KEY (ID_EnseignantPrincipal) REFERENCES Enseignants(ID_Enseignant)
);

-- Création de la table Élèves
CREATE TABLE Eleves (
    ID_Eleve INT PRIMARY KEY,
    Nom VARCHAR(100),
    Prenom VARCHAR(100),
    DateNaissance DATE,
    Adresse VARCHAR(255),
    ID_Classe INT,
    FOREIGN KEY (ID_Classe) REFERENCES Classes(ID_Classe)
);

-- Création de la table Cours
CREATE TABLE Cours (
    ID_Cours INT PRIMARY KEY,
    NomCours VARCHAR(100),
    ID_Enseignant INT,
    FOREIGN KEY (ID_Enseignant) REFERENCES Enseignants(ID_Enseignant)
);

-- Création de la table Programmes
CREATE TABLE Programmes (
    ID_Programme INT PRIMARY KEY,
    ID_Classe INT,
    ID_Cours INT,
    Horaire VARCHAR(50),
    FOREIGN KEY (ID_Classe) REFERENCES Classes(ID_Classe),
    FOREIGN KEY (ID_Cours) REFERENCES Cours(ID_Cours)
);

-- Création de la table Notes
CREATE TABLE Notes (
    ID_Note INT PRIMARY KEY,
    ID_Eleve INT,
    ID_Cours INT,
    Note DECIMAL(5,2),
    Commentaires TEXT,
    FOREIGN KEY (ID_Eleve) REFERENCES Eleves(ID_Eleve),
    FOREIGN KEY (ID_Cours) REFERENCES Cours(ID_Cours)
);

--Insertion des valeurs dans les tables
INSERT INTO Enseignants (ID_Enseignant, Nom, Prenom, Specialite) VALUES
(1, 'Durand', 'Marie', 'Mathématiques'),
(2, 'Leblanc', 'Jean', 'Histoire'),
(3, 'Martin', 'Isabelle', 'Sciences');

INSERT INTO Classes (ID_Classe, NomClasse, ID_EnseignantPrincipal) VALUES
(1, '6ème A', 1),
(2, '5ème B', 2),
(3, '4ème C', 3);

INSERT INTO Eleves (ID_Eleve, Nom, Prenom, DateNaissance, Adresse, ID_Classe) VALUES
(1, 'Petit', 'Lucas', '2010-05-23', '123 Rue de Paris', 1),
(2, 'Dupont', 'Emma', '2009-07-12', '456 Avenue de France', 2),
(3, 'Leroy', 'Hugo', '2008-03-18', '789 Boulevard de la République', 3);

INSERT INTO Cours (ID_Cours, NomCours, ID_Enseignant) VALUES
(1, 'Mathématiques', 1),
(2, 'Histoire', 2),
(3, 'Sciences', 3);

INSERT INTO Programmes (ID_Programme, ID_Classe, ID_Cours, Horaire) VALUES
(1, 1, 1, 'Lundi 10h-11h'),
(2, 2, 2, 'Mardi 14h-15h'),
(3, 3, 3, 'Mercredi 9h-10h');

INSERT INTO Notes (ID_Note, ID_Eleve, ID_Cours, Note, Commentaires) VALUES
(1, 1, 1, 15.5, 'Très bien'),
(2, 2, 2, 14.0, 'Bon travail'),
(3, 3, 3, 16.0, 'Excellent');

--1. Obtenir la liste des élèves d'une classe spécifique
SELECT E.Nom, E.Prenom, E.DateNaissance, E.Adresse
FROM Eleves E
JOIN Classes C ON E.ID_Classe = C.ID_Classe
WHERE C.NomClasse = '6ème A';

--2. Trouver les cours enseignés par un enseignant spécifique
SELECT C.NomCours
FROM Cours C
JOIN Enseignants E ON C.ID_Enseignant = E.ID_Enseignant
WHERE E.Nom = 'Durand' AND E.Prenom = 'Marie';

--3. Lister tous les enseignants et leur spécialité
SELECT *
FROM Enseignants;

--4. Obtenir les notes d'un élève pour tous ses cours
SELECT E.Nom, E.Prenom, C.NomCours, N.Note, N.Commentaires
FROM Notes N
JOIN Eleves E ON N.ID_Eleve = E.ID_Eleve
JOIN Cours C ON N.ID_Cours = C.ID_Cours
WHERE E.Nom = 'Petit' AND E.Prenom = 'Lucas';

--5. Afficher l'horaire des cours pour une classe donnée
SELECT CL.NomClasse, CO.NomCours, P.Horaire
FROM Programmes P
JOIN Classes CL ON P.ID_Classe = CL.ID_Classe
JOIN Cours CO ON P.ID_Cours = CO.ID_Cours
WHERE CL.NomClasse = '5ème B';

--6. Calculer la moyenne des notes pour un cours spécifique
SELECT AVG(N.Note) AS MoyenneNote
FROM Notes N
JOIN Cours C ON N.ID_Cours = C.ID_Cours
WHERE C.NomCours = 'Mathématiques';

--7. Permet de trouver les cours ayant une moyenne de notes supérieure à 14
SELECT ID_Cours, AVG(Note) AS Moyenne
FROM Notes
GROUP BY ID_Cours
HAVING AVG(Note) > 14;

--8. Recherche tous les élèves dont le nom commence par "Du"
SELECT *
FROM Eleves
WHERE Nom LIKE 'Du%';

--9. Augmenter toutes les notes de 10 % pour le cours de Mathématiques
UPDATE Notes
SET Note = Note * 1.10
WHERE ID_Cours = 1;

--10. supprimer tous les élèves qui n'ont pas de notes enregistrées
DELETE FROM Eleves
WHERE ID_Eleve NOT IN (SELECT DISTINCT ID_Eleve FROM Notes);
