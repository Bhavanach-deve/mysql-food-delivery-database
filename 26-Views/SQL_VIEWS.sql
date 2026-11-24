-- =========================================================
-- DAY 26: SQL VIEWS
-- Database: MySQL Food Delivery Database
-- Topics: CREATE VIEW, REPLACE VIEW, UPDATE VIEW,
--         WITH CHECK OPTION, DROP VIEW
-- =========================================================


-- =========================================================
-- PART A: CREATING VIEWS
-- =========================================================


-- Q1. Create a view displaying completed orders.

CREATE VIEW completed_orders AS
SELECT
    order_id,
    customer_id,
    restaurant_id,
    total_amount
FROM orders
WHERE status = 'COMPLETED';

-- Retrieve the view
SELECT * FROM completed_orders;


-- Q2. Create a view displaying orders above 1000.

CREATE VIEW high_value_orders AS
SELECT
    order_id,
    customer_id,
    restaurant_id,
    total_amount
FROM orders
WHERE total_amount > 1000;

SELECT * FROM high_value_orders;


-- Q3. Create a view containing customer order details
-- using JOIN.

CREATE VIEW customer_order_details AS
SELECT
    o.order_id,
    c.customer_name,
    o.total_amount,
    o.status
FROM orders o
         JOIN customers c
              ON o.customer_id = c.customer_id;

SELECT * FROM customer_order_details;


-- Q4. Create a restaurant revenue summary view.

CREATE VIEW restaurant_revenue AS
SELECT
    restaurant_id,
    SUM(total_amount) AS total_revenue,
    COUNT(*) AS completed_orders
FROM orders
WHERE status = 'COMPLETED'
GROUP BY restaurant_id;

SELECT * FROM restaurant_revenue;


-- =========================================================
-- PART B: MODIFYING VIEWS
-- =========================================================


-- Q5. Replace completed_orders to show only completed
-- orders above 500.

CREATE OR REPLACE VIEW completed_orders AS
SELECT
    order_id,
    customer_id,
    total_amount
FROM orders
WHERE status = 'COMPLETED'
  AND total_amount > 500;

SELECT * FROM completed_orders;


-- Q6. Create a basic customer details view and update
-- a customer's city through the view.

CREATE VIEW customer_basic_details AS
SELECT
    customer_id,
    customer_name,
    city
FROM customers;

-- Update through the view
UPDATE customer_basic_details
SET city = 'Hyderabad'
WHERE customer_id = 1;

-- Verify the update
SELECT * FROM customer_basic_details;

-- Verify the original table
SELECT * FROM customers
WHERE customer_id = 1;


-- Q7. Create a view with WITH CHECK OPTION.

CREATE OR REPLACE VIEW completed_orders_only AS
SELECT
    order_id,
    customer_id,
    restaurant_id,
    total_amount,
    status
FROM orders
WHERE status = 'COMPLETED'
    WITH CHECK OPTION;

-- An update that keeps the row within the view condition
-- is allowed (assuming other constraints are satisfied).

UPDATE completed_orders_only
SET total_amount = 600
WHERE order_id = 101;

-- An update that violates the view condition is rejected.
-- Uncomment to test:
-- UPDATE completed_orders_only
-- SET status = 'CANCELLED'
-- WHERE order_id = 101;


-- =========================================================
-- PART C: MANAGING VIEWS
-- =========================================================


-- Q8. Drop high_value_orders.

DROP VIEW high_value_orders;


-- Q9. Drop restaurant_revenue only if it exists.

DROP VIEW IF EXISTS restaurant_revenue;


-- Q10. Conceptual notes

-- TABLE:
-- Stores actual data in the database.

-- VIEW:
-- A virtual table based on a stored SELECT query definition.
-- A regular view normally does not store a separate copy
-- of the underlying result data.

-- Changes in underlying table data are reflected when
-- the view is queried again.

-- A view can combine multiple tables using JOIN.

-- Not every view is updatable.
-- Views involving GROUP BY, aggregate functions, DISTINCT,
-- UNION and certain other constructs are generally
-- not updatable in MySQL.

-- WITH CHECK OPTION:
-- Ensures that INSERT or UPDATE operations through the view
-- do not create rows that fail the view's WHERE condition.

-- DROP VIEW:
-- Removes the view definition, not the original table data.


-- =========================================================
-- ADDITIONAL PRACTICE: WITH CHECK OPTION
-- =========================================================


-- Example view:
-- Only orders with total_amount greater than 1000 are visible.

CREATE OR REPLACE VIEW expensive_orders AS
SELECT
    order_id,
    total_amount
FROM orders
WHERE total_amount > 1000
    WITH CHECK OPTION;


-- CASE A: 1500 -> 2000
-- Allowed because 2000 > 1000.

-- UPDATE expensive_orders
-- SET total_amount = 2000
-- WHERE order_id = 101;


-- CASE B: 1500 -> 800
-- Rejected because 800 is not greater than 1000.

-- UPDATE expensive_orders
-- SET total_amount = 800
-- WHERE order_id = 101