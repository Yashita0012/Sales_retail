CREATE DATABASE sales_retail1;
--simply creating first database ----
-- dropping table first --- 
DROP TABLE IF EXISTS SALES_RETAIL;

---creating table name 
CREATE TABLE SALES_RETAIL
        (
        transaction_id  INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME, 
		customer_id INT ,
		gender VARCHAR(15),
		age INT,
		category VARCHAR(15),
		quantity INT,
		price_per_unit FLOAT ,
		cogs FLOAT ,
		total_sale FLOAT
		);

--SELECT QUERY TO VIEW THE DATA 
SELECT * FROM sales_retail
LIMIT 10;

--USING COUNT TO GET EXACT NUMBERS OF THE DATA---

SELECT COUNT(*) FROM sales_retail;

--viewing all the data again --
SELECT * FROM sales_retail 
LIMIT 100;

--SELECTING THE DATA WHERE TRANSCATION ID IS NOT ALTHOUGH IT IS PRIMARY KEY SO IT BE NULL --
SELECT * FROM sales_retail 
WHERE transaction_id IS NULL;
--NOW CHECKING FOR ALL THE COLUMNS WE GET -- 
SELECT * FROM sales_retail 
WHERE sale_date IS NULL;

SELECT * FROM sales_retail 
WHERE sale_time IS NULL;

---now selecting every null value in a single query--- 
SELECT * FROM sales_retail 
WHERE 
     transaction_id IS NULL 
      OR 
     sale_date IS NULL
      OR 
	 sale_time IS NULL 
	  OR 
	 customer_id IS NULL 
	  OR 
	 gender IS NULL 
	  OR 
	 age IS NULL 
	  OR 
	 category IS NULL 
	  OR 
	 quantity IS NULL 
	  OR 
	 price_per_unit IS NULL 
	  OR 
	 cogs IS NULL 
	  OR 
	 total_sale IS NULL ;
--deleting all null values in the table
DELETE FROM sales_retail 
WHERE 
     transaction_id IS NULL 
      OR 
     sale_date IS NULL
      OR 
	 sale_time IS NULL 
	  OR 
	 customer_id IS NULL 
	  OR 
	 gender IS NULL 
	  OR 
	 age IS NULL 
	  OR 
	 category IS NULL 
	  OR 
	 quantity IS NULL 
	  OR 
	 price_per_unit IS NULL 
	  OR 
	 cogs IS NULL 
	  OR 
	 total_sale IS NULL ;

--NOW Again checking the data if the null values are successfully deleted ----
SELECT * FROM sales_retail;
--checking all the values in the table in numerical format ---
SELECT COUNT(*) FROM sales_retail;

-- we are done with DATA CLEANING now ---
--NOW WE WILL DO DATA EXPLORATION----

--1	checking how many sales we have --- 

SELECT COUNT(*) AS  total_sales FROM sales_retail ;

--how many customer we have seeing from data---

SELECT COUNT(customer_id) AS  total_sales FROM sales_retail ;

-- we are getting large number of customer because we may have duplicate customer in the table --

SELECT COUNT(DISTINCT customer_id) AS  total_sales FROM sales_retail ;
 -- THIS WILL THE UNIQUE CUSTOMER WE HAVE IN THE TABLE---

 --NOW SELECTING DISTINCT CATEGORY FROM THE TABLE ---
 SELECT DISTINCT category FROM sales_retail;

 ----DATA ANALYSIS AND KEY BUSINEESS PROBLEM-- 
 --Q1 WRITE A SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES ON '2022-11-05'--
 --Q2 WRITE A SQL QUERY TO RETRIEVE ALL TRANSACTION WHERE THE CATEGORY IS 'CLOTHING' AND THE MONTH OF NOV 2022--
 ---Q3 WRITE A SQL QUERY TO CALCULATE THE TOTAL SALES(total_Sales) for each country --
 --Q4 WRITE A  SQL QUERY TO FIND  THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE 'BEAUTY' CATEGORY--
 --Q6 WRITE A SQL QUERY TO FIND THE TOAL NUMBER OF TRANSACTIONS(TRANSACTION_ID) MADE BY EACH GENDER IN EACH CATEGORY --
 --Q7 WRITE A SQL QUERY TO CALCULATE THE AVG SALE FOR EACH MONTH. FIND OUT BEST SELLING MONTH IN EACH YEAR --
 --Q8 WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HISGHEST TOTAL SALE --
 --Q9 WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PUCHASED ITEMS FROM EACH CATEGORY --
 --Q10 WRITE A SQL QUERY TO CREATE EACH SHITFT AND NUMBERS OF ORDERS (EXAMPLE = MORNING <=12, AFTERNOON BETWEEN 12 & 17 , EVENINF >17)



 --Q1 WRITE A SQL QUERY TO RETREIVE ALL COLUMNS FOR SALES MADE ON '2022-11-05'--
 SELECT *
 FROM sales_retail
 WHERE sale_date = '2022-11-05';
 
 --Q2 WRITE A SQL QUERY TO RETRIEVE ALL THE TRANSACTIONS WHERE THE CATEGORY clothing AND THE QUANTITY SOLD IS MORE THAN 10 IN  MONTH OF NOV 2022

 SELECT
    category ,
	SUM(quantity)
