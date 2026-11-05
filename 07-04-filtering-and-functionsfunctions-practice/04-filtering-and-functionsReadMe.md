# Day 7: SQL Built-in Functions

## 1. What are SQL Functions?

SQL functions are built-in operations that accept input, perform a specific task, and return a result.

Examples:
- Transforming text.
- Performing mathematical calculations.
- Working with dates and times.
- Handling NULL values.

## 2. String Functions

String functions operate on text values.

| Function | Purpose | Example |
|---|---|---|
| UPPER() | Converts text to uppercase | UPPER('hello') → HELLO |
| LOWER() | Converts text to lowercase | LOWER('HELLO') → hello |
| LENGTH() | Returns string length in bytes | LENGTH('Food') → 4 |
| CONCAT() | Combines strings | CONCAT('Food', 'Delivery') |
| TRIM() | Removes leading and trailing spaces | TRIM(' Hello ') |
| SUBSTRING() | Extracts part of a string | SUBSTRING('Restaurant', 1, 4) → Rest |

Examples:

```sql
SELECT UPPER('hyderabad');

SELECT LOWER('FOOD DELIVERY');

SELECT LENGTH('Restaurant');

SELECT CONCAT('Food', ' ', 'Delivery');

SELECT TRIM('  Hyderabad  ');

SELECT SUBSTRING('Restaurant', 1, 4);
```

Project example:

```sql
SELECT
    restaurant_name,
    UPPER(restaurant_name) AS uppercase_name
FROM restaurants;
```

## 3. Numeric Functions

Numeric functions perform mathematical operations.

| Function | Purpose | Example |
|---|---|---|
| ROUND() | Rounds a number | ROUND(125.678, 2) → 125.68 |
| CEIL() | Rounds upward | CEIL(45.2) → 46 |
| FLOOR() | Rounds downward | FLOOR(45.9) → 45 |
| ABS() | Returns absolute value | ABS(-50) → 50 |
| MOD() | Returns remainder | MOD(10, 3) → 1 |

Example:

```sql
SELECT ROUND(199.567, 2) AS rounded_price;
```

Result: 199.57

## 4. Date and Time Functions

Date and time functions work with date and time values.

| Function | Purpose |
|---|---|
| CURDATE() | Returns the current date |
| NOW() | Returns the current date and time |
| YEAR() | Extracts the year |
| MONTH() | Extracts the month |
| DAY() | Extracts the day |
| DATEDIFF() | Calculates the difference between two dates in days |

Examples:

```sql
SELECT CURDATE();

SELECT NOW();

SELECT YEAR('2026-11-04');

SELECT MONTH('2026-11-04');

SELECT DAY('2026-11-04');

SELECT DATEDIFF('2026-11-10', '2026-11-04');
```

Project example:

```sql
SELECT
    order_id,
    order_date,
    YEAR(order_date) AS order_year
FROM orders;
```

## 5. NULL-Handling Functions

NULL represents a missing or unknown value.

### COALESCE()

COALESCE checks expressions from left to right and returns the first non-NULL value.

Pronunciation: koh-uh-LESS.

Meaning: To come together or combine into one.

```sql
SELECT COALESCE(NULL, NULL, 'Hyderabad', 'Chennai');
```

Result: Hyderabad

Project example:

```sql
SELECT
    customer_name,
    COALESCE(city, 'City not provided') AS customer_city
FROM customers;
```

### IFNULL()

IFNULL returns an alternative value when the first expression is NULL.

```sql
SELECT IFNULL(NULL, 0);
```

Result: 0

### Difference between COALESCE() and IFNULL()

| COALESCE() | IFNULL() |
|---|---|
| Can check multiple expressions | Checks one expression and one replacement |
| Returns the first non-NULL expression | Returns the replacement if the first expression is NULL |
| Standard SQL function | MySQL-specific function |

## 6. Scalar vs Aggregate Functions

| Scalar Functions | Aggregate Functions |
|---|---|
| Work on individual values | Calculate across multiple rows |
| Usually return one result per input row | Usually return one result per group |
| UPPER(), ROUND(), YEAR() | COUNT(), SUM(), AVG(), MIN(), MAX() |

Aggregate functions will be studied in more detail with GROUP BY.

## 7. Connection to Java Spring Boot

SQL functions help backend applications retrieve formatted and calculated data directly from the database.

Examples:
- Formatting restaurant names.
- Calculating prices.
- Extracting order years.
- Replacing missing values in query results.

## Day 7 Summary

Today I learned:

- String functions.
- Numeric functions.
- Date and time functions.
- NULL-handling functions.
- Difference between COALESCE() and IFNULL().
- Difference between scalar and aggregate functions.
- Applying SQL functions to the food delivery database.