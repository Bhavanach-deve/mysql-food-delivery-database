USE food_delivery_db;

-- Highest-rated restaurants first
SELECT *
FROM restaurants
ORDER BY rating DESC;

-- Lowest-rated restaurants first
SELECT *
FROM restaurants
ORDER BY rating ASC;

-- Top three restaurants
SELECT *
FROM restaurants
ORDER BY rating DESC
    LIMIT 3;

-- Skip first two and retrieve next two
SELECT *
FROM restaurants
ORDER BY rating DESC, restaurant_id ASC
    LIMIT 2 OFFSET 2;

-- First page: 2 restaurants
SELECT *
FROM restaurants
ORDER BY rating DESC, restaurant_id ASC
    LIMIT 2 OFFSET 0;

-- Second page: 2 restaurants
SELECT *
FROM restaurants
ORDER BY rating DESC, restaurant_id ASC
    LIMIT 2 OFFSET 2;