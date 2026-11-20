
-- =====================================================
-- DAY 22: CASE STATEMENTS & CONDITIONAL AGGREGATION
-- 30-Day MySQL Food Delivery Database Project
-- =====================================================


-- Q1. Classify orders based on amount:
-- >= 1000 = High Value
-- >= 500  = Medium Value
-- Otherwise = Low Value

SELECT
    order_id,
    total_amount,
    CASE
        WHEN total_amount >= 1000 THEN 'High Value'
        WHEN total_amount >= 500 THEN 'Medium Value'
        ELSE 'Low Value'
        END AS order_category
FROM orders;


-- Q2. Classify orders based on status:
-- COMPLETED = Completed Order
-- CANCELLED = Cancelled Order
-- Otherwise = Pending / Other

SELECT
    order_id,
    status,
    CASE
        WHEN status = 'CANCELLED' THEN 'Cancelled Order'
        WHEN status = 'PENDING' THEN 'Pending Order'
        ELSE 'Completed Order'
        END AS order_classification
FROM orders;


-- Q3. Count completed orders using COUNT(CASE WHEN...)

SELECT
    COUNT(
            CASE
                WHEN status = 'COMPLETED' THEN 1
                END
    ) AS completed_orders
FROM orders;


-- Q4. Calculate completed order revenue using SUM(CASE WHEN...)

SELECT
    restaurant_id,
    SUM(
            CASE
                WHEN status = 'COMPLETED' THEN total_amount
                ELSE 0
                END
    ) AS completed_revenue
FROM orders
GROUP BY restaurant_id;


-- Q5. Count completed and cancelled orders in one query.

SELECT
    restaurant_id,

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
    ) AS cancelled_orders

FROM orders
GROUP BY restaurant_id;


-- Q6. Calculate completed and cancelled orders
-- for each restaurant.

SELECT
    restaurant_id,

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
    ) AS cancelled_orders

FROM orders
GROUP BY restaurant_id;


-- Q7. Calculate completed revenue for each restaurant.

SELECT
    restaurant_id,

    SUM(
            CASE
                WHEN status = 'COMPLETED' THEN total_amount
                ELSE 0
                END
    ) AS completed_revenue

FROM orders
GROUP BY restaurant_id;


-- Q8. Restaurant-level report:
-- Total orders
-- Completed orders
-- Cancelled orders
-- Completed revenue

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
GROUP BY restaurant_id;


-- Q9. Calculate the percentage of completed orders
-- for each restaurant.

SELECT
    restaurant_id,

    COUNT(*) AS total_orders,

    SUM(
            CASE
                WHEN status = 'COMPLETED' THEN 1
                ELSE 0
                END
    ) AS completed_orders,

    ROUND(
            SUM(
                    CASE
                        WHEN status = 'COMPLETED' THEN 1
                        ELSE 0
                        END
            ) * 100.0 / COUNT(*),
            2
    ) AS completion_percentage

FROM orders
GROUP BY restaurant_id;


-- Q10. Classify restaurant performance:
-- Completed orders >= 10 = High Performance
-- Completed orders >= 5  = Medium Performance
-- Otherwise = Low Performance

SELECT
    restaurant_id,

    SUM(
            CASE
                WHEN status = 'COMPLETED' THEN 1
                ELSE 0
                END
    ) AS completed_orders,

    CASE
        WHEN SUM(
                     CASE
                         WHEN status = 'COMPLETED' THEN 1
                         ELSE 0
                         END
             ) >= 10 THEN 'High Performance'

        WHEN SUM(
                     CASE
                         WHEN status = 'COMPLETED' THEN 1
                         ELSE 0
                         END
             ) >= 5 THEN 'Medium Performance'

        ELSE 'Low Performance'
        END AS restaurant_performance

FROM orders
GROUP BY restaurant_id;


-- =====================================================
-- END OF DAY 22
-- =====================================================
