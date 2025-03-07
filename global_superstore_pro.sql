-- Duplicate rows in sales_data --
SELECT order_id, Product_ID, COUNT(*)
FROM sql_projects.sales_data
group by Order_ID, product_id
having COUNT(*) > 1 
;

-- Removing Duplicates --
WITH duplicates AS(
SELECT *,
	ROW_NUMBER() OVER (PARTITION BY Order_ID, Product_ID ORDER BY row_ID) AS row_no
 FROM sales_data) 
 DELETE FROM sales_data
 WHERE Row_ID IN ( SELECT Row_id FROM duplicates WHERE row_no> 1);
 
 
 -- Identityfying missing values --
 SELECT SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_missing,
		SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS order_date_missing,
        SUM(CASE WHEN ship_date IS NULL THEN 1 ELSE 0 END) AS ship_date_missing,
        SUM(CASE WHEN ship_mode IS NULL THEN 1 ELSE 0 END) AS ship_mode_missing,
        SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id_missing,
        SUM(CASE WHEN customer_name IS NULL THEN 1 ELSE 0 END) AS customer_name_missing,
        SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS product_id_missing,
        SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS sales_missing,
        SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS quantity_missing,
        SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS profit_missing
	FROM sales_data;
    -- No missing values --
    
    -- Data Cleaning --
    -- standardize text data --
    
    
    -- Numerical Data --
    
UPDATE sales_data
SET sales = ROUND(sales,2),
	profit = ROUND(profit,2),
    discount = ROUND(discount,2);
    
 UPDATE sales_data
 SET Quantity = FLOOR(quantity);
 
 -- date format --
 
 UPDATE sales_data
 SET order_date = STR_TO_DATE(order_date, '%Y-%m-%d'),
    ship_date = STR_TO_DATE(ship_date, '%Y-%m-%d');
    
SELECT DISTINCT category FROM sales_data;

-- Data Transformation --

ALTER TABLE sales_data ADD COLUMN Discount_Category VARCHAR(20);

UPDATE sales_data
SET Discount_category =
CASE 
	WHEN Discount = 0 THEN 'No Discount'
    WHEN Discount BETWEEN 0.01 AND 0.10 THEN 'Low Discount'
	WHEN Discount BETWEEN 0.11 AND 0.30 THEN 'Medium Discount'
	WHEN Discount > 0.30 THEN 'High Discount'
    ELSE 'Uknown'
END;
    
ALTER TABLE sales_data ADD COLUMN order_year INT;
ALTER TABLE sales_data ADD COLUMN order_month INT;

UPDATE sales_data
SET order_year = YEAR(order_date),
	order_month = MONTH(Order_date);
 
 ALTER TABLE sales_data ADD COLUMN profit_percentage DECIMAL(10,2);
 UPDATE sales_data 
 SET profit_percentage = (Profit/Sales) * 100
 
 SELECT * FROM sales_data LIMIT 10
 
 -- total sales, profit --
 
 SELECT SUM(sales) AS total_sales,
		SUM(profit) AS total_profit
FROM sales_data
 
 -- Average Order Value per customer --
 
SELECT customer_name, customer_ID, SUM(sales)/COUNT(DISTINCT order_id) AS avg_order_value
 FROM sales_data
 GROUP BY customer_name, customer_ID;
 
 -- TOP 5 cusotmer by spending --
 SELECT customer_name, customer_ID, SUM(sales) AS total_spendings
 FROM sales_data 
 GROUP BY customer_name, customer_ID
 ORDER BY total_spendings DESC
 LIMIT 5;
 
 -- total product quantity sold by category --
 
SELECT category , SUM(quantity) AS total_quantity
FROM sales_data
GROUP BY category;

-- customer who purchased from differnt cat --

SELECT customer_id , COUNT(DISTINCT category) AS diff_cat
FROM sales_data
GROUP BY Customer_ID
HAVING COUNT(DISTINCT category) > 1;
 
 --  unique customer by region --
 SELECT region, COUNT(DISTINCT customer_id) AS cus_count
 FROM sales_data
 GROUP BY region ;
 
 -- customers who have placed multiple orders in same month --
 
 select * from sales_data;
 SELECT customer_id , order_year, order_month , COUNT(DISTINCT order_id) AS ordr_count
 FROM sales_data 
 GROUP BY customer_id, order_year, order_month
 HAVING COUNT(DISTINCT order_id)>1 ;
 
 -- orders with discount > 20% --
 SELECT * 
 FROM sales_data
 WHERE discount > 0.20;
 
 -- orders with negative balance --
 
 SELECT * FROM sales_data
 WHERE profit < 0.00;
 
 -- 10 highest revenue generating order --
 SELECT Order_ID , SUM(sales) AS revenue
 FROM sales_data
 GROUP BY order_id
 ORDER BY revenue DESC 
 LIMIT 10;
 
 -- Product Ranks based on total sales --
 WITH product_sales AS(
 SELECT product_id , SUM(sales) AS total_sales
 FROM sales_data
 GROUP BY product_id) 
 SELECT * , RANK() OVER (ORDER BY total_sales DESC) AS product_rank
 FROM product_sales ;
 
 -- cummulative sales for each region --
 SELECT * , SUM(sales) OVER(PARTITION BY region ORDER BY order_date ) AS cum_sales
 FROM sales_data;
 
 
 -- busiest month --
 SELECT order_month , COUNT(DISTINCT order_id) AS order_count 
 FROM sales_data
 GROUP BY order_month
 ORDER BY order_count DESC;
 
 SELECT order_year,order_month , COUNT(DISTINCT order_id) AS order_count 
 FROM sales_data
 GROUP BY order_year,order_month
 ORDER BY order_year, order_count DESC;
 
 -- average delivery time --
 SELECT AVG(datediff(ship_date, order_date)) AS delivery_time
 FROM sales_data;
 
 -- customers who have placed order in both 2022 & 2023 --
SELECT DISTINCT Customer_ID 
FROM sales_data
WHERE order_year = 2017
AND Customer_ID IN ( SELECT Customer_ID
	FROM sales_data 
    WHERE order_year = 2016);

SELECT distinct order_year FROM sales_data;

-- customers who have placed more 5 orders in a year --
SELECT  order_year,customer_id, COUNT(DISTINCT order_ID) AS order_count
FROM sales_data
GROUP BY customer_id, order_year
HAVING COUNT(DISTINCT order_ID) > 5
ORDER BY order_year, order_count DESC;

-- customer categorize based on spendings --
WITH cus_spendings AS (
SELECT customer_id, SUM(sales) AS total_sales 
FROM sales_data
 GROUP BY customer_ID
 ) 
 SELECT *, CASE
		WHEN total_sales < 10000 THEN 'LOW Spender'
        WHEN total_sales BETWEEN 10000 AND 15000 THEN 'MEDIUM spender'
        ELSE 'HIGH Spender'
	END AS spenders
 FROM cus_spendings
 ORDER BY spenders;
 
 -- 
 SELECT * FROM sales_data