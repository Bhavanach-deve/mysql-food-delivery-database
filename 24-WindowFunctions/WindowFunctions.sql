
-- =====================================================
-- WINDOW FUNCTIONS FUNDAMENTALS
-- =====================================================

-- Q1. Display orders with overall average order amount

SELECT
    order_id,
    customer_id,
    total_amount,
    AVG(total_amount) OVER() AS overall_avg
FROM orders;


-- Q2. Display each order with its customer's total spending

SELECT
    order_id,
    customer_id,
    total_amount,
    SUM(total_amount) OVER(
        PARTITION BY customer_id
    ) AS total_spending
FROM orders;


-- Q3. Display each order with restaurant revenue

SELECT
    order_id,
    restaurant_id,
    total_amount,
    SUM(total_amount) OVER(
        PARTITION BY restaurant_id
    ) AS restaurant_revenue
FROM orders;


-- Q4. Assign row numbers to all orders
-- Ordered by total_amount DESC

SELECT
    order_id,
    customer_id,
    total_amount,
    ROW_NUMBER() OVER(
        ORDER BY total_amount DESC
    ) AS unique_rows
FROM orders;


-- Q5. Rank products using RANK()

SELECT
    product_id,
    product_name,
    price,
    RANK() OVER(
        ORDER BY price DESC
    ) AS product_rank
FROM products;


-- Q6. Rank products using DENSE_RANK()

SELECT
    product_id,
    product_name,
    price,
    DENSE_RANK() OVER(
        ORDER BY price DESC
    ) AS product_rank
FROM products;


-- Q7. Row numbers separately for each restaurant

SELECT
    order_id,
    restaurant_id,
    total_amount,
    ROW_NUMBER() OVER(
        PARTITION BY restaurant_id
        ORDER BY total_amount DESC
    ) AS order_rank
FROM orders;


-- Q8. Rank customers based on total spending

WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spending
    FROM orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_spending,
    RANK() OVER(
        ORDER BY total_spending DESC
    ) AS spending_rank
FROM customer_spending;


-- Q9. Find the highest-value order for every restaurant

WITH ranked_orders AS (
    SELECT
        order_id,
        restaurant_id,
        total_amount,
        ROW_NUMBER() OVER(
            PARTITION BY restaurant_id
            ORDER BY total_amount DESC
        ) AS order_rank
    FROM orders
)
SELECT
    order_id,
    restaurant_id,
    total_amount,
    order_rank
FROM ranked_orders
WHERE order_rank = 1;


-- Q10. Find the top 2 highest-value orders
-- for every restaurant

WITH ranked_orders AS (
    SELECT
        order_id,
        restaurant_id,
        total_amount,
        ROW_NUMBER() OVER(
            PARTITION BY restaurant_id
            ORDER BY total_amount DESC
        ) AS order_rank
    FROM orders
)
SELECT
    order_id,
    restaurant_id,
    total_amount,
    order_rank
FROM ranked_orders
WHERE order_rank <= 2;

