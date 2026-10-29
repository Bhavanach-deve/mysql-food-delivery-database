
-- =====================================================
-- Project: Food Delivery Database
-- Day 1: Database Fundamentals
-- Purpose: Create a database and  first table
-- =====================================================

-- 1. Create the project database
CREATE DATABASE food_delivery_db;

-- 2. Select the database
USE food_delivery_db;

-- 3. Create the customers table
CREATE TABLE customers (
                           customer_id INT PRIMARY KEY,
                           customer_name VARCHAR(100) NOT NULL,
                           city VARCHAR(50)
);

-- 4. Insert sample customer records
INSERT INTO customers
(customer_id, customer_name, city)
VALUES
    (1, 'Ananya', 'Hyderabad'),
    (2, 'Rahul', 'Bengaluru'),
    (3, 'Priya', 'Chennai');

-- 5. Retrieve all customer records
SELECT * FROM customers;

-- 6. Retrieve customers from Hyderabad
SELECT *
FROM customers
WHERE city = 'Hyderabad';
