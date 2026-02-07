-- SQL Reatil Sales Analysis - P1  
create database  sql_project_p1;
use  sql_project_p1;
-- Create Table 
drop table if exists retail_sales;
Create Table retail_sales (
    transactions_id int,
	sale_date date,
    sale_time time,
    customer_id int,
	gender varchar(15),
    age int,
	category varchar(15),
	quantiy int,
	price_per_unit int,
    cogs float,
    total_sale float
    );
select * from retail_sales limit 5;
select count(*) as total_sales from retail_sales;

SELECT transactions_id , COUNT(*) AS cnt
FROM retail_sales
GROUP BY transactions_id
HAVING cnt >1 ;

-- Data Cleaning 
select * from retail_sales
where transactions_id is null
 or
 sale_date is null 
 or
 sale_time is null 
 or
 gender is null 
 or
 category is null
 or
 quantiy is null 
 or
 price_per_unit is null 
 or
 cogs is null 
 or
 total_sale is null; 
 
 -- Data Exploration 
 -- How many sales we have?
 Select count(*) as sales_count from retail_sales;
 
 -- How many customers whe have 
  Select count(Distinct customer_id) as sales_count from retail_sales;
  
    Select Distinct customer_id as sales_count from retail_sales;
  
-- Data Analysis and Businees Key Problem & Answers 
-- Q.1  Write a SQL query to retrive all columns for sales made on '2022-11-05'
select * from retail_sales where sale_date = "2022-11-05";
  
-- Q.2 Write a SQL query to retrieve all transactions where the category is
-- 'Clothing' and the quantity sold is more than or equal to 4 in the month of Nov-2022
select transactions_id from retail_sales
where category = "Clothing" and quantiy >= 4 and date_format(sale_date,"%Y%m")= '202211';
 
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category, sum(total_sale) as total_sales from retail_sales group by category;

 -- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),2) as avg_age from retail_sales where category = "Beauty";

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales where total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category, gender, count(*) as total_trans from retail_sales  group by category, gender order by category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select year, month, avg_sale avg_sales from (
select
extract(year from sale_date) as year,
extract(month from sale_date) as month,
 avg(total_sale) as avg_sale,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rnk
from retail_sales
group by 1,2
) as t1
where rnk = 1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id, sum(total_sale) as total_sales from retail_sales group by 1  order by 2 desc limit 5;
 
 -- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select count(distinct customer_id) from retail_sales group by category;

-- Q.10 Write a SQL query to create each shift and number of orders
-- (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
select *, count(*) as count_shift from
(select case when extract(hour from sale_time) <12 then "Morning"
             when extract(hour from sale_time) between 12 and 17 then "Afternoon"
             else "Evening"
			 End as Shift 
             from retail_sales) rnk
             group by shift
-- End of Project 

 
