
# Day 24 - Window Functions Fundamentals

## Overview

Day 24 focuses on Window Functions in MySQL.

Window functions perform calculations across a set of related rows while preserving individual rows in the result.

Unlike GROUP BY, window functions do not collapse the individual records into one row per group.

## Learning Objectives

- Understand window functions.
- Understand the difference between GROUP BY and window functions.
- Learn the OVER() clause.
- Understand PARTITION BY.
- Use window functions without PARTITION BY.
- Practice ROW_NUMBER().
- Practice RANK().
- Practice DENSE_RANK().
- Rank orders within restaurants.
- Calculate customer spending and restaurant revenue using window functions.
- Find top orders using CTEs and ranking functions.

## Topics Covered

### 1. Window Function Fundamentals

- Window function definition
- OVER() clause
- Window calculations
- GROUP BY versus window functions

### 2. PARTITION BY

- Dividing rows into partitions
- Calculating aggregates per partition
- Preserving individual rows

### 3. Ranking Functions

- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- Tied values
- Rank gaps
- Ranking within partitions

### 4. Window Aggregates

- SUM() OVER()
- AVG() OVER()
- Overall average
- Customer-level spending
- Restaurant-level revenue

### 5. Practical SQL Challenges

- Ranking products by price
- Ranking customer spending
- Assigning order numbers
- Finding the highest-value order per restaurant
- Finding the top 2 orders per restaurant

## Important Concepts

| Concept | Description |
|---|---|
| OVER() | Defines the window |
| PARTITION BY | Divides rows into partitions |
| ORDER BY inside OVER() | Determines the order within the window |
| ROW_NUMBER() | Assigns a unique sequential number |
| RANK() | Assigns ranks and skips numbers after ties |
| DENSE_RANK() | Assigns ranks without skipping numbers after ties |
| SUM() OVER() | Calculates sum over a window |
| AVG() OVER() | Calculates average over a window |

## GROUP BY vs Window Functions

GROUP BY combines rows into groups and returns aggregated results.

Window functions calculate values across related rows while preserving the original individual rows.

## Ranking Comparison

| Function | Ties | Rank gaps |
|---|---|---|
| ROW_NUMBER() | Unique numbers | No |
| RANK() | Same rank | Yes |
| DENSE_RANK() | Same rank | No |

## Window Function Syntax

```sql
function_name() OVER(
    PARTITION BY column_name
    ORDER BY column_name
);
```

## Ranking Syntax

```sql
SELECT
    product_name,
    price,
    RANK() OVER(
        ORDER BY price DESC
    ) AS product_rank
FROM products;
```