## Joining Tables

**Goal:** 
Combine tables to identify customer patterns and business insights.

### Top 10 Countries by Customers
```sql
SELECT country.country AS country_name,
       COUNT(customer.customer_id) AS customer_count
FROM country
INNER JOIN city ON country.country_id = city.country_id
INNER JOIN address ON city.city_id = address.city_id
INNER JOIN customer ON customer.address_id = address.address_id
GROUP BY country.country
ORDER BY customer_count DESC
LIMIT 10;


**Result:** India and China lead in customer count.
INNER JOIN ensures only valid links between all tables are included.

### Top 10 Cities within Those Countries

Using a subquery to filter by the top 10 countries:
```sql
SELECT city.city AS city_name,
       country.country,
       COUNT(customer.customer_id) AS customer_count
FROM country
INNER JOIN city ON country.country_id = city.country_id
INNER JOIN address ON city.city_id = address.city_id
INNER JOIN customer ON customer.address_id = address.address_id
WHERE country.country IN ('India', 'China', 'United States', 'Japan', 'Mexico', 'Brazil', 'Russian Federation', 'Philippines', 'Turkey', 'Indonesia')
GROUP BY city.city, country.country
ORDER BY customer_count DESC
LIMIT 10;


**Result:** Aurora (US) and Atlixco (Mexico) have the most customers among the top countries.

### Top 5 Paying Customers
```sql
SELECT customer.customer_id,
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
WHERE city.city IN ('Aurora', 'Atlixco', 'Xintai', 'Adoni', 'Dhule (Dhulia)', 'Kurashiki', 'Pingxiang', 'Sivas', 'Celaya', 'So Leopoldo')
AND country.country IN ('India', 'China', 'United States', 'Japan', 'Mexico', 'Brazil', 'Russian Federation', 'Philippines', 'Turkey', 'Indonesia')
GROUP BY customer.customer_id, customer.first_name, customer.last_name, city.city, country.country
ORDER BY total_amount_paid DESC
LIMIT 5;


**Result:** Sara Perry (Mexico) and Gabriel Harder (Turkey) are Rockbuster’s most valuable customers.