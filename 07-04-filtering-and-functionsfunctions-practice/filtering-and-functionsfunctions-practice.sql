-- 1. Convert restaurant names to uppercase
SELECT UPPER(restaurant_name)
FROM restaurants;

-- 2. Convert restaurant names to lowercase
SELECT LOWER(restaurant_name)
FROM restaurants;

-- 3. Find the length of each restaurant name
SELECT restaurant_name, LENGTH(restaurant_name)
FROM restaurants;

-- 4. Display restaurant name with its city
SELECT CONCAT(restaurant_name, ' - ', city)
FROM restaurants;

-- 5. Round restaurant ratings to one decimal place
SELECT restaurant_name, ROUND(rating, 1)
FROM restaurants;

-- 6. Display today's date
SELECT CURDATE();

-- 7. Extract the year from order dates
SELECT order_id, YEAR(order_date)
FROM orders;

-- 8. Replace missing customer cities in the output
SELECT customer_name, COALESCE(city, 'Unknown')
FROM customers;