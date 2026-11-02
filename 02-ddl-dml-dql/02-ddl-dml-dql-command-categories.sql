--1. DDL — Work with database structure
USE food_delivery_db;

CREATE TABLE IF NOT EXISTS restaurants (
                                           restaurant_id INT PRIMARY KEY,
                                           restaurant_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    rating DECIMAL(2,1)
    );
--Here, IF NOT EXISTS prevents an error if the table already exists. It doesn't modify a table that already exists.
--2. DML — Change the data inside tables
INSERT INTO restaurants
(restaurant_id, restaurant_name, city, rating)
VALUES
    (101, 'Deccan Bites', 'Hyderabad', 4.5),
    (102, 'Garden Plate', 'Bengaluru', 4.2),
    (103, 'Coastal Kitchen', 'Chennai', 4.0);

--Change one restaurant's rating:
UPDATE restaurants
SET rating = 4.7
WHERE restaurant_id = 101;

--Delete a particular record:
DELETE FROM restaurants
WHERE restaurant_id = 103;

--3. DQL — Retrieve data
SELECT *
FROM restaurants;

--Retrieve only specific columns:
SELECT restaurant_name, rating
FROM restaurants;

--Retrieve restaurants in Hyderabad:
SELECT restaurant_name, rating
FROM restaurants
WHERE city = 'Hyderabad';

--4. DCL — Control who can access data
--Suppose a reporting user needs permission to read restaurant data.
--A database administrator with the appropriate privileges could run:
GRANT SELECT
      ON food_delivery_db.restaurants
          TO 'report_user'@'localhost';

--To revoke that permission:
REVOKE SELECT
    ON food_delivery_db.restaurants
    FROM 'report_user'@'localhost';

--5. TCL — Manage transactions
CREATE TABLE IF NOT EXISTS transaction_demo (
                                                id INT PRIMARY KEY,
                                                note VARCHAR(100)
    );

START TRANSACTION;

INSERT INTO transaction_demo (id, note)
VALUES (1, 'Practice transaction');

SELECT * FROM transaction_demo;

ROLLBACK;

SELECT * FROM transaction_demo;