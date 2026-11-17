CREATE TABLE IF NOT EXISTS practice_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS practice_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_status VARCHAR(30) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_practice_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES practice_customers(customer_id)
);

-- Sample data
-- If you run this script again, skip these INSERT statements
-- or remove the existing sample rows first.

INSERT INTO practice_customers (customer_id, customer_name, city)
VALUES
    (1, 'Ananya', 'Hyderabad'),
    (2, 'Rahul', 'Bengaluru'),
    (3, 'Priya', 'Chennai'),
    (4, 'Tara', 'Hyderabad'),
    (5, 'Rama', 'Mumbai');

INSERT INTO practice_orders (order_id, customer_id, order_status, total_amount)
VALUES
    (101, 1, 'DELIVERED', 450.00),
    (102, 1, 'DELIVERED', 650.00),
    (103, 2, 'CANCELLED', 300.00),
    (104, 3, 'DELIVERED', 800.00),
    (105, 4, 'PENDING', 250.00),
    (106, 4, 'DELIVERED', 550.00),
    (107, 5, 'FAILED', 200.00);


-- ------------------------------------------------------------
-- Q1. Find orders whose amount is greater than the average
--     order amount across all orders.
-- Inner query: returns one scalar value (the average).
-- ------------------------------------------------------------

SELECT *
FROM practice_orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM practice_orders
);


-- ------------------------------------------------------------
-- Q2. Find the order(s) with the minimum order amount.
-- Inner query: returns one scalar value (the minimum).
-- ------------------------------------------------------------

SELECT *
FROM practice_orders
WHERE total_amount = (
    SELECT MIN(total_amount)
    FROM practice_orders
);


-- ------------------------------------------------------------
-- Q3. Find customers who have placed at least one order.
-- Outer query returns customer records.
-- IN checks customer_id against the IDs returned by the subquery.
-- ------------------------------------------------------------

SELECT *
FROM practice_customers
WHERE customer_id IN (
    SELECT customer_id
    FROM practice_orders
);


-- ------------------------------------------------------------
-- Q4. Find orders whose amount is greater than the highest
--     order amount placed by customer 1.
-- Inner query returns customer 1's maximum order amount.
-- ------------------------------------------------------------

SELECT *
FROM practice_orders
WHERE total_amount > (
    SELECT MAX(total_amount)
    FROM practice_orders
    WHERE customer_id = 1
);


-- ------------------------------------------------------------
-- Q5. Find customers whose total spending is greater than
--     the average total spending per customer.
--
-- Step 1: The derived table calculates each customer's total.
-- Step 2: AVG calculates the average of those customer totals.
-- Step 3: HAVING keeps customers whose total is above that average.
-- ------------------------------------------------------------

SELECT
    customer_id,
    SUM(total_amount) AS total_spending
FROM practice_orders
GROUP BY customer_id
HAVING SUM(total_amount) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT
            customer_id,
            SUM(total_amount) AS customer_total
        FROM practice_orders
        GROUP BY customer_id
    ) AS customer_spending
);


-- ------------------------------------------------------------
-- Day 19 key reminders
-- 1. A subquery is a query nested inside another SQL query.
-- 2. A scalar subquery returns one value.
-- 3. A non-correlated subquery runs independently of the outer query.
-- 4. IN checks whether a value matches a value in a returned set.
-- 5. A derived table is a subquery used in the FROM clause.
-- ------------------------------------------------------------
