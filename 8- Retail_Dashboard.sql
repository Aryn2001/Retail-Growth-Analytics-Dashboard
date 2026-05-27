CREATE TABLE retail_dashboard AS
SELECT
    Year,
    Month,
    Quarter,
    City,
    Store_Type,
    Customer_Category,
    Promotion,
    ROUND(SUM(Total_Cost),2) AS Revenue,
    COUNT(*) AS Transactions,
    ROUND(AVG(Total_Cost),2) AS Avg_Order_Value,
    SUM(Total_Items) AS Total_Items
FROM retail_transactions
GROUP BY
    Year,
    Month,
    Quarter,
    City,
    Store_Type,
    Customer_Category,
    Promotion;
    
select * from retail_dashboard;

SELECT COUNT(*)
FROM retail_dashboard;

