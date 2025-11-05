## Subqueries & Common Table Expressions (CTEs)

**Goal:** Simplify complex queries and reuse intermediate results.

### Subqueries

Subqueries are queries within queries.
They allow you to filter results dynamically.

Example:
```sql
SELECT city, COUNT(customer_id)
FROM customer
WHERE country_id IN (
    SELECT country_id
    FROM country
    WHERE country = 'India'
)
GROUP BY city;


Use when you need to filter based on a separate query result.

### Common Table Expressions (CTEs)

CTEs (WITH clauses) are temporary result sets that can be referenced multiple times within a query.

Example:
```sql
WITH top_countries AS (
    SELECT country_id
    FROM country
    JOIN city USING (country_id)
    JOIN address USING (city_id)
    JOIN customer USING (address_id)
    GROUP BY country_id
    ORDER BY COUNT(customer_id) DESC
    LIMIT 10
)
SELECT city.city, country.country, COUNT(customer.customer_id)
FROM city
JOIN country USING (country_id)
JOIN address USING (city_id)
JOIN customer USING (address_id)
WHERE country.country_id IN (SELECT country_id FROM top_countries)
GROUP BY city.city, country.country
ORDER BY COUNT(customer.customer_id) DESC
LIMIT 10;


Use CTEs for better readability, modularity, and when reusing the same logic multiple times.