
-- =====================================================
-- DAY 23: COMMON TABLE EXPRESSIONS (CTEs)
-- Database: Food Delivery Database
-- =====================================================

-- Q1. Find high-value orders (amount > 1000)

WITH high_value_orders AS (
    SELECT *
    FROM orders
    WHERE total_amount > 1000
)
SELECT *
FROM high_value_orders;


-- Q2. Customers whose total spending exceeds 1000

WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spending
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_spending
WHERE total_spending > 1000;


-- Q3. Completed revenue per restaurant

WITH restaurant_revenue AS (
    SELECT
        restaurant_id,
        SUM(total_amount) AS total_revenue
    FROM orders
    WHERE status = 'COMPLETED'
    GROUP BY restaurant_id
)
SELECT
    restaurant_id,
    total_revenue
FROM restaurant_revenue;


-- Q4. Restaurants with at least 5 completed orders

WITH restaurant_orders AS (
    SELECT
        restaurant_id,
        COUNT(*) AS completed_orders
    FROM orders
    WHERE status = 'COMPLETED'
    GROUP BY restaurant_id
)
SELECT *
FROM restaurant_orders
WHERE completed_orders >= 5;


-- Q5. Total orders and completed orders per restaurant

WITH total_orders AS (
    SELECT
        restaurant_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY restaurant_id
),
     completed_orders AS (
         SELECT
             restaurant_id,
             COUNT(*) AS completed_count
         FROM orders
         WHERE status = 'COMPLETED'
         GROUP BY restaurant_id
     )
SELECT
    t.restaurant_id,
    t.order_count,
    COALESCE(c.completed_count, 0) AS completed_count
FROM total_orders t
         LEFT JOIN completed_orders c
                   ON t.restaurant_id = c.restaurant_id;


-- Q6. Customers who have never placed an order

WITH ordered_customers AS (
    SELECT DISTINCT customer_id
    FROM orders
)
SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM ordered_customers oc
    WHERE oc.customer_id = c.customer_id
);


-- Q7. Customers with more than 3 orders

WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS total_orders
    FROM orders
    GROUP BY customer_id
),
     frequent_customers AS (
         SELECT
             customer_id,
             total_orders
         FROM customer_orders
         WHERE total_orders > 3
     )
SELECT *
FROM frequent_customers;


-- Q8. Products priced above the average product price

WITH average_price AS (
    SELECT AVG(price) AS avg_price
    FROM products
)
SELECT
    p.product_id,
    p.product_name,
    p.price
FROM products p
         CROSS JOIN average_price a
WHERE p.price > a.avg_price;


-- Q9. Customer names and their total spending

WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spending
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.customer_name,
    cs.total_spending
FROM customers c
         JOIN customer_spending cs
              ON c.customer_id = cs.customer_id;


-- Q10. Restaurant performance report

WITH restaurant_stats AS (
    SELECT
        restaurant_id,
        COUNT(*) AS total_orders,

        SUM(
                CASE
                    WHEN status = 'COMPLETED' THEN 1
                    ELSE 0
                    END
        ) AS completed_orders,

        SUM(
                CASE
                    WHEN status = 'CANCELLED' THEN 1
                    ELSE 0
                    END
        ) AS cancelled_orders,

        SUM(
                CASE
                    WHEN status = 'COMPLETED' THEN total_amount
                    ELSE 0
                    END
        ) AS completed_revenue

    FROM orders
    GROUP BY restaurant_id
)
SELECT
    restaurant_id,
    total_orders,
    completed_orders,
    cancelled_orders,
    completed_revenue,
    ROUND(
            completed_orders * 100.0 / total_orders,
            2
    ) AS completion_percentage
FROM restaurant_stats;

-- =====================================================
-- END OF DAY 23
-- =====================================================
