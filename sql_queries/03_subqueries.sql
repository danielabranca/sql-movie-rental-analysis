/*
---------------------------------------------------------
03_subqueries.sql
Author: [Daniela]
Project: Rockbuster Data Analysis
Goal: Practice using subqueries to find top customers
---------------------------------------------------------
*/

---------------------------------------------------------
-- Step 1: Find the top 5 customers and their total amount paid
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
INNER JOIN customer ON address.address_id = customer.address_id
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

---------------------------------------------------------
-- Step 2: Calculate the average amount paid by these top 5 customers
---------------------------------------------------------
SELECT AVG(total_amount_paid.total_amount_paid) AS average
FROM (
    SELECT 
        customer.customer_id,
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
    GROUP BY customer.customer_id
    ORDER BY total_amount_paid DESC
    LIMIT 5
) AS total_amount_paid;

---------------------------------------------------------
-- Step 3: Find how many of the top 5 customers come from each country
---------------------------------------------------------
SELECT 
    country.country,
    COUNT(DISTINCT customer.customer_id) AS all_customer_count,
    COUNT(DISTINCT top_5_customers.customer_id) AS top_customer_count
FROM country
INNER JOIN city ON country.country_id = city.country_id
INNER JOIN address ON city.city_id = address.city_id
INNER JOIN customer ON customer.address_id = address.address_id
LEFT JOIN (
    SELECT 
        customer.customer_id,
        country.country
    FROM country
    INNER JOIN city ON country.country_id = city.country_id
    INNER JOIN address ON city.city_id = address.address_id
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
    GROUP BY customer.customer_id, country.country
    ORDER BY SUM(payment.amount) DESC
    LIMIT 5
) AS top_5_customers
ON top_5_customers.customer_id = customer.customer_id
GROUP BY country.country
ORDER BY all_customer_count DESC;
