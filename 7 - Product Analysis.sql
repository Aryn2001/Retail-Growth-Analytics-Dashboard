-- Product Analysis

-- 1: Top 20 Products by Revenue

select
	product,
    round(sum(total_cost),2) as revenue
    from retail_transactions
group by product
order by revenue desc limit 20;

-- 2.Product Revenue Contribution

SELECT
    product,
    ROUND(
        SUM(total_cost)*100/
        (SELECT SUM(total_cost)
         FROM retail_transactions),
        2
    ) revenue_pct
FROM retail_transactions
GROUP BY product
ORDER BY revenue_pct DESC
LIMIT 20;

-- 3. Top Product by City 

with product_city as (
select
	city,
    product,
    sum(total_cost) revenue,
    row_number() over(
		partition by city
        order by sum(total_cost) desc
	) rn
from retail_transactions
group by city, product
)
select * 
from product_city
where rn = 1;

-- 4: Top Product by Customer Category

WITH product_customer AS (
SELECT
    customer_category,
    product,
    SUM(total_cost) revenue,
    ROW_NUMBER() OVER(
        PARTITION BY customer_category
        ORDER BY SUM(total_cost) DESC
    ) rn
FROM retail_transactions
GROUP BY customer_category,product
)
SELECT *
FROM product_customer
WHERE rn=1;