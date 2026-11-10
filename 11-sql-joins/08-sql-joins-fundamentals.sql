
-- ==========================================
-- DAY 11: SQL JOIN FUNDAMENTALS
-- Food Delivery Database Practice
-- ==========================================

-- 1. Create a separate practice database
CREATE DATABASE IF NOT EXISTS join_practice_db;
USE join_practice_db;

-- 2. Remove old practice tables (safe dependency order)
DROP TABLE IF EXISTS practice_orders;
DROP TABLE IF EXISTS practice_customers;

-- 3. Create customers table
CREATE TABLE practice_customers (
                                    customer_id INT PRIMARY KEY,
                                    customer_name VARCHAR(100) NOT NULL,
                                    city VARCHAR(50)
);

-- 4. Create orders table
CREATE TABLE practice_orders (
                                 order_id INT PRIMARY KEY,
                                 customer_id INT NOT NULL,
                                 total_amount DECIMAL(10,2) NOT NULL,
                                 FOREIGN KEY (customer_id)
                                     REFERENCES practice_customers(customer_id)
);

-- 5. Insert customers
INSERT INTO practice_customers
(customer_id, customer_name, city)
VALUES
    (1, 'Ananya', 'Hyderabad'),
    (2, 'Rahul', 'Chennai'),
    (3, 'Priya', 'Bengaluru'),
    (4, 'Sneha', 'Hyderabad');

-- 6. Insert orders
INSERT INTO practice_orders
(order_id, customer_id, total_amount)
VALUES
    (101, 1, 450.00),
    (102, 2, 300.00),
    (103, 1, 650.00);

-- ==========================================
-- BASIC TABLE CHECKS
-- ==========================================

SELECT * FROM practice_customers;
SELECT * FROM practice_orders;

-- ==========================================
-- QUESTION 1:
-- Display customer names and their order IDs.
-- ==========================================

SELECT
    c.customer_name,
    o.order_id
FROM practice_customers c
         INNER JOIN practice_orders o
                    ON c.customer_id = o.customer_id;

-- ==========================================
-- QUESTION 2:
-- Display customer names, order IDs,
-- and order amounts.
-- ==========================================

SELECT
    c.customer_name,
    o.order_id,
    o.total_amount
FROM practice_customers c
         INNER JOIN practice_orders o
                    ON c.customer_id = o.customer_id;

-- ==========================================
-- QUESTION 3:
-- Display only Ananya's orders.
-- ==========================================

SELECT
    c.customer_name,
    o.order_id,
    o.total_amount
FROM practice_customers c
         INNER JOIN practice_orders o
                    ON c.customer_id = o.customer_id
WHERE c.customer_name = 'Ananya';

-- ==========================================
-- QUESTION 4:
-- Display all matching orders from
-- highest amount to lowest amount.
-- ==========================================

SELECT
    c.customer_name,
    o.order_id,
    o.total_amount
FROM practice_customers c
         INNER JOIN practice_orders o
                    ON c.customer_id = o.customer_id
ORDER BY o.total_amount DESC;

-- ==========================================
-- QUESTION 5:
-- Find customers who have placed orders
-- worth more than 400.
-- ==========================================

SELECT
    c.customer_name,
    o.order_id,
    o.total_amount
FROM practice_customers c
         INNER JOIN practice_orders o
                    ON c.customer_id = o.customer_id
WHERE o.total_amount > 400;

-- ==========================================
-- QUESTION 6:
-- Count how many matching order rows
-- each customer has.
-- GROUP BY will be studied separately.
-- ==========================================

SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM practice_customers c
         INNER JOIN practice_orders o
                    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;
