
-- 1. List all bike rentals that were not canceled.

SELECT * FROM bike_rentals
WHERE cancellation_reason = 'NaN' OR cancellation_reason = '' OR cancellation_reason IS NULL
;

-- 2. Find the total number of rentals for each bike.

SELECT bike_id, COUNT(*) AS total_rentals
FROM bike_rentals
GROUP BY bike_id;

-- 3. Retrieve all the customers who used a bike on '2021-01-01'.

SELECT DISTINCT customers.customer_id, customers.customer_name, customers.customer_email, customers.customer_phone
FROM customers
JOIN bike_rentals ON customers.rental_id = bike_rentals.rental_id
WHERE DATE(bike_rentals.rental_start_time) = '2021-01-01';

-- 4. List all bike types available.
SELECT bike_type_id, bike_type_name 
FROM bike_types;

-- Find the rental duration for all rentals of bike with bike_id = 1.

SELECT rental_id, rental_duration 
FROM bike_rentals 
WHERE bike_id = 1
;

--List all rental start times and corresponding bike names.

SELECT DISTINCT bikes.bike_id,  bikes.bike_name,  bike_rentals.rental_start_time
FROM bikes
JOIN bike_rentals ON bikes.bike_id = bike_rentals.bike_id
GROUP BY bikes.bike_id,  bikes.bike_name, bike_rentals.rental_start_time;

-- List all rentals with a distance greater than 10 km.

SELECT rental_id, rental_distance FROM bike_rentals 
WHERE CAST(REPLACE( rental_distance, 'km', '') AS DECIMAL) > 10;

--Calculate the total distance traveled for each bike.

SELECT bike_id, SUM(CAST(REPLACE( rental_distance, 'km', '') AS DECIMAL)) AS total_distance
FROM bike_rentals
GROUP BY bike_id;

-- Find the average rental duration for each bike type name.

SELECT bt.bike_type_name, AVG(CAST(REPLACE( rental_duration, 'minutes', '') AS DECIMAL)) AS avg_duration
FROM bike_rentals br
JOIN bikes b ON br.bike_id = b.bike_id
JOIN bike_types bt ON b.bike_type_id = bt.bike_type_id
GROUP BY bt.bike_type_name;

-- List all customers who made more than one rental.

SELECT customer_id, customer_name, COUNT(*) AS rental_count
FROM customers
GROUP BY customer_id, customer_name
HAVING COUNT(*) > 1;

--Find the total amount paid by each customer.

SELECT customers.customer_id, customers.customer_name, SUM(payment.amount_paid) AS total_amount_paid
FROM customers
JOIN payment ON payment.customer_id = customers.customer_id
GROUP BY customers.customer_id, customers.customer_name;

-- Retrieve the rental with the maximum distance for each customer.

WITH RankedRentals AS (
    SELECT 
        c.customer_id, 
        c.customer_name, 
        br.rental_id, 
        br.rental_distance,
        ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY CAST(REPLACE(br.rental_distance, 'km', '') AS DECIMAL) DESC) AS row_num
    FROM 
        customers c
    JOIN 
        bike_rentals br ON c.rental_id = br.rental_id
)
SELECT 
    customer_id, 
    customer_name, 
    rental_id, 
    rental_distance
FROM 
    RankedRentals
WHERE 
    row_num = 1;

