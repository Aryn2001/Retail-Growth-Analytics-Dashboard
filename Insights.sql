SELECT City, SUM(Total_Cost)
FROM retail_transactions
GROUP BY City
ORDER BY 2 DESC;