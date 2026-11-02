
-- Day 4: SQL CRUD Operations
-- Project: Food Delivery Database

USE food_delivery_db;

-- CREATE: Insert a new customer
INSERT INTO customers
(customer_id, customer_name, city)
VALUES
    (7, 'Sneha', 'Hyderabad');

-- READ: Retrieve all customers
SELECT *
FROM customers;

-- READ: Retrieve a specific customer
SELECT *
FROM customers
WHERE customer_id = 7;

-- UPDATE: Change customer city
UPDATE customers
SET city = 'Chennai'
WHERE customer_id = 7;

-- Verify the update
SELECT *
FROM customers
WHERE customer_id = 7;

-- DELETE: Remove the practice customer
-- Run only after verifying the customer ID.
DELETE FROM customers
WHERE customer_id = 7;

-- Verify deletion
SELECT *
FROM customers
WHERE customer_id = 7;
