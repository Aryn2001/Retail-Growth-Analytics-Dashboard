-- Customer Analytics


-- 1: Revenue by Customer Category

select 
	customer_category,
    round(sum(total_cost),2) as revenue
    from retail_transactions
group by customer_category
order by revenue desc;

-- 2: Average Spend by Customer Category

select
	customer_category,
    round(avg(total_cost),2) as avg_spend
    from retail_transactions
group by Customer_Category
order by avg_spend desc;

-- 3. Transaction Count by Customer Category

SELECT
    customer_category,
    COUNT(*) AS transactions
FROM retail_transactions
GROUP BY customer_category
ORDER BY transactions DESC;

-- Top 20 Customers by Revenue

select
	customer_name,
    round(sum(total_cost),2) as revenue
    from retail_transactions
group by Customer_Name
order by revenue desc limit 20;

-- 5: Most Frequent Customers

select 
	customer_name,
    count(*) as total_orders
from retail_transactions
group by Customer_Name
order by total_orders desc
limit 20;

-- 6.Revenue Contribution by Customer Category

SELECT
    customer_category,
    ROUND(
        SUM(total_cost) * 100 /
        (SELECT SUM(total_cost)
         FROM retail_transactions),
        2
    ) AS revenue_pct
FROM retail_transactions
GROUP BY customer_category
ORDER BY revenue_pct DESC;

-- 7: Customer Segmentation using CASE WHEN

select
case
	when total_cost < 25 then 'Low Value'
    when total_cost between 25 and 75 then 'Medium Value'
    else 'High Value'
end as customer_segment,
count(*) as transactions
from retail_transactions
group by customer_segment
order by transactions desc;

-- 8: Revenue by Customer Segment

SELECT
CASE
    WHEN total_cost < 25 THEN 'Low Value'
    WHEN total_cost BETWEEN 25 AND 75 THEN 'Medium Value'
    ELSE 'High Value'
END AS customer_segment,
ROUND(SUM(total_cost),2) AS revenue
FROM retail_transactions
GROUP BY customer_segment
ORDER BY revenue DESC;

-- 9: Rank Customer Categories by Revenue

select
	customer_category,
    round(sum(total_cost),2) as  revenue,
    rank() over(
		order by sum(total_cost) desc
    ) as category_rank
from retail_transactions
group by Customer_Category;

--  10: Top Customer Category by Average Basket Value

SELECT
    customer_category,
    ROUND(AVG(avg_basket_value),2) AS basket_value
FROM retail_transactions
GROUP BY customer_category
ORDER BY basket_value DESC;

-- 11: Repeat Customers

select
	customer_name,
    count(*) as total_orders
from retail_transactions
group by customer_name
having count(*) > 5
order by total_orders desc
limit 50;

