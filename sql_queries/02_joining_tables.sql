/*
---------------------------------------------------------
02_joining_tables.sql
Author: [Daniela Branca]
Project: Rockbuster Data Analysis
Goal: Identify top-performing countries, cities, and customers
---------------------------------------------------------
*/

---------------------------------------------------------
-- 1. Find the top 10 countries with the most customers
---------------------------------------------------------
SELECT 
    country.country AS country_name,
    COUNT(customer.customer_id) AS customer_count
FROM country
INNER JOIN city ON country.country_id = city.country_id
INNER JOIN address ON city.city_id = address.city_id
INNER JOIN customer ON customer.address_id = address.address_id
GROUP BY country.country
ORDER BY customer_count DESC
LIMIT 10;

---------------------------------------------------------
-- 2. Find the top 10 cities that belong to the top 10 countries
---------------------------------------------------------
SELECT 
    city.city AS city_name,
    country.country,
    COUNT(customer.customer_id) AS customer_count
FROM country
INNER JOIN city ON country.country_id = city.country_id
INNER JOIN address ON city.city_id = address.city_id
INNER JOIN customer ON customer.address_id = address.address_id
WHERE country.country IN (
    'India', 'China', 'United States', 'Japan', 'Mexico', 
    'Brazil', 'Russian Federation', 'Philippines', 'Turkey', 'Indonesia'
)
GROUP BY city.city, country.country
ORDER BY customer_count DESC
LIMIT 10;

---------------------------------------------------------
-- 3. Find the top 5 customers from those cities 
--    based on total amount paid
---------------------------------------------------------
SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    city.city,
    country.country,
    SUM(payment.amount) AS total_amount_paid
FROM country
INNER JOIN city ON country.country_id = city.country_id
INNER JOIN address ON city.city_id = address.city_id
INNER JOIN customer ON customer.address_id = address.address_id
INNER JOIN payment ON customer.customer_id = payment.customer_id
WHERE city.city IN (
    'Aurora', 'Atlixco', 'Xintai', 'Adoni', 'Dhule (Dhulia)',
    'Kurashiki', 'Pingxiang', 'Sivas', 'Celaya', 'So Leopoldo'
)
AND country.country IN (
    'India', 'China', 'United States', 'Japan', 'Mexico', 
    'Brazil', 'Russian Federation', 'Philippines', 'Turkey', 'Indonesia'
)
GROUP BY customer.customer_id, customer.first_name, customer.last_name, city.city, country.country
ORDER BY total_amount_paid DESC
LIMIT 5;
