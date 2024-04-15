CREATE DATABASE IF NOT EXISTS salesDataWalmart;

CREATE TABLE IF NOT EXISTS sales (
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    brand VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6, 4) NOT NULL,
    total DECIMAL (12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    cogs DECIMAL(10, 2) NOT NULL,
    gross_margin_pct FLOAT(11, 9),
    gross_income DECIMAL(12, 4) NOT NULL,
    rating FLOAT(2, 1)  
);

-- Create a new column named time_of_day to give insight of sales in the Morning, Afternoon and Evening depending on the time

SELECT time FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales 
SET time_of_day = (
	CASE 
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
	END
);


-- Create a new column names day_name that contains the extracted days of the week on which the given transaction took place: Mon, Tue, Wed, Thur, Fri

SELECT date FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);



-- Create  a new column named month_name that extracts the month of the year on which the transaction took place: Jan, Feb, Mar and so on

ALTER TABLE sales ADD COLUMN month_name varchar(10);

UPDATE sales
SET month_name = monthname(date);


-- How many cities does the data have?

SELECT DISTINCT CITY  FROM sales;


-- In which city is each branch?
ALTER TABLE sales
RENAME COLUMN brand to branch; 

SELECT DISTINCT city, branch  FROM sales;


-- How many unique product lines does the data have?
SELECT  DISTINCT product_line FROM sales;
SELECT  COUNT(DISTINCT product_line) AS unique_number_of_product_line FROM sales;


-- What is the most common payment method?

SELECT payment_method, COUNT(payment_method) AS payment_count FROM sales 
GROUP BY payment_method
ORDER BY payment_count DESC;



-- What is the most selling product line?

SELECT product_line, COUNT(product_line) AS product_line_count FROM sales 
GROUP BY product_line
ORDER BY product_line_count DESC;


-- What is the total revenue by month?

SELECT 
	month_name AS month,
	SUM(total) AS total_revenue 
FROM sales
GROUP BY month
ORDER BY total_revenue DESC;


-- What month has the highest COGS(Cost of Goods Sold)?

SELECT
	month_name as month, 
    SUM(cogs) AS cogs 
FROM sales
GROUP BY month
ORDER BY cogs DESC;


-- What product line has the largest revenue?
 
SELECT 
	product_line,
    SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC; 


-- What city has the largest revenue?

SELECT 
	city,
    SUM(total) as total_revenue
FROM sales
GROUP BY city
ORDER BY total_revenue DESC; 


-- What product line has the largest VAT?

SELECT 
	product_line,
    SUM(VAT) as vat
FROM sales
GROUP BY product_line
ORDER BY vat DESC; 


-- Which branch sold more product than average product sold

SELECT 
	branch,
    SUM(quantity) as quanity_sum
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);


-- What is the most common product line by gender?

SELECT 
	gender, 
    product_line, 
    COUNT(gender) AS gen 
FROM sales
GROUP BY gender, product_line
ORDER BY gen DESC;



-- What is the average rating of each product?

SELECT 
	product_line,
    ROUND(AVG(rating), 2) AS avg_ratings
FROM sales
GROUP BY product_line
ORDER BY avg_ratings DESC;


