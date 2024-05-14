 
 -- There may be slight variations in the results.


SELECT * FROM Flipkart1

-- Q.1 Which are the top 5 product categories based on the number of listings?

SELECT TOP 5
  SUBSTRING(product_category_tree, 0, CHARINDEX('>>', product_category_tree)) AS main_category,
  COUNT(*) AS category_count
FROM Flipkart1
GROUP BY SUBSTRING(product_category_tree, 0, CHARINDEX('>>', product_category_tree))
ORDER BY category_count DESC;




-- Q.2 Which are the top 5 brands with the most product listings?

SELECT TOP 5 brand, COUNT(*) as count
FROM Flipkart1
WHERE brand IS NOT NULL
GROUP BY brand
ORDER BY COUNT DESC;





-- Q.3 What is the average discount offered by Flipkart across all products?

SELECT ROUND(AVG(discount_percentage), 2) AS Average_discount
FROM(SELECT(retail_price - discounted_price) / retail_price * 100 AS discount_percentage
FROM Flipkart) AS discounted_products;





-- Q.4 How many products have customer ratings?

SELECT COUNT(*) AS num_rated_products
FROM Flipkart1
WHERE product_rating != 'No rating available';




-- Q.5 What percentage of products are part of the Flipkart Advantage program?

SELECT AVG(CASE WHEN is_FK_Advantage_product = 'True' THEN 1 ELSE 0 END) * 100 AS percentage_advantage_products
FROM Flipkart1;

SELECT AVG(CASE WHEN is_FK_Advantage_product = 1 THEN 1 ELSE 0 END) * 100 AS percentage_advantage_products
FROM Flipkart;





-- Q.6 Which are the top 3 most expensive products listed on Flipkart?

SELECT TOP 3 product_name, retail_price
FROM Flipkart
ORDER BY retail_price DESC;





-- Q.7 Which brands have the highest average product rating?

SELECT brand, AVG(CAST(product_rating AS FLOAT)) AS average_rating
FROM Flipkart
GROUP BY brand
ORDER BY average_rating DESC;






-- Q.8 Which product category has the highest average retail price?

SELECT main_category, ROUND(AVG(retail_price),2) as Average_retail_price
FROM Flipkart
GROUP BY main_category
ORDER BY Average_retail_price DESC;




-- Q.9 Which products have the longest and shortest description?

-- Index of the longest description
WITH description_lengths AS (SELECT column1, description, LEN(description) AS description_length
  FROM Flipkart1)
SELECT column1, description, description_length
FROM description_lengths
ORDER BY description_length DESC
offset 0 rows
fetch next 5 rows only;



-- Index of the shortest description
WITH description_lengths AS (SELECT column1, description, LEN(description) AS description_length
FROM Flipkart1)
SELECT column1, description, description_length
FROM description_lengths
ORDER BY description_length 
offset 0 rows
fetch next 5 rows only;




-- Q.10 In which month was the data mostly crawled?

SELECT MONTH(crawl_timestamp) AS crawl_month, COUNT(*) AS month_count
FROM Flipkart1
GROUP BY MONTH(crawl_timestamp)
ORDER BY crawl_month;