FROM sales_retail 
WHERE 
category = 'Clothing'
 GROUP BY 1;
 --THIS WILL TELL ABOUT THE QUANTITY WHICH HAS CLOTHING 
 --ALSO INCLUDE QUANTITY MORE THAN 4
 SELECT *
FROM sales_retail 
WHERE 
category = 'Clothing'
AND 
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND
quantity >= 4;
--ALSO TELL ME SALE DATE IN THE MONTH  NOV,2022---
SELECT *
FROM sales_retail 
WHERE 
category = 'Clothing'
AND 
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';

--ALSO INCLUDE QUANTITY MORE THAN 4
 SELECT *
FROM sales_retail 
WHERE 
category = 'Clothing'
AND 
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND
quantity >= 4;

--Q3 WRITE THE SQL QUERY RO CALCULATE THE TOTAL_SALES(total_sale) for each category ---
SELECT 
category ,
SUM(total_sale) AS net_sale
FROM sales_retail 
GROUP BY 1;

--NOW TOTAL ORDERS
SELECT 
   category ,
   SUM(total_sale) AS net_sale,
   COUNT(*) AS  total_orders
FROM sales_retail 
GROUP BY 1;


--Q4WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE 'BEAUTY' CATEGORY --

SELECT 
 ROUND(AVG(age),2) as avg_age
FROM sales_retail
WHERE category = 'Beauty';

--Q5 WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE THE TOTAL_SALE IS GREATER THAN 1000.
--first understanding the data better 
SELECT * FROM sales_retail;
--now selecting data where total_Sales is greater than 1000
SELECT * FROM sales_retail
WHERE total_sale > 1000;


--Q6 WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS TRANSCATION_ID MADE BY EACH GENDER IN EACH CATEGORY ----
SELECT 
     category,
	 gender ,
	 COUNT(*) as total_sales 
FROM sales_retail 
GROUP 
   BY 
   category ,
   gender 
ORDER BY 1;


--Q7 WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH. FIND OUT THE BEST SELLING MONTH IN EACH YEAR 

SELECT * FROM sales_retail ;

--now doing according to the question TOTAL SALE 
SELECT 
  EXTRACT(YEAR FROM sale_date) as year ,
  EXTRACT(MONTH FROM sale_date)as month,
  SUM(total_sale) as total_sale 
 FROM sales_retail
 GROUP BY 1,2 ; 

--now doing for average sale 

SELECT 
  EXTRACT(YEAR FROM sale_date) as year ,
  EXTRACT(MONTH FROM sale_date)as month,
  AVG(total_sale) as avg_sale 
 FROM sales_retail
 GROUP BY 1,2 
 ORDER BY 1,3 DESC;

--NOW FOR RANKING

 SELECT 
  EXTRACT(YEAR FROM sale_date) as year ,
  EXTRACT(MONTH FROM sale_date)as month,
  AVG(total_sale) as avg_sale ,
  RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)
 FROM sales_retail
 GROUP BY 1,2 ;
 --ORDER BY 1,3 DESC;
--NOW DOING FOR SPECIFIC YEAR 
SELECT*FROM
  (SELECT 
     EXTRACT(YEAR FROM sale_date) as year ,
     EXTRACT(MONTH FROM sale_date)as month,
     AVG(total_sale) as avg_sale ,
     RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)
     FROM sales_retail
     GROUP BY 1,2) 
	 as t1 
	 WHERE rank = 1;
--it which month has the highest avg sale in specific month
SELECT
    year,
	month,
    avg_sale
FROM
  (SELECT 
     EXTRACT(YEAR FROM sale_date) as year ,
     EXTRACT(MONTH FROM sale_date)as month,
     AVG(total_sale) as avg_sale ,
     RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)
     FROM sales_retail
     GROUP BY 1,2) 
	 as t1 
	 WHERE rank = 1;



--Q8 WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES 

--first selecting all the data 
SELECT * FROM sales_retail;
--now going according to the question 
SELECT 
   customer_id,
   SUM(total_sale)as TOTAL_SALE
FROM sales_retail 
GROUP BY 1 
ORDER BY 2 DESC;

--NOW WE WANT TO SELECT AND GET DATA OF ONLY TOP 5 CUSTOMER 
SELECT 
   customer_id,
   SUM(total_sale)as TOTAL_SALE
FROM sales_retail 
GROUP BY 1 
ORDER BY 2 DESC 
LIMIT 5;

--Q9 WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY --

SELECT * FROM sales_retail;

--now going according to the question 
SELECT 
  category,
  COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM sales_retail
GROUP BY 1;


--Q10 WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBERS OF ORDERS (EXAMPLE MORNING <=12, AFTERNOON BETWEEN 12 & 17 , EVENING >17)--

SELECT * FROM sales_retail;

--now doing according to the question--
SELECT *,
   CASE 
   WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
   WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
   ELSE 'Evening'
  END as shift
 FROM sales_retail;


WITH hourly_sale
AS
(
 SELECT *,
   CASE 
   WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
   WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
   ELSE 'Evening'
  END as shift
 FROM sales_retail
 )
SELECT 
    shift,
	COUNT(*) as total_orders 
FROM hourly_sale 
GROUP BY shift;


--END OF PROJECT ---- 






