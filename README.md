# Rockbuster Stealth SQL Analysis

## Project Background

**Rockbuster Stealth LLC** is a fictional global movie rental company preparing to transition from traditional rental services to an **online video streaming platform**.

SQL was used to explore Rockbuster's customer, rental, payment, film and geographic data in order to identify the markets, customer segments and content categories that could inform the company's streaming strategy.

The analysis focuses on four key business questions:

* **Where are Rockbuster's strongest markets and highest-value customers?**
* **Which film categories generate the most rentals and revenue?**
* **Which movie ratings are associated with the highest revenue?**
* **Which countries and customer segments represent opportunities for growth?**

The analysis was conducted in **PostgreSQL using pgAdmin 4**, with Tableau used to communicate the findings through an interactive presentation.

- An interactive Tableau Public dashboard can be seen [here.](https://public.tableau.com/app/profile/danielabranca/viz/3_10_17531376523820/TheStory)

- The SQL queries used to inspect and perform quality checks and do exploratory data analysis can be seen [here.](https://github.com/danielabranca/sql-movie-rental-analysis/tree/main/sql_queries)

- The SQL series used to clean, organize and prepare data for the dashboard can be found [here.](https://github.com/danielabranca/sql-movie-rental-analysis/tree/main/sql_pdfs)

- The data dictionary, ERD, the final presentation pdf and the excel file with the resulting tables from the SQL queries used for the dashboard can be seen [here.](https://github.com/danielabranca/sql-movie-rental-analysis/tree/main/sql_docs)
---

# Data Structure & Initial Exploration

The Rockbuster database contains information on films, customers, rentals, payments, inventory, categories and geographic locations. Here follows the Entity Relationship Diagram of the set of tables:
![See the ERD here.](https://github.com/danielabranca/sql-movie-rental-analysis/blob/28e5b343aacafa018ac3c647e67461a33f34edb8/sql_docs/ERD%20DbViz.jpg)

And the data dictionary, that can be seen [here](https://github.com/danielabranca/sql-movie-rental-analysis/blob/main/sql_docs/Data%20Dictionary.pdf)

For the initial exploration, it was examined the structure and descriptive statistics of the **film** and **customer** tables before joining the relevant tables to answer specific business questions.

### Dataset at a glance

| Metric                  |       Value |
| ----------------------- | ----------: |
| Films                   |       1,000 |
| Customers               |         599 |
| Film categories         |          17 |
| Countries represented   |         109 |
| Average rental duration |   4.99 days |
| Average rental rate     |       $2.98 |
| Average film length     | 115 minutes |
| Most common rating      |       PG-13 |

Film rental durations range from **3 to 7 days**, while rental rates range from **$0.99 to $4.99**.

The database exploration and descriptive statistics were performed directly in PostgreSQL before the analytical queries were developed, [which can be found here.](https://github.com/danielabranca/sql-movie-rental-analysis/tree/main/sql_queries), and [here.](https://github.com/danielabranca/sql-movie-rental-analysis/blob/main/sql_docs/Rockbuster%20Excel%20Book.xlsx)

---

# Executive Summary

The analysis indicates that Rockbuster's existing customer base is concentrated in a relatively small number of markets. **India and China are the two largest markets by both customer count and revenue**, followed by the United States and Japan.

From a content perspective, **Sports, Sci-Fi and Animation** generate some of the highest rental volumes and revenues, while **PG-13 and NC-17 films generate the highest revenue by rating**.

These findings suggest that Rockbuster could use its existing customer and rental data to prioritise initial streaming-market expansion, content investment and targeted customer acquisition campaigns.

---

# Insights Deep Dive

## 1. Geographic Markets

Rockbuster operates across **109 countries**, but customer activity and revenue are not evenly distributed.

The largest customer bases are concentrated in:

| Country       | Customers | Total Sales |
| ------------- | --------: | ----------: |
| India         |        60 |   $6,032.79 |
| China         |        53 |   $5,247.04 |
| United States |        36 |   $3,694.27 |
| Japan         |        31 |   $3,121.52 |
| Mexico        |        30 |   $2,984.82 |

India and China therefore stand out as the strongest existing markets, combining relatively large customer populations with the highest recorded sales.

The analysis also identified countries such as **Turkey, Taiwan and the Philippines** as smaller markets with existing customer activity and potential for further customer acquisition.

![Geographic customer and revenue visualisation](https://github.com/danielabranca/sql-movie-rental-analysis/blob/main/sql_docs/map_customers.png)

![Most favorable niche](https://github.com/danielabranca/sql-movie-rental-analysis/blob/main/sql_docs/fav_niche.png)

---

## 2. Customer Value

To investigate customer value more closely, the analysis was narrowed from the strongest countries to their highest-represented cities and then identified the customers who had generated the highest payment totals within those selections. 

- The SQL queries used for this purpose can be found in the excel file [here]().

The five highest-value customers identified through this analysis were:

| Customer         | City    | Country       | Total Paid |
| ---------------- | ------- | ------------- | ---------: |
| Sara Perry       | Atlixco | Mexico        |    $128.70 |
| Gabriel Harder   | Sivas   | Turkey        |    $108.75 |
| Sergio Stanfield | Celaya  | Mexico        |    $102.76 |
| Clinton Buford   | Aurora  | United States |     $98.76 |
| Adam Gooch       | Adoni   | India         |     $97.80 |

This analysis demonstrates how geographic segmentation can be combined with customer-level payment data to identify high-value customers within priority markets.

![Customer segmentation visualisation](https://github.com/danielabranca/sql-movie-rental-analysis/blob/main/sql_docs/Most%20profitable%20clients.jpg)

---

## 3. Film Categories Revenue

Rental behaviour varies considerably across the **17 film categories** in the database.

The highest-performing categories by rental volume and revenue include:

| Category  | Rentals |   Revenue |
| --------- | ------: | --------: |
| Sports    |   1,081 | $4,892.19 |
| Sci-Fi    |     998 | $4,336.01 |
| Animation |   1,065 | $4,245.31 |
| Drama     |     953 | $4,118.46 |
| New       |     875 | $4,014.27 |
| Comedy    |     851 | $4,002.48 |
| Action    |   1,013 | $3,951.84 |

**Sports generates the highest revenue and rental volume**, while Sci-Fi and Animation also show strong demand.

These categories could therefore be considered when evaluating the content mix for Rockbuster's online service.

---

## 4. Movie Ratings Revenue

Revenue also varies by movie rating.

| Rating | Total Revenue |
| ------ | ------------: |
| PG-13  |    $13,855.56 |
| NC-17  |    $12,634.92 |
| PG     |    $12,236.65 |
| R      |    $12,073.03 |
| G      |    $10,511.88 |

**PG-13 generates the highest total revenue**, followed by NC-17 and PG.

This provides another dimension for understanding customer demand and could be considered alongside category performance when evaluating which types of content to prioritise for the streaming platform.

![Revenue and rental volume by category and movie rating revenue](https://github.com/danielabranca/sql-movie-rental-analysis/blob/main/sql_docs/categories_ratings_revenue.png)

---

# Recommendations

Based on the analysis, Rockbuster could consider the following strategic actions:

### Prioritise established markets

India, China, the United States and Japan combine relatively strong customer numbers and revenue. These markets could be considered priority markets when planning the initial streaming rollout.

### Target emerging markets

Countries including Turkey, Taiwan and the Philippines show existing customer activity but substantially lower sales than the largest markets. Targeted acquisition campaigns could be used to investigate and develop these markets.

### Invest in high-performing content categories

Sports, Sci-Fi and Animation show strong rental activity and revenue. These categories could be considered when determining the initial content mix for the streaming service.

### Use customer value for retention

Customer-level payment data can be used to identify high-value customers. Rockbuster could develop loyalty initiatives, such as discounts or promotional rentals, to encourage continued engagement.

### Consider differentiated pricing and promotions

Lower-performing markets could be tested with targeted promotional offers or adjusted pricing strategies rather than applying a single approach across all geographic markets.

---

# SQL Analysis

The analysis was conducted using **PostgreSQL** and included:

* Database and table structure exploration
* Descriptive statistics
* Multi-table `JOIN`s
* `GROUP BY` and aggregate functions
* Customer and geographic segmentation
* Revenue analysis
* Rental-volume analysis
* Subqueries and filtering
* Ranking and sorting of business results

The SQL queries and their corresponding extracted results are available in the repository.

---

# Assumptions & Caveats

* Rockbuster Stealth is a **fictional company and business scenario** used for analytical practice.
* The dataset was provided through CareerFoundry for educational purposes.
* Revenue refers to recorded payment amounts in the available database.
* Geographic comparisons are based on the customer addresses represented in the dataset.
* Market opportunity is inferred from existing customer and revenue patterns. The analysis does not include external market size, competitor data or streaming-industry forecasts.
* Recommendations therefore represent **data-informed hypotheses for further investigation**, rather than forecasts of future performance.

---

# Tools & Technologies

* **PostgreSQL**
* **pgAdmin 4**
* **SQL**
* **Excel**
* **Tableau Public**

---

# Repository Structure

sql-rockbuster-stealth-analysis/

sql_queries/ # SQL queries in sql format

sql_notes/ # SQL scripts in md format

sql_pdfs/ # SQL exercises and answers, EDA in detail

sql_docs/ # Data dictionary, EDR diagram and analysis presentation in pdf format 

README.md

---

# Project Deliverables

📊 **Tableau presentation:**
[Rockbuster Stealth: Strategic Decisions for the Digital Leap](https://public.tableau.com/app/profile/danielabranca/viz/3_10_17531376523820/TheStory)

💻 **SQL queries:**
Available in the `sql_queries/` and `sql_pdfs` directory.

📁 **Analysis documentation and extracted results:**
Available in the `sql_notes/` and `sql_docs/` directories.

---

