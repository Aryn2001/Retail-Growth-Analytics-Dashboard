-- Geography analysis

-- 1: Top 10 Cities by Revenue

select
city,
round(sum(total_cost),2) as Revenue
from retail_transactions
group by city
order by revenue desc limit 10;

-- 2: Bottom 10 Cities by Revenue

select
city,
round(sum(total_cost),2) as Revenue
from retail_transactions
group by city
order by revenue asc limit 10;

-- 3: Revenue Contribution by City (%)

select 
	city,
    round(sum(total_cost) * 100 / 
    (select sum(total_cost)
    from retail_transactions), 2) as revenue_percentage
    from retail_transactions
    group by city
    order by revenue_percentage desc;
    
-- 4: Transaction Volume by City

select
	city,
    count(*) as transactions
from retail_transactions
group by city
order by transactions desc;

-- 5: Average Order Value (AOV) by City

SELECT
    city,
    ROUND(AVG(total_cost),2) AS avg_order_value
FROM retail_transactions
GROUP BY city
ORDER BY avg_order_value DESC;

-- 6. Cities Above Overall Average Revenue

with city_revenue  as(
	select
    city, 
    sum(total_cost)  as revenue
    from retail_transactions
    group by city
)
select * 
from city_revenue
where revenue > 
(
	select avg(revenue)
    from city_revenue
)
order by revenue desc;

-- 7: Rank Cities by Revenue 

select 
	city,
    round(sum(total_cost),2) as revenue,
    rank() over(
		order by sum(total_cost) desc
    ) as city_rank
from retail_transactions
group by city;

-- 8. Top Revenue City

SELECT
    city,
    ROUND(SUM(total_cost),2) AS revenue
FROM retail_transactions
GROUP BY city
ORDER BY revenue DESC
LIMIT 1;
