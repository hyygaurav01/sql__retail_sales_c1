-- DROP TABLE...
DROP TABLE IF EXISTS retail_sales

-- CREATE TABLE...
CREATE TABLE retail_sales(
			transactions_id INT PRIMARY KEY,
			sale_date DATE,
			sale_time TIME,
			customer_id	INT,
			gender	VARCHAR(15),
			age	INT,
			category VARCHAR(20),	
			quantiy	INT,
			price_per_unit FLOAT,
			cogs FLOAT,
			total_sale FLOAT

		);
SELECT * FROM retail_sales


--CLEAR DATA FRONT 

SELECT * FROM retail_sales
where transactions_id IS NULL
OR
sale_date IS NULL
OR


SELECT * FROM retail_sales
order by transactions_id desc 
limit 10;

--Data Analysis & Business Key Problems & Answers..

--My Analysis  & FIndings..
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


select * from retail_sales

select * from retail_sales

--Q1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT * 
		FROM retail_sales
    WHERE sale_date ='2022-11-05';

--Q2.Write a SQL query to retrieve all transactions
--where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select *
		from retail_sales
 WHERE category = 'Clothing'
 	AND quantiy>=4
	 	AND TO_CHAR(sale_date,'YYYY-MM')='2022-11';

		 
--Q3.Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT category,
		count(*)AS total_sale
FROM retail_sales		
	GROUP	
 		BY category;
		
--Q4.Write a SQL query to find the average age of customers
--who purchased items from the 'Beauty' category.:

SELECT 
	ROUND(avg(age),2) AS total_avg
from retail_sales
	WHERE category='Beauty';

--Q5.Write a SQL query to find all transactions 
--where the total_sale is greater than 1000.:	

SELECT * 
	FROM retail_sales
 WHERE total_sale>1000;	

--Q6.Write a SQL query to find the total number of transactions
--(transaction_id) made by each gender in each category.:

SELECT category,
		gender,
	COUNT(*) AS total_transaction_id	
  FROM retail_sales
  GROUP	
  		BY category,gender;
		

--Q7.Write a SQL query to calculate the average sale for each month.
--Find out best selling month in each year:

SELECT year_date,
		month_date,
		avg_sales
		  FROM 
	  
(
SELECT 
		EXTRACT(YEAR  FROM sale_date ) as year_date,
		EXTRACT(MONTH  FROM sale_date ) as month_date,
		avg(total_sale)as avg_sales,
		RANK() OVER (PARTITION BY  EXTRACT(YEAR  FROM sale_date)
		order by avg(total_sale) DESC ) AS Ranking
 from retail_sales
	GROUP
		BY 1,2
) AS C1
WHERE Ranking=1;

		
		


--Q8.*Write a SQL query to find 
--the top 5 customers based on the highest total sales **:

SELECT customer_id,
		sum(total_sale) as total_sale
 from retail_sales
 		GROUP
		 	BY customer_id
	ORDER BY 2 desc
LIMIT 5;


--Q9.Write a SQL query to find the number of unique customers who purchased items from each category.:

SELECT category,COUNT(DISTINCT customer_id ) as unique_number
FROM  retail_sales
GROUP
	BY category;

-- Q.10 Write a SQL query to create each shift and number of orders 
--(Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


WITH timer_sale 
AS
(
SELECT *,
	   CASE 
	   		WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
			WHEN EXTRACT(HOUR FROM sale_time)BETWEEN  12 AND 17 THEN 'Afternoon' 
			ELSE 'Evening'
			END AS shift
			
  from retail_sales

  ) 

SELECT 
	shift,
	COUNT(*) as totel_order
FROM timer_sale
		GROUP
			BY shift 
			
-- project final..
	
