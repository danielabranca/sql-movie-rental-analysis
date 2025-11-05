## Cleaning and Summarizing Data

**Goal:** Prepare and explore Rockbuster’s database for analysis.

### Key Steps:
1. **Check for duplicates**
   ```sql
   SELECT title, release_year, language_id, rental_duration, COUNT(*)
   FROM film
   GROUP BY title, release_year, language_id, rental_duration
   HAVING COUNT(*) > 1;

   No results means no duplicates.
   To fix duplicates, create a VIEW or delete duplicates based on a unique key (film_id).

2. **Check for non-uniform data**
   ```sql
   SELECT DISTINCT rating FROM film;

Fix inconsistencies (ex, 'gen', 'g', 'General') using:
   ```sql
      UPDATE film
      SET rating = 'G'
      WHERE rating IN ('gen', 'g', 'General');

3. **Check for missing Data**
   ```sql
SELECT * 
FROM film
WHERE title IS NULL
   OR release_year IS NULL
   OR language_id IS NULL;

Omit, filter out, or impute missing values where necessary.

4. **Summarize numerical and categorical data**
Use aggregate functions: MIN(), MAX(), AVG(), and MODE()
```sql
SELECT 
  COUNT(*) AS total_rows,
  AVG(rental_rate) AS avg_rental_rate,
  MODE() WITHIN GROUP (ORDER BY rating) AS mode_rating
FROM film;

Outcome: Clean, validated data ready for exploration nd validation.


   