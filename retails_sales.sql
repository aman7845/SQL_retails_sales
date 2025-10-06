create table retails_sales (
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(10),
age INT,
category VARCHAR(50),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT

)

SELECT * FROM retails_sales
limit 10

select * from retails_sales
where
transactions_id is NULL
OR
sale_date is NULL
OR
sale_time is NULL
OR
customer_id is NULL
OR
gender is NULL
OR
age is NULL
OR
category is NULL
OR
quantiy is NULL
OR
cogs is NULL
OR
total_sale is NULL;

DELETE FROM retails_sales
where
transactions_id is NULL
OR
sale_date is NULL
OR
sale_time is NULL
OR
customer_id is NULL
OR
gender is NULL
OR
age is NULL
OR
category is NULL
OR
quantiy is NULL
OR
cogs is NULL
OR
total_sale is NULL;

SELECT COUNT(*) FROM retails_sales

-- DATA EXPLORATION

-- How many sales we have ?

SELECT COUNT(*) AS total_sales FROM retails_sales


--How many unique customer we have ?

Select count(DISTINCT customer_id) as total_sales from retails_sales

--How many unique category we have ?

Select count(DISTINCT category)  from retails_sales

--Name of all distinct category ?

Select DISTINCT category  from retails_sales


-- Data Analysis & Bussiness Keys Promblen & answer

-- Questions

-- Q1)Write a sql query to retrieve all columns for sales made on '2022-11-05'
-- Q2)Write a sql query to retrieve all transations where the category is 'clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q3)Write a sql query to calculate the total sales (total_sale) for each category ?
-- Q4)Write a sql query to find the average age of customer who purchased item from the 'Beauty category' ?
-- Q5)Write a sql query to find all transaction where the total_sale is greater than 1000.
-- Q6)Write a sql query to find out total transaction (transation_id) made by each gender in each category ?
-- Q7)Write a sql query to calculate the average sale for each month. Find out best selling month in each year.
-- Q8)Write a sql query to find top 5 customers based on the higest total sales 
-- Q9)Write a sql query to find the number of unique customer who purchased item from each category.
-- Q10)Write a sql query to create each shift and number of order(Example Morning <=12, Afternoon Between 12 & 17, Evening > 17)


-- Let's solve question one by one.

-- Q1)Write a sql query to retrieve all columns for sales made on '2022-11-05'.

SELECT * FROM retails_sales
WHERE sale_date = '2022-11-05'

-- Q2)Write a sql query to retrieve all transations where the category is 'clothing' and the quantity sold is more than 3 in the month of Nov-2022.

SELECT * FROM retails_sales
where
category = 'Clothing'
and 
quantiy >= 3
and
TO_CHAR(sale_date,'YYYY-MM') = '2022-11'

-- Q3)Write a sql query to calculate the total sales (total_sale) for each category ?

SELECT category,sum(total_sale) as Total_sale
from retails_sales
group by category 

-- Q4)Write a sql query to find the average age of customer who purchased item from the 'Beauty category' ?
select ROUND(avg(age),2) as average_age_of_beauty_customer 
from retails_sales
where category = 'Beauty'

-- Q5)Write a sql query to find all transaction where the total_sale is greater than 1000.

select * from retails_sales
where total_sale > 1000

-- Q6)Write a sql query to find out total transaction (transation_id) made by each gender in each category ?

SELECT COUNT(*) as total_trans,gender,category from retails_sales
group by 3,2

-- Q7)Write a sql query to calculate the average sale for each month. Find out best selling month in each year.

select * from (
select 
extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as avg_sale,
rank()over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank 
from retails_sales
group by 1,2
) as t1
where rank = 1

-- Q8)Write a sql query to find top 5 customers based on the higest total sales 

select customer_id,total_sale from retails_sales
order by 2 DESC
limit 5

-- Q9)Write a sql query to find the number of unique customer who purchased item from each category.


select count(distinct customer_id),category from retails_sales
group by category

-- Q10)Write a sql query to create each shift and number of order(Example Morning <=12, Afternoon Between 12 & 17, Evening > 17)

SELECT *,
CASE 
WHEN EXTRACT (HOUR FROM sale_time) <= 12 THEN 'Morning'
WHEN EXTRACT (HOUR FROM sale_time) between 12 and 17 THEN 'Afternoon'
ELSE 'Evening'
END as Shift
From retails_sales
