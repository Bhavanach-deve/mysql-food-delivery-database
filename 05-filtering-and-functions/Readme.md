# Day 5 - SQL Filtering and Operators

## 1. What is Filtering?

Filtering allows us to retrieve only the records that satisfy specified conditions.

SQL uses the `WHERE` clause to filter records.

Example:

```sql
SELECT *
FROM restaurants
WHERE rating >= 4.0;
```

## 2. Comparison Operators

| Operator | Meaning |
|---|---|
| `=` | Equal to |
| `!=` or `<>` | Not equal to |
| `>` | Greater than |
| `<` | Less than |
| `>=` | Greater than or equal to |
| `<=` | Less than or equal to |

## 3. Logical Operators

### AND
Both conditions must be true.

```sql
SELECT *
FROM restaurants
WHERE city = 'Hyderabad'
AND rating >= 4.0;
```

### OR
At least one condition must be true.

```sql
SELECT *
FROM restaurants
WHERE city = 'Hyderabad'
OR city = 'Chennai';
```

### NOT
Reverses a condition.

```sql
SELECT *
FROM restaurants
WHERE NOT city = 'Hyderabad';
```

## 4. BETWEEN Operator

Checks whether a value falls within a specified range.

Both boundary values are included.

```sql
SELECT *
FROM restaurants
WHERE rating BETWEEN 4.0 AND 4.8;
```

## 5. IN Operator

Checks whether a value matches any value in a specified list.

```sql
SELECT *
FROM restaurants
WHERE city IN ('Hyderabad', 'Chennai', 'Bengaluru');
```

## 6. LIKE Operator

Used for pattern matching.

| Pattern | Meaning |
|---|---|
| `'A%'` | Starts with A |
| `'%a'` | Ends with a |
| `'%bir%'` | Contains bir |
| `'_a%'` | Second character is a |

- `%` represents zero or more characters.
- `_` represents exactly one character.

Example:

```sql
SELECT *
FROM restaurants
WHERE restaurant_name LIKE 'D%';
```

## 7. NULL Filtering

Use `IS NULL` to find missing values.

```sql
SELECT *
FROM customers
WHERE city IS NULL;
```

Use `IS NOT NULL` to find values that are not NULL.

```sql
SELECT *
FROM customers
WHERE city IS NOT NULL;
```

Do not use `= NULL` or `!= NULL` to test for NULL values.

## 8. Important Learning

- WHERE filters records.
- AND requires both conditions to be true.
- OR requires at least one condition to be true.
- BETWEEN checks an inclusive range.
- IN matches values from a specified list.
- LIKE performs pattern matching.
- IS NULL and IS NOT NULL handle missing values.

## 9. Backend Development Connection

Filtering is commonly used in REST API endpoints.

For example:

`GET /api/restaurants?city=Hyderabad&minRating=4.0`

The backend can use these request parameters to filter restaurant records in the database.
