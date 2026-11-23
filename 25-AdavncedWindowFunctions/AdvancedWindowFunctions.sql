
-- =========================================================
-- DAY 25: ADVANCED WINDOW FUNCTIONS
-- Topics: Running totals, Running averages, LAG, LEAD,
--         Moving windows, Window frames
-- =========================================================


-- Q1. Find the running total of all order amounts
-- ordered by order_id.

SELECT
    order_id,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM orders;


-- Q2. Find the running total of order amounts
-- separately for each restaurant.

SELECT
    order_id,
    restaurant_id,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY restaurant_id
        ORDER BY order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS restaurant_running_total
FROM orders;


-- Q3. Find the running average of order amounts
-- ordered by order_id.

SELECT
    order_id,
    total_amount,
    AVG(total_amount) OVER (
        ORDER BY order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_average
FROM orders;


-- Q4. Display the previous order amount using LAG().

SELECT
    order_id,
    total_amount,
    LAG(total_amount) OVER (
        ORDER BY order_id
    ) AS previous_amount
FROM orders;


-- Q5. Display the next order amount using LEAD().

SELECT
    order_id,
    total_amount,
    LEAD(total_amount) OVER (
        ORDER BY order_id
    ) AS next_amount
FROM orders;


-- Q6. Find the difference between the current order amount
-- and the previous order amount.

SELECT
    order_id,
    total_amount,
    LAG(total_amount) OVER (
        ORDER BY order_id
    ) AS previous_amount,
    total_amount - LAG(total_amount) OVER (
        ORDER BY order_id
    ) AS amount_difference
FROM orders;


-- Q7. Calculate running revenue separately
-- for each restaurant.

SELECT
    order_id,
    restaurant_id,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY restaurant_id
        ORDER BY order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_revenue
FROM orders;


-- Q8. Find the previous order amount for each restaurant
-- using LAG() with PARTITION BY.

SELECT
    order_id,
    restaurant_id,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY restaurant_id
        ORDER BY order_id
    ) AS previous_restaurant_order
FROM orders;


-- Q9. Find a moving sum of the current order
-- and the immediately preceding order.

SELECT
    order_id,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY order_id
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    ) AS moving_sum
FROM orders;


-- Q10. Create a restaurant order performance report
-- containing previous amount, difference and running revenue.

SELECT
    order_id,
    restaurant_id,
    total_amount,

    LAG(total_amount) OVER (
        PARTITION BY restaurant_id
        ORDER BY order_id
    ) AS previous_amount,

    total_amount - LAG(total_amount) OVER (
        PARTITION BY restaurant_id
        ORDER BY order_id
    ) AS amount_difference,

    SUM(total_amount) OVER (
        PARTITION BY restaurant_id
        ORDER BY order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_revenue

FROM orders;
