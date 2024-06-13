-- Active: 1712073882487@@127.0.0.1@5433@boutique@public
CREATE DATABASE Boutique;

CREATE TABLE Manufacturers (
    Code SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE Products (
    Code SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Manufacturer INT,
    FOREIGN KEY (Manufacturer) REFERENCES Manufacturers(Code)
);

INSERT INTO Manufacturers (Name) VALUES ('Sony');
INSERT INTO Manufacturers (Name) VALUES ('Creative Labs');
INSERT INTO Manufacturers (Name) VALUES ('Hewlett-Packard');
INSERT INTO Manufacturers (Name) VALUES ('Lenovo');
INSERT INTO Manufacturers (Name) VALUES ('Winchester');
INSERT INTO Manufacturers (Name) VALUES ('Apple');

INSERT INTO Products (Name, Price, Manufacturer) VALUES ('Hard drive', 240, 5);
INSERT INTO Products (Name, Price, Manufacturer) VALUES ('Memory', 120, 6);
INSERT INTO Products (Name, Price, Manufacturer) VALUES ('ZIP drive', 150, 4);
INSERT INTO Products (Name, Price, Manufacturer) VALUES ('Floppy Disk', 5, 6);
INSERT INTO Products (Name, Price, Manufacturer) VALUES ('Monitor', 240, 1);
INSERT INTO Products (Name, Price, Manufacturer) VALUES ('DVD Drive', 180, 2);
INSERT INTO Products (Name, Price, Manufacturer) VALUES ('CD Drive', 90, 2);
INSERT INTO Products (Name, Price, Manufacturer) VALUES ('Printer', 270, 3);
INSERT INTO Products (Name, Price, Manufacturer) VALUES ('Toner Cartridge', 66, 3);
INSERT INTO Products (Name, Price, Manufacturer) VALUES ('DVD Burner', 180, 2);


--1ère requête : Sélectionner les noms de tous les produits présents dans votre database
SELECT Name
FROM products;

--2ème requête : Sélectionner les noms et les prix de tous les produits présents dans votre database
SELECT Name, Price
FROM products;

--3ème requête : Sélectionner le nom des produits dont le prix est inférieur ou égal à 200$
SELECT Name
FROM products
WHERE price <= 200;

--4eme requête : Sélectionner tous les produits dont le prix est compris entre 50$ et 120$
SELECT *
FROM products
WHERE price BETWEEN 50 and 120;

--5eme requête : Sélectionner le nom et le prix en centimes (càd le prix doit être multiplié par 100)
SELECT Name, Price*100 as "Prix en centimes"
FROM products;

--6eme requête : Calculer le prix moyen de tous les produits
SELECT AVG(Price) as "Prix Moyen"
FROM products

--7eme requête : Calculer le prix moyen de tous les produits dont le code fabriquant est égal à 2
SELECT AVG(Price) as "Prix Moyen"
FROM products
WHERE manufacturer = 2

--8eme requête : Calculer le nombre de produits dont le prix est supérieur ou égal à 180$
SELECT COUNT(*) as "Nombre de produits"
FROM products
WHERE Price >= 180

--9eme requête : Sélectionner le nom et le prix de tous les produits dont le prix est supérieur ou égal à 180$, et trier par prix par ordre décroissant puis nom par ordre croissant
SELECT Name, Price
FROM products
WHERE Price >= 180
ORDER BY Price DESC, Name ASC;

--10ème requête : Sélectionner toutes les données des produits y compris les données relatives aux fabricants
SELECT *
FROM products p JOIN manufacturers m ON p.manufacturer = m.code

--11eme requête : Sélectionner le nom du produit, le prix et le nom du fabriquant de tous les produits
SELECT p.name, p.price, m.name
FROM products p JOIN manufacturers m ON p.manufacturer = m.code

--12eme requête : Calculer le prix moyen des produits de chaque fabricant, en indiquant uniquement celui-ci par son code.
SELECT m.code, AVG(p.price) AS "Prix moyen"
FROM products p JOIN manufacturers m ON p.manufacturer = m.code
GROUP BY m.code;

--13eme requête : Calculer le prix maximum d’un produit vendu par fabriquant.
SELECT MAX(Price) as "Prix maximum"
FROM products

--14eme requête : Sélectionner les noms des fabricants dont les produits ont un prix moyen supérieur ou égal à 150$
SELECT M.Name
FROM Manufacturers M
JOIN (
    SELECT Manufacturer, AVG(Price) AS AvgPrice
    FROM Products
    GROUP BY Manufacturer
    HAVING AVG(Price) >= 150
) P ON M.Code = P.Manufacturer;

--15eme requête : Sélectionner les noms et les prix du produit le moins cher et le plus cher
SELECT Name, Price
FROM Products
WHERE Price = (SELECT MIN(Price) FROM Products)
   OR Price = (SELECT MAX(Price) FROM Products);

--16eme requête : Ajouter un nouveau produit : Loudspeakers, 70$, manufacturer 2
INSERT INTO Products (Name, Price, Manufacturer)
VALUES ('Loudspeakers', 70, 2);

--17eme requête : Mettre à jour le nom du produit 8 en « Laser Print »
UPDATE Products
SET Name = 'Laser Print'
WHERE Code = 8;

--18eme requête : Appliquer une remise de 10% à tous les produits et stocker ce résultat dans une nouvelle colonne de la table
ALTER TABLE Products
ADD COLUMN Discount DECIMAL(10, 2);

UPDATE Products
SET Discount = Price * 0.90;

SELECT *
FROM products

--19eme requête : Appliquer une remise de 10% à tous les produits dont le prix est supérieur ou égal à 120$
UPDATE Products
SET Discount = Price * 0.90
WHERE Price >= 120;

UPDATE Products
SET Discount = Price
WHERE Price < 120;
