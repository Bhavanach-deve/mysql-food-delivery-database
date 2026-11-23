# Day 25 – Advanced Window Functions

## Overview

Day 25 focuses on advanced SQL Window Functions in MySQL. These functions allow us to perform calculations across related rows without collapsing the individual rows into a single result.

## Topics Covered

- Running Totals
- Running Averages
- `LAG()`
- `LEAD()`
- `PARTITION BY`
- Moving Aggregates
- Window Frames
- `ROWS BETWEEN`
- `UNBOUNDED PRECEDING`
- `CURRENT ROW`

## Functions Practiced

| Function / Clause | Purpose |
|---|---|
| `SUM() OVER()` | Calculates sum across a window |
| `AVG() OVER()` | Calculates average across a window |
| `LAG()` | Retrieves a value from a preceding row |
| `LEAD()` | Retrieves a value from a following row |
| `PARTITION BY` | Divides rows into independent groups |
| `ORDER BY` | Determines the sequence within a window |
| `ROWS BETWEEN` | Defines a row-based window frame |
| `UNBOUNDED PRECEDING` | Starts the frame from the first row |
| `CURRENT ROW` | Ends or starts the frame at the current row |

## Key Learnings

- Running totals accumulate values row by row.
- Running averages calculate the average up to the current row.
- `LAG()` accesses preceding row values.
- `LEAD()` accesses following row values.
- `PARTITION BY` resets window calculations for each group.
- Window functions preserve individual rows.
- Window frames control the rows included in a calculation.
- `ROWS BETWEEN 1 PRECEDING AND CURRENT ROW` calculates using the previous row and the current row.
