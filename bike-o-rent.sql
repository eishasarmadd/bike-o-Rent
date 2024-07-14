

-- Drop the tables if they exist
DROP TABLE IF EXISTS bikes;
DROP TABLE IF EXISTS bike_types;
DROP TABLE IF EXISTS bike_rentals;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS payment;

-- Create the table
CREATE TABLE bike_rentals (
    rental_id INT PRIMARY KEY,
    bike_id INT,
    rental_start_time DATETIME,
    rental_distance VARCHAR(10),
    rental_duration VARCHAR(20),
    cancellation_reason VARCHAR(50)
);

-- Insert data into the table
INSERT INTO bike_rentals (rental_id, bike_id, rental_start_time, rental_distance, rental_duration, cancellation_reason) VALUES
(1, 1, '2021-01-01 18:15:34', '10km', '60 minutes', ''),
(2, 1, '2021-01-01 19:10:54', '15km', '29 minutes', ''),
(3, 1, '2021-01-03 00:12:37', '8km', '45 minutes', 'NaN'),
(4, 2, '2021-01-04 13:53:03', '20km', '90 minutes', 'NaN'),
(5, 3, '2021-01-08 21:10:57', '12km', '50 minutes', NULL),
(6, 3, NULL, NULL, NULL, 'Cancellation'),
(7, 2, '2020-08-01 21:30:45', '18km', '85 minutes', NULL),
(8, 2, '2020-10-01 00:15:02', '22km', '100 minutes', NULL),
(9, 2, NULL, NULL, NULL, 'Customer Cancellation'),
(10, 1, '2020-11-01 18:50:00', '10km', '55 minutes', NULL);


-- Create the bike_types table
CREATE TABLE bike_types (
    bike_type_id INT PRIMARY KEY,
    bike_type_name VARCHAR(50)
);

-- Insert data into the bike_types table
INSERT INTO bike_types (bike_type_id, bike_type_name) VALUES
(1, 'Off-road'),
(2, 'Speed'),
(3, 'Comfort');

-- Create the bikes table
CREATE TABLE bikes (
    bike_id INT PRIMARY KEY,
    bike_type_id INT,
    bike_name VARCHAR(50),
    FOREIGN KEY (bike_type_id) REFERENCES bike_types(bike_type_id)
);

-- Insert data into the bikes table
INSERT INTO bikes (bike_id, bike_type_id, bike_name) VALUES
(1, 1, 'Mountain Bike'),
(2, 2, 'Road Bike'),
(3, 3, 'Hybrid Bike');



-- Create the customers table
CREATE TABLE customers (
    rental_id INT,
    customer_id INT,
    customer_name VARCHAR(50),
    customer_email VARCHAR(50),
    customer_phone VARCHAR(15),
    order_date TIME,
    PRIMARY KEY (rental_id, customer_id)
);

-- Insert data into the customers table
INSERT INTO customers (rental_id, customer_id, customer_name, customer_email, customer_phone, order_date) VALUES
(1, 1, 'Alice Johnson', 'alice.johnson@example.com', '123-456-7890', '18:05:02'),
(2, 1, 'Alice Johnson', 'alice.johnson@example.com', '123-456-7890', '19:00:52'),
(3, 2, 'Bob Smith', 'bob.smith@example.com', '234-567-8901', '23:51:23'),
(4, 3, 'Charlie Brown', 'charlie.brown@example.com', '345-678-9012', '23:51:23'),
(5, 4, 'Dana White', 'dana.white@example.com', '456-789-0123', '13:23:46'),
(6, 4, 'Dana White', 'dana.white@example.com', '456-789-0123', '13:23:46'),
(7, 5, 'Eva Green', 'eva.green@example.com', '567-890-1234', '13:23:46'),
(8, 5, 'Eva Green', 'eva.green@example.com', '567-890-1234', '21:00:29'),
(9, 3, 'Charlie Brown', 'charlie.brown@example.com', '345-678-9012', '21:03:13'),
(10, 1, 'Alice Johnson', 'alice.johnson@example.com', '123-456-7890', '21:20:29');

-- Create the payment table
CREATE TABLE payment (
    payment_id INT PRIMARY KEY,
    rental_id INT,
    customer_id INT,
    amount_paid DECIMAL(10, 2),
    payment_date DATE,
    payment_method VARCHAR(20),
    FOREIGN KEY (rental_id, customer_id) REFERENCES customers(rental_id, customer_id)
);

-- Insert data into the payment table
INSERT INTO payment (payment_id, rental_id, customer_id, amount_paid, payment_date, payment_method) VALUES
(1, 1, 1, 20, '2024-01-01', 'Credit Card'),
(2, 2, 1, 25, '2024-01-01', 'Credit Card'),
(3, 3, 2, 15, '2024-01-03', 'PayPal'),
(4, 4, 3, 30, '2024-01-04', 'Credit Card'),
(5, 5, 4, 18, '2024-01-08', 'Debit Card');

-- Select all tables
SELECT * FROM bike_rentals;
SELECT * FROM bikes;
SELECT * FROM bike_types;
SELECT * FROM customers;
SELECT * FROM payment;

