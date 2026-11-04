# Day 6: SQL Sorting and Pagination

## 1. ORDER BY

The `ORDER BY` clause sorts records based on one or more columns.

### ASC — Ascending Order
- Sorts smaller values to larger values.
- For text, generally sorts A to Z.
- This is the default sorting order.

```sql
SELECT *
FROM restaurants
ORDER BY rating ASC;
```

### DESC — Descending Order
- Sorts larger values to smaller values.
- For text, generally sorts Z to A.

```sql
SELECT *
FROM restaurants
ORDER BY rating DESC;
```

## 2. Sorting by Multiple Columns

We can sort using more than one column.

```sql
SELECT *
FROM restaurants
ORDER BY rating DESC, restaurant_name ASC;
```

First, restaurants are sorted by rating from highest to lowest. If ratings are equal, restaurant names are sorted alphabetically.

## 3. LIMIT

`LIMIT` restricts the maximum number of rows returned by a query.

```sql
SELECT *
FROM restaurants
ORDER BY rating DESC
LIMIT 5;
```

This returns the five highest-rated restaurants.

## 4. OFFSET

`OFFSET` specifies how many rows to skip before returning results.

```sql
SELECT *
FROM restaurants
ORDER BY rating DESC
LIMIT 5 OFFSET 10;
```

This skips the first 10 rows and returns the next 5 rows.

## 5. Pagination

Pagination divides a large result set into smaller pages.

Example: Display 10 restaurants per page.

| Page | LIMIT | OFFSET |
|---|---:|---:|
| 1 | 10 | 0 |
| 2 | 10 | 10 |
| 3 | 10 | 20 |
| 4 | 10 | 30 |

### Pagination formula

`OFFSET = (Page Number - 1) * Page Size`

Example: Page 4 with 10 records per page:

`OFFSET = (4 - 1) * 10 = 30`

```sql
SELECT *
FROM restaurants
ORDER BY rating DESC, restaurant_id ASC
LIMIT 10 OFFSET 30;
```

## 6. Important Notes

- Always use `ORDER BY` when you need predictable pagination.
- Add a unique tie-breaker, such as `restaurant_id`, when the primary sorting column can contain duplicate values.
- `LIMIT` controls how many rows are returned.
- `OFFSET` controls how many rows are skipped.
- Large OFFSET values can become inefficient; keyset pagination is an alternative used in some applications.

## 7. Connection to Java Spring Boot

Spring Data JPA supports pagination through:

- `Pageable`
- `PageRequest`
- `Page`

For example, a backend API can return 10 restaurants per page rather than loading every restaurant at once.

## Day 6 Summary

Today I learned:
- Sorting records using `ORDER BY`.
- Difference between `ASC` and `DESC`.
- Sorting by multiple columns.
- Restricting results using `LIMIT`.
- Skipping rows using `OFFSET`.
- Calculating pagination offsets.
- How SQL pagination connects to Spring Data JPA.