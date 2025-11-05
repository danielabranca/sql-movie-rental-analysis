# Comparison: Subqueries vs. Common Table Expressions (CTEs)

## 🔍 Objective
To compare the performance and readability of subqueries and Common Table Expressions (CTEs) while finding:
- The top 5 customers by total amount paid.
- The average total amount paid by these customers.
- How many of the top 5 customers come from each country.

---

## 🧩 Method

1. **Subqueries version:** Implemented in `queries/03_subqueries.sql`
2. **CTE version:** Implemented in `queries/04_ctes.sql`

Both versions perform the same logic:
- Aggregate total payments by customer.
- Filter to the top 5 spenders.
- Compute the average and distribution across countries.

---

## 📊 Output (Sample)

| Country              | All Customer Count | Top Customer Count |
|----------------------|-------------------:|-------------------:|
| India                | 60                 | 1 |
| United States        | 36                 | 1 |
| Mexico               | 30                 | 2 |
| Turkey               | 15                 | 1 |
| China                | 53                 | 0 |
| ...                  | ...                | ... |

**Average total amount paid (top 5 customers):**  
≈ *[depends on DB output, e.g., 138.50 USD]*

---

## 💡 Observations

- **Logic parity:** Both versions produce identical results.
- **Readability:** The CTE is clearer; each logical step is named (`top_5_customers`).
- **Reusability:** CTEs can be referenced multiple times without repeating code.
- **Performance:** Comparable in small datasets; CTEs can be slightly slower in some databases if not optimized, but readability usually outweighs that in analytical work.

---

## 🧠 Conclusion

CTEs are preferred for complex analytical SQL because:
- They make queries modular and readable.
- They allow for easy debugging and team collaboration.
- They separate “what” (data you want) from “how” (steps to get there).

For quick one-off filters or very short logic, subqueries are still perfectly fine.
