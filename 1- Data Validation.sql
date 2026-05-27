-- Business aanalysis

-- 1. Top 10 Cities by Revenue

select 
	city,
    round(sum(total_cost), 2) as Revenue
    from retail_transactions
    group by city
    order by Revenue desc
    limit 10;
    
-- 2. Revenue by store type

select 
	store_type,
	round(sum(total_cost), 2) as Revenue
    from retail_transactions
    group by Store_Type
    order by revenue desc;
    
-- 3. Revenue by Customer Category

select 
	Customer_Category,
    round(sum(total_cost), 2) as Revenue
    from retail_transactions
    group by Customer_Category
    order by revenue desc;
    
-- 4. Promotion Performance

select
	promotion,
    round(sum(total_cost), 2) as Revenue,
    round(avg(total_cost)) as avg_order_value,
    count(*) as transactions
from retail_transactions
group by Promotion
order by revenue desc;

-- 5. Payment Method Analysis

select 
	payment_method,
    round(sum(total_cost), 2) as Revenue,
    count(*) as transactions
from retail_transactions
group by Payment_Method
order by revenue desc;

-- 6. 
    
