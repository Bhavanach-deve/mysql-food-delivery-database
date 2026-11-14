
USE join_practice_db;

-- =========================================
-- PART A: SELF JOIN
-- =========================================

CREATE TABLE IF NOT EXISTS practice_employees (
                                                  employee_id INT PRIMARY KEY,
                                                  employee_name VARCHAR(50),
    manager_id INT NULL
    );

INSERT INTO practice_employees
(employee_id, employee_name, manager_id)
VALUES
    (1, 'Ananya', NULL),
    (2, 'Rahul', 1),
    (3, 'Priya', 1),
    (4, 'Sneha', 2),
    (5, 'Arjun', 2);


-- Q1. Display every employee and their manager.
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM practice_employees e
         LEFT JOIN practice_employees m
                   ON e.manager_id = m.employee_id;


-- Q2. Display only employees who have a manager.
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM practice_employees e
         INNER JOIN practice_employees m
                    ON e.manager_id = m.employee_id;


-- Q3. Find employees who report directly to Ananya.
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM practice_employees e
         INNER JOIN practice_employees m
                    ON e.manager_id = m.employee_id
WHERE m.employee_name = 'Ananya';


-- =========================================
-- PART B: MULTIPLE-TABLE JOIN
-- =========================================

-- Q4. Display customer name, order ID,
-- and payment status.
SELECT
    c.customer_name,
    o.order_id,
    p.payment_status
FROM practice_customers c
         INNER JOIN practice_orders o
                    ON c.customer_id = o.customer_id
         INNER JOIN practice_payments p
                    ON o.order_id = p.order_id;


-- Q5. Display all customers, their orders,
-- and payment status if available.
SELECT
    c.customer_name,
    o.order_id,
    p.payment_status
FROM practice_customers c
         LEFT JOIN practice_orders o
                   ON c.customer_id = o.customer_id
         LEFT JOIN practice_payments p
                   ON o.order_id = p.order_id;


-- Q6. Display customers with successful payments.
SELECT
    c.customer_name,
    o.order_id,
    p.payment_status,
    p.payment_method
FROM practice_customers c
         INNER JOIN practice_orders o
                    ON c.customer_id = o.customer_id
         INNER JOIN practice_payments p
                    ON o.order_id = p.order_id
WHERE p.payment_status = 'SUCCESS';


-- Q7. Display customer names and orders
-- whose payment amount is greater than 400.
SELECT
    c.customer_name,
    o.order_id,
    p.payment_status,
    p.amount
FROM practice_customers c
         INNER JOIN practice_orders o
                    ON c.customer_id = o.customer_id
         INNER JOIN practice_payments p
                    ON o.order_id = p.order_id
WHERE p.amount > 400;
