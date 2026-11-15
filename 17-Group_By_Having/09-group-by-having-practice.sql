
-- ==========================================
-- DAY 17: GROUP BY AND HAVING
-- ==========================================

USE join_practice_db;

-- 1. Count orders placed by each customer
SELECT
    customer_id,
    COUNT(*) AS total_orders
FROM practice_orders
GROUP BY customer_id;


-- 2. Calculate total spending by each customer
SELECT
    customer_id,
    SUM(amount) AS total_spent
FROM practice_orders
GROUP BY customer_id;


-- 3. Calculate average order amount per customer
SELECT
    customer_id,
    AVG(amount) AS average_order_amount
FROM practice_orders
GROUP BY customer_id;


-- 4. Find the highest order amount per customer
SELECT
    customer_id,
    MAX(amount) AS highest_order
FROM practice_orders
GROUP BY customer_id;


-- 5. Calculate multiple summaries per customer
SELECT
    customer_id,
    COUNT(*) AS total_orders,
    SUM(amount) AS total_spent,
    AVG(amount) AS average_order_amount
FROM practice_orders
GROUP BY customer_id;


-- 6. Group by customer and order status
SELECT
    customer_id,
    order_status,
    COUNT(*) AS total_orders
FROM practice_orders
GROUP BY customer_id, order_status;


-- 7. Find customers whose total spending exceeds 500
SELECT
    customer_id,
    SUM(amount) AS total_spent
FROM practice_orders
GROUP BY customer_id
HAVING SUM(amount) > 500;


-- 8. Find customers who placed more than one order
SELECT
    customer_id,
    COUNT(*) AS total_orders
FROM practice_orders
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- 9. Filter rows first, then group them
-- Only delivered orders are considered
SELECT
    customer_id,
    SUM(amount) AS delivered_order_total
FROM practice_orders
WHERE order_status = 'DELIVERED'
GROUP BY customer_id;


-- 10. Combine WHERE, GROUP BY, HAVING and ORDER BY
SELECT
    customer_id,
    COUNT(*) AS delivered_orders,
    SUM(amount) AS delivered_total
FROM practice_orders
WHERE order_status = 'DELIVERED'
GROUP BY customer_id
HAVING SUM(amount) > 400
ORDER BY delivered_total DESC;
