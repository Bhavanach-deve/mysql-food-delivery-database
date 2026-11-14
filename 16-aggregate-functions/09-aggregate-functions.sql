
-- ==========================================
-- DAY 16: AGGREGATE FUNCTIONS
-- ==========================================

-- 1. Count all orders
SELECT COUNT(*) AS total_orders
FROM practice_orders;

-- 2. Count non-NULL customer IDs
SELECT COUNT(customer_id) AS orders_with_customer
FROM practice_orders;

-- 3. Count unique customers who placed orders
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM practice_orders;

-- 4. Calculate total order amount
SELECT SUM(amount) AS total_order_amount
FROM practice_orders;

-- 5. Calculate average order amount
SELECT AVG(amount) AS average_order_amount
FROM practice_orders;

-- 6. Find the smallest order amount
SELECT MIN(amount) AS smallest_order
FROM practice_orders;

-- 7. Find the largest order amount
SELECT MAX(amount) AS largest_order
FROM practice_orders;

-- 8. Combine multiple aggregate functions
SELECT
    COUNT(*) AS total_orders,
    SUM(amount) AS total_revenue,
    AVG(amount) AS average_order_value,
    MIN(amount) AS minimum_order,
    MAX(amount) AS maximum_order
FROM practice_orders;

-- 9. Aggregate functions with a WHERE condition
SELECT
    COUNT(*) AS delivered_order_count,
    SUM(amount) AS delivered_order_total
FROM practice_orders
WHERE order_status = 'DELIVERED';
