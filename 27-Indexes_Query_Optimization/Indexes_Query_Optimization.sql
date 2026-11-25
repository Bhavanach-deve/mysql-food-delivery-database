
-- =========================================================
-- DAY 27: INDEXES AND QUERY OPTIMIZATION
-- Database: Food Delivery System
-- MySQL 8.0+
-- =========================================================


-- ---------------------------------------------------------
-- Q1. Create a normal index on orders.customer_id.
-- ---------------------------------------------------------

CREATE INDEX idx_orders_customer_id
    ON orders(customer_id);

-- Why?
-- It helps MySQL find orders belonging to a particular
-- customer without necessarily scanning every order row.


-- ---------------------------------------------------------
-- Q2. Create an index on orders.status.
-- ---------------------------------------------------------

CREATE INDEX idx_orders_status
    ON orders(status);

-- Note:
-- status may have low selectivity because many orders
-- can share the same status.
-- MySQL may choose not to use this index for some queries.


-- ---------------------------------------------------------
-- Q3. Create a UNIQUE index on customers.email.
-- ---------------------------------------------------------

-- First check whether duplicate emails exist.
SELECT email, COUNT(*) AS email_count
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

-- Create this index only after confirming that there are
-- no duplicate values and that the column is suitable.
CREATE UNIQUE INDEX idx_customers_email
    ON customers(email);

-- Why?
-- A UNIQUE index prevents duplicate non-NULL email values.
-- MySQL permits multiple NULL values in a UNIQUE index.


-- ---------------------------------------------------------
-- Q4. Create a composite index on customer_id and status.
-- ---------------------------------------------------------

CREATE INDEX idx_orders_customer_status
    ON orders(customer_id, status);

-- Column order matters.
-- This index follows the leftmost-prefix rule.


-- ---------------------------------------------------------
-- Q5. Retrieve all orders for customer 105.
-- Which index can help?
-- ---------------------------------------------------------

SELECT *
FROM orders
WHERE customer_id = 105;

-- Possible helpful index:
-- idx_orders_customer_id
-- OR the composite index idx_orders_customer_status,
-- because customer_id is its leftmost column.


-- ---------------------------------------------------------
-- Q6. Retrieve completed orders for customer 105.
-- Which index can help?
-- ---------------------------------------------------------

SELECT *
FROM orders
WHERE customer_id = 105
  AND status = 'COMPLETED';

-- Helpful composite index:
-- idx_orders_customer_status(customer_id, status)
--
-- Both indexed columns are used in the filtering condition.


-- ---------------------------------------------------------
-- Q7. Understand the leftmost-prefix rule.
-- ---------------------------------------------------------

-- Given:
-- CREATE INDEX idx_orders_customer_status
-- ON orders(customer_id, status);

-- This can generally use the composite index:
SELECT *
FROM orders
WHERE customer_id = 105;

-- This can generally use the composite index:
SELECT *
FROM orders
WHERE customer_id = 105
  AND status = 'COMPLETED';

-- This generally cannot use the composite index for an
-- efficient direct lookup by status alone:
SELECT *
FROM orders
WHERE status = 'COMPLETED';

-- Why?
-- The index is organized by customer_id first, then status.
-- Searching by status alone skips the leftmost column.


-- ---------------------------------------------------------
-- Q8. Use EXPLAIN to inspect the execution plan.
-- ---------------------------------------------------------

EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 105
  AND status = 'COMPLETED';

-- Important EXPLAIN columns:
-- possible_keys : indexes MySQL considers possible candidates
-- key           : index MySQL actually chooses
-- rows          : estimated rows MySQL expects to examine
-- type          : access method
-- Extra         : additional execution information
--
-- Remember:
-- key can be NULL when MySQL chooses not to use an index.
-- EXPLAIN shows estimates, not actual execution counts.


-- ---------------------------------------------------------
-- Q9. Why should we NOT create indexes on every column?
-- ---------------------------------------------------------

-- 1. Indexes consume additional disk storage.
-- 2. INSERT, UPDATE and DELETE operations need index maintenance.
-- 3. Too many indexes can increase write overhead and
--    complicate the optimizer's choice of execution plan.
--
-- Create indexes based on actual query patterns.


-- ---------------------------------------------------------
-- Q10. Understand selectivity.
-- ---------------------------------------------------------

-- Example:
-- status might have only three distinct values:
-- PENDING, COMPLETED, CANCELLED.
--
-- customer_id might have thousands of distinct values.
--
-- customer_id usually has higher selectivity than status.
-- It can narrow down the matching rows more effectively.
--
-- However, low selectivity does NOT automatically mean
-- an index is useless. The optimizer decides whether
-- using an index is worthwhile.


-- =========================================================
-- ADDITIONAL CONCEPT: CLUSTERED AND SECONDARY INDEXES
-- =========================================================

-- Example table:
CREATE TABLE customers_index_demo (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(100),
city VARCHAR(50)
);

-- Create a secondary index:
CREATE INDEX idx_customers_city
    ON customers_index_demo(city);


-- ---------------------------------------------------------
-- Q11. Which index contains the complete customer records
--      in its leaf pages?
-- ---------------------------------------------------------

-- Answer:
-- The PRIMARY KEY index.
--
-- In InnoDB, the primary key is the clustered index.
-- Its leaf pages contain the complete table rows.


-- ---------------------------------------------------------
-- Q12. What happens when we execute this query?
-- ---------------------------------------------------------

SELECT *
FROM customers_index_demo
WHERE city = 'Hyderabad';

-- Answer:
-- 1. MySQL may use idx_customers_city to find matching entries.
-- 2. The secondary index entries contain city and customer_id.
-- 3. MySQL uses customer_id to locate the complete row
--    in the clustered primary-key index.
--
-- Why the second lookup?
-- The secondary index does not contain customer_name.


-- ---------------------------------------------------------
-- Q13. Why does a secondary index store the primary key?
-- ---------------------------------------------------------

-- Answer:
-- The primary key identifies the corresponding complete row.
-- InnoDB uses it to navigate from the secondary index
-- to the clustered index.


-- ---------------------------------------------------------
-- Q14. Demonstrate a covering-index possibility.
-- ---------------------------------------------------------

SELECT customer_id, city
FROM customers_index_demo
WHERE city = 'Hyderabad';

-- The city secondary index contains:
-- city + customer_id
--
-- Both requested columns are available in the index.
-- Therefore, MySQL may answer this query directly from
-- the secondary index without retrieving the complete row
-- from the clustered index.
--
-- This is called a COVERING INDEX query.


-- ---------------------------------------------------------
-- Q15. Inspect an execution plan.
-- ---------------------------------------------------------

EXPLAIN
SELECT *
FROM customers_index_demo
WHERE city = 'Hyderabad';


-- ---------------------------------------------------------
-- CLEANUP: Remove the demonstration table if desired.
-- ---------------------------------------------------------

-- DROP TABLE customers_index_demo;
