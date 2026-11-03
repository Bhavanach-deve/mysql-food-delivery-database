-- Restaurants rated above 4.0
SELECT *
FROM restaurants
WHERE rating > 4.0;

-- Restaurants in selected cities
SELECT *
FROM restaurants
WHERE city IN ('Hyderabad', 'Chennai');

-- Restaurants with ratings between 4.0 and 4.8
SELECT *
FROM restaurants
WHERE rating BETWEEN 4.0 AND 4.8;

-- Restaurant names starting with D
SELECT *
FROM restaurants
WHERE restaurant_name LIKE 'D%';

-- Restaurants not in Hyderabad
SELECT *
FROM restaurants
WHERE city <> 'Hyderabad';