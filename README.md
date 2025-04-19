# 🛒 Global Superstore Sales Analysis (SQL Project)

## 📌 Project Overview

This SQL project analyzes the popular Global Superstore dataset to uncover key business insights related to customer behavior, sales performance, product demand, and operational efficiency. The project focuses on end-to-end data handling — from cleaning and transformation to advanced analytics — using only SQL.

---

## 🗂️ Dataset Highlights

- **Dataset:** Global Superstore (sales_data table)
- **Columns used:** Order ID, Customer ID, Product ID, Category, Region, Quantity, Discount, Profit, Sales, Order Date, Ship Date, etc.
- **Records:** Thousands of transactions across multiple years

---

## 🔧 Tasks Performed

### 🔍 Data Cleaning
- Removed duplicate rows using `ROW_NUMBER()`
- Handled missing values across key fields
- Standardized numeric values (rounded sales, profit, discount)
- Converted order and ship dates into proper date formats

### 🔁 Data Transformation
- Created `Discount_Category` based on discount range
- Extracted `order_year` and `order_month` from order date
- Calculated `profit_percentage`
  
### 📊 Business Questions Answered

#### 💰 Sales & Profit
- Total sales and profit
- Average order value per customer
- Top 5 customers by total spending
- 10 highest revenue-generating orders

#### 📦 Product & Category Analysis
- Total quantity sold by category
- Product ranking based on total sales
- Customers purchasing across multiple categories

#### 🌍 Regional & Customer Insights
- Unique customer count by region
- Customers placing multiple orders in the same month
- Customers who ordered in both 2016 & 2017
- Customers placing more than 5 orders in a year
- Customer classification: Low, Medium, High Spenders

#### 📈 Advanced Metrics
- Cumulative sales by region
- Average delivery time (order vs. ship date)
- Busiest order months


## 🧠 SQL Concepts Used
- `CTE`, `ROW_NUMBER()`, `RANK()`
- `CASE` statements
- `DATEDIFF`, `YEAR()`, `MONTH()` functions
- Aggregate functions: `SUM()`, `AVG()`, `COUNT()`
- Window functions and partitioning
- Conditional filtering using `HAVING`

---

## 📁 Files Included

- `global_superstore_queries.sql` – Full SQL script with all queries
- `README.md` – Project documentation

---

## 🔗 Dataset Source

(https://www.kaggle.com/datasets/apoorvaappz/global-super-store-dataset)

---

## 🙋‍♂️ Author

**[Ashish Negi]**  
📬 [ashnegi1900@gmail.com]  
🔗 [LinkedIn](https://www.linkedin.com/in/ashish-negi-650655171/) | 

---

If this helped you or inspired your work, feel free to star the repo ⭐ and connect!
