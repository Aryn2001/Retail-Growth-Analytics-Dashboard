-- Store Analysis

--  1: Revenue by Store Type

select 
	store_type,
    round(sum(total_cost),2) as revenue
from retail_transactions
group by Store_Type
order by revenue desc;

--  2: Transaction Volume by Store Type

SELECT
    store_type,
    COUNT(*) AS transactions
FROM retail_transactions
GROUP BY store_type
ORDER BY transactions DESC;

-- 3: Average Order Value by Store Type

select 
	store_type,
    round(avg(total_cost),2) as avg_order_value
from retail_transactions
group by Store_Type
order by avg_order_value desc;

-- 4. Average Basket Value by Store Type

SELECT
    store_type,
    ROUND(AVG(avg_basket_value),2) AS avg_basket_value
FROM retail_transactions
GROUP BY store_type
ORDER BY avg_basket_value DESC;

--  5.Revenue Contribution by Store Type

SELECT
    store_type,
    ROUND(
        SUM(total_cost) * 100 /
        (SELECT SUM(total_cost)
         FROM retail_transactions),
        2
    ) AS revenue_pct
FROM retail_transactions
GROUP BY store_type
ORDER BY revenue_pct DESC;

-- 6. Store Type Ranking

select 
	store_type,
    round(sum(total_cost),2) as revenue,
    rank() over(
		order by sum(total_cost) desc
	) as store_rank
from retail_transactions
group by Store_Type;

-- 7: Best Store Type in Each City

with city_store_revenue as (
select 
	city,
    store_type,
    sum(total_cost) as revenue,
    row_number() over(
		partition by city
        order by sum(total_cost) desc
	) as rn
from retail_transactions
group by city, store_type
)

select
	city,
    store_type,
    round(revenue,2) as revenue
from city_store_revenue
where rn = 1;

-- 7: Best Store Type in Each City

WITH city_store_revenue AS (
SELECT
    city,
    store_type,
    SUM(total_cost) AS revenue,
    ROW_NUMBER() OVER(
        PARTITION BY city
        ORDER BY SUM(total_cost) DESC
    ) AS rn
FROM retail_transactions
GROUP BY city, store_type
)

SELECT
    city,
    store_type,
    ROUND(revenue,2) AS revenue
FROM city_store_revenue
WHERE rn = 1;

--  8: Cities Where Store Revenue Exceeds Overall Store Average

WITH store_city AS (
SELECT
    city,
    store_type,
    SUM(total_cost) AS revenue
FROM retail_transactions
GROUP BY city, store_type
)

SELECT *
FROM store_city
WHERE revenue >
(
SELECT AVG(revenue)
FROM store_city
)
ORDER BY revenue DESC;

-- 9: Top 3 Store Types by Revenue

WITH store_rev AS (
SELECT
    store_type,
    SUM(total_cost) AS revenue
FROM retail_transactions
GROUP BY store_type
)

SELECT
    store_type,
    ROUND(revenue,2) AS revenue,
    DENSE_RANK() OVER(
        ORDER BY revenue DESC
    ) AS rank_no
FROM store_rev
WHERE revenue IS NOT NULL;

-- 10: Revenue Distribution Across Cities and Store Types

SELECT
    city,
    store_type,
    ROUND(SUM(total_cost),2) AS revenue
FROM retail_transactions
GROUP BY city, store_type
ORDER BY city;