
-- DAY 18: ADVANCED GROUP BY AND HAVING
-- MySQL Food Delivery Database SQL Series

-- 1. Create a dedicated practice table
DROP TABLE IF EXISTS day18_practice_orders;

CREATE TABLE day18_practice_orders (
                                       order_id INT PRIMARY KEY,
                                       customer_id INT NOT NULL,
                                       order_status VARCHAR(30) NOT NULL,
                                       total_amount DECIMAL(10, 2) NOT NULL
);

-- 2. Insert sample data
INSERT INTO day18_practice_orders
(order_id, customer_id, order_status, total_amount)
VALUES
    (101, 1, 'DELIVERED', 450.00),
    (102, 1, 'DELIVERED', 650.00),
    (103, 2, 'CANCELLED', 300.00),
    (104, 3, 'DELIVERED', 800.00),
    (105, 4, 'PENDING', 250.00),
    (106, 4, 'DELIVERED', 550.00),
    (107, 5, 'FAILED', 200.00);

-- 3. View the sample data
SELECT *
FROM day18_practice_orders;


-- Q1. Count orders for each customer and order status
SELECT customer_id,
       order_status,
       COUNT(*) AS total_orders
FROM day18_practice_orders
GROUP BY customer_id, order_status;


-- Q2. Display customer-wise order count, total spending
-- and average order amount
SELECT customer_id,
       COUNT(*) AS total_orders,
       SUM(total_amount) AS total_spending,
       AVG(total_amount) AS average_order_amount
FROM day18_practice_orders
GROUP BY customer_id;


-- Q3. Find customers with more than one delivered order
SELECT customer_id,
       COUNT(*) AS delivered_order_count
FROM day18_practice_orders
WHERE order_status = 'DELIVERED'
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- Q4. Find statuses whose average order amount exceeds 300
SELECT order_status,
       AVG(total_amount) AS average_order_amount
FROM day18_practice_orders
GROUP BY order_status
HAVING AVG(total_amount) > 300;


-- Q5. Find customers whose total spending exceeds 1000
-- Sort by spending from highest to lowest
SELECT customer_id,
       SUM(total_amount) AS total_spending
FROM day18_practice_orders
GROUP BY customer_id
HAVING SUM(total_amount) > 1000
ORDER BY total_spending DESC;


-- Q6. Find customers with at least 2 orders
-- AND total spending greater than 1000
SELECT customer_id,
       COUNT(*) AS order_count,
       SUM(total_amount) AS total_spending
FROM day18_practice_orders
GROUP BY customer_id
HAVING COUNT(*) >= 2
   AND SUM(total_amount) > 1000;


-- Q7. Find the order status with the highest total revenue
SELECT order_status,
       SUM(total_amount) AS total_revenue
FROM day18_practice_orders
GROUP BY order_status
ORDER BY total_revenue DESC
    LIMIT 1;
