-- Time Analysis

-- 1: Revenue by Year

SELECT
    year,
    ROUND(SUM(total_cost),2) AS revenue
FROM retail_transactions
GROUP BY year
ORDER BY year;

-- 2: Revenue by Quarter

SELECT
    quarter,
    ROUND(SUM(total_cost),2) AS revenue
FROM retail_transactions
GROUP BY quarter
ORDER BY quarter;

-- 3: Revenue by Month

SELECT
    month,
    ROUND(SUM(total_cost),2) AS revenue
FROM retail_transactions
GROUP BY month
ORDER BY revenue DESC;

-- 4: Revenue by Day of Week

SELECT
    day_name,
    ROUND(SUM(total_cost),2) AS revenue
FROM retail_transactions
GROUP BY day_name
ORDER BY revenue DESC;

-- 5: Revenue Growth %

WITH yearly_revenue AS (
    SELECT
        year,
        SUM(total_cost) AS revenue
    FROM retail_transactions
    GROUP BY year
)
SELECT
    year,
    ROUND(revenue,2) AS revenue,
    ROUND(
        (revenue -
         LAG(revenue) OVER(ORDER BY year))
        * 100 /
         LAG(revenue) OVER(ORDER BY year),
        2
    ) AS growth_pct
FROM yearly_revenue;