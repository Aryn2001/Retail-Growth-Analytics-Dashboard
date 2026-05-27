-- Promotion Analysis

-- 1: Revenue by Promotion Type

SELECT
    promotion,
    ROUND(SUM(total_cost),2) AS revenue
FROM retail_transactions
GROUP BY promotion
ORDER BY revenue DESC;

-- 2. Revenue Comparison (Promotion vs No Promotion)

SELECT
CASE
    WHEN promotion = 'No Promotion'
    THEN 'No Promotion'
    ELSE 'Promotion Applied'
END AS promo_status,
ROUND(SUM(total_cost),2) AS revenue,
COUNT(*) AS transactions,
ROUND(AVG(total_cost),2) AS avg_order_value
FROM retail_transactions
GROUP BY promo_status;

-- 3. Best Promotion by Season

WITH seasonal_promo AS (
SELECT
    season,
    promotion,
    SUM(total_cost) AS revenue,
    ROW_NUMBER() OVER(
        PARTITION BY season
        ORDER BY SUM(total_cost) DESC
    ) AS rn
FROM retail_transactions
GROUP BY season,promotion
)

SELECT
    season,
    promotion,
    ROUND(revenue,2) AS revenue
FROM seasonal_promo
WHERE rn = 1;

