/*
---------------------------------------------------------
04_ctes.sql
Author: [Daniela Branca]
Project: Rockbuster Data Analysis
Goal: Rewrite subqueries as Common Table Expressions (CTEs)
      and compare readability / reuse vs. subqueries.
---------------------------------------------------------
*/

---------------------------------------------------------
-- CTE Example 1: Top 5 customers (detailed) and their average total paid
---------------------------------------------------------
WITH top_5_customers AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        ci.city,
        co.country,
        SUM(p.amount) AS total_amount_paid
    FROM country AS co
    INNER JOIN city AS ci ON co.country_id = ci.country_id
    INNER JOIN address AS a ON ci.city_id = a.city_id
    INNER JOIN customer AS c ON a.address_id = c.address_id
    INNER JOIN payment AS p ON c.customer_id = p.customer_id
    WHERE ci.city IN (
        'Aurora', 'Atlixco', 'Xintai', 'Adoni', 'Dhule (Dhulia)',
        'Kurashiki', 'Pingxiang', 'Sivas', 'Celaya', 'So Leopoldo'
    )
    AND co.country IN (
        'India', 'China', 'United States', 'Japan', 'Mexico', 'Brazil',
        'Russian Federation', 'Philippines', 'Turkey', 'Indonesia'
    )
    GROUP BY c.customer_id, c.first_name, c.last_name, ci.city, co.country
    ORDER BY total_amount_paid DESC
    LIMIT 5
)
SELECT AVG(total_amount_paid) AS average_total_paid
FROM top_5_customers;

---------------------------------------------------------
-- CTE Example 2: Count how many of the "top 5 customers" come from each country
---------------------------------------------------------
WITH top_5_customers AS (
    SELECT
        c.customer_id,
        co.country
    FROM country AS co
    INNER JOIN city AS ci ON co.country_id = ci.country_id
    INNER JOIN address AS a ON ci.city_id = a.city_id
    INNER JOIN customer AS c ON c.address_id = a.address_id
    INNER JOIN payment AS p ON c.customer_id = p.customer_id
    WHERE ci.city IN (
        'Aurora', 'Atlixco', 'Xintai', 'Adoni', 'Dhule (Dhulia)',
        'Kurashiki', 'Pingxiang', 'Sivas', 'Celaya', 'So Leopoldo'
    )
    AND co.country IN (
        'India', 'China', 'United States', 'Japan', 'Mexico', 'Brazil',
        'Russian Federation', 'Philippines', 'Turkey', 'Indonesia'
    )
    GROUP BY c.customer_id, co.country
    ORDER BY SUM(p.amount) DESC
    LIMIT 5
)
SELECT
    co.country,
    COUNT(DISTINCT c.customer_id) AS all_customer_count,
    COUNT(DISTINCT t5.customer_id) AS top_customer_count
FROM country AS co
INNER JOIN city AS ci ON co.country_id = ci.country_id
INNER JOIN address AS a ON ci.city_id = a.city_id
INNER JOIN customer AS c ON c.address_id = a.address_id
LEFT JOIN top_5_customers AS t5 ON t5.customer_id = c.customer_id
GROUP BY co.country
ORDER BY all_customer_count DESC;

---------------------------------------------------------
-- Reflection (kept as SQL comment for reviewers)
---------------------------------------------------------
/*
Reflection:
- CTEs break complex queries into named, reusable steps which improves readability.
- They are easier to debug and to reference multiple times in the same query.
- Results from CTEs match the subquery versions (same logic), but maintainable code is easier for team reviewers.
- Use CTEs when you want clarity and stepwise logic; subqueries are fine for short, single-use transforms.
*/
