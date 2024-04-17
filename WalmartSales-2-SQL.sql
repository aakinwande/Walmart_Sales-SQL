SELECT * FROM SALES;
 
 
-- Number of sales made in each time of the day per weekday

SELECT
	time_of_day,
    COUNT(*) AS total_sales
FROM sales
WHERE day_name = "Monday"
GROUP BY time_of_day
ORDER BY total_sales DESC;


-- Which of the customer type generates the most revenue?

SELECT 
	customer_type, 
    SUM(total) AS total_generated_revenue
FROM SALES
GROUP BY customer_type
ORDER BY total_generated_revenue DESC;



-- Which City has the largest VAT (Value Added Tax)

SELECT 
	city, 
    AVG(VAT) AS VAT_TOTAL
FROM sales
GROUP BY city
ORDER BY VAT_TOTAL DESC;


-- Which customer type pays the most VAT?

SELECT 
	customer_type,
	AVG(VAT) AS VAT_TOTAL
FROM sales
GROUP BY customer_type
ORDER BY VAT_TOTAL DESC;


-- How many unique customer types does the data have?

SELECT 
	DISTINCT(customer_type)
FROM sales;


-- How many unique payment methods does the data have?

SELECT 
	DISTINCT(payment_method)
FROM sales;


-- What is the most common customer type?

SELECT 
	customer_type,
    COUNT(*) AS most_common_customer_type
FROM sales
GROUP BY customer_type
ORDER BY most_common_customer_type DESC;


-- Which customer type buys the most

SELECT 
	customer_type,
    COUNT(*) AS most_common_customer_type
FROM sales
GROUP BY customer_type
ORDER BY most_common_customer_type DESC;


-- What is the gender of most of the customers?

SELECT 
	gender,
    COUNT(*) AS most_gender
FROM sales
GROUP BY gender
ORDER BY most_gender DESC;


-- What is the gender distribution by branch?

SELECT 
	gender,
    COUNT(*) AS most_gender
FROM sales
WHERE branch = "A"
GROUP BY gender
ORDER BY most_gender DESC;


-- What time of the day do customers give most ratings?

SELECT 
	time_of_day,
    AVG(rating) as rate
FROM sales
GROUP BY time_of_day
ORDER BY rate DESC;


-- What time of the day do customers give most ratings per branch?

SELECT 
	time_of_day,
    AVG(rating) as rate
FROM sales
WHERE branch = "B"
GROUP BY time_of_day
ORDER BY rate DESC;


-- Which day of the week has the best average ratings?

SELECT 
	day_name,
    AVG(rating) AS rate_avg
FROM sales
GROUP BY day_name
ORDER BY rate_avg DESC;


-- Which day of the week has the best average ratings per branch?

SELECT 
	day_name,
    AVG(rating) AS rate_avg
FROM sales
WHERE branch = "A"
GROUP BY day_name
ORDER BY rate_avg DESC;

