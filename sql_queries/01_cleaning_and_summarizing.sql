/*
---------------------------------------------------------
01_cleaning_and_summarizing.sql
Author: [Daniela Branca]
Project: Rockbuster Data Analysis
Goal: Check for dirty, missing, or inconsistent data
---------------------------------------------------------
*/

---------------------------------------------------------
-- 1. Check for duplicate records in the film table
---------------------------------------------------------
SELECT 
    title,
    release_year,
    language_id,
    rental_duration,
    COUNT(*)
FROM film
GROUP BY title, release_year, language_id, rental_duration
HAVING COUNT(*) > 1;  -- No result = no duplicates

---------------------------------------------------------
-- 2. Delete duplicate records (if any)
---------------------------------------------------------
DELETE
FROM film
WHERE film_id NOT IN (
    SELECT MIN(film_id)
    FROM film
    GROUP BY title, release_year, language_id, rental_duration
);

---------------------------------------------------------
-- 3. Check for non-uniform data
---------------------------------------------------------
SELECT DISTINCT language_id FROM film;
SELECT DISTINCT release_year FROM film;
SELECT DISTINCT rental_duration FROM film;

-- Example of fixing inconsistent data
UPDATE film
SET rating = 'G'
WHERE rating IN ('gen', 'g', 'General');

---------------------------------------------------------
-- 4. Check for missing (NULL) values
---------------------------------------------------------
SELECT * 
FROM film
WHERE title IS NULL
   OR release_year IS NULL
   OR language_id IS NULL
   OR rental_duration IS NULL;

---------------------------------------------------------
-- 5. Impute missing numerical values using AVG
---------------------------------------------------------
UPDATE film
SET rental_duration = (
    SELECT AVG(rental_duration)
    FROM film
)
WHERE rental_duration IS NULL;

---------------------------------------------------------
-- 6. Summarize data in the film table
---------------------------------------------------------
SELECT
  COUNT(*) AS total_rows,
  MIN(length) AS min_length,
  MAX(length) AS max_length,
  AVG(length) AS avg_length,
  MODE() WITHIN GROUP (ORDER BY rating) AS mode_rating
FROM film;

---------------------------------------------------------
-- 7. Summarize data in the customer table
---------------------------------------------------------
SELECT
  COUNT(*) AS total_rows,
  MIN(customer_id) AS min_customer_id,
  MAX(customer_id) AS max_customer_id,
  MODE() WITHIN GROUP (ORDER BY activebool) AS mode_active_status,
  MIN(create_date) AS earliest_create_date,
  MAX(create_date) AS latest_create_date
FROM customer;
