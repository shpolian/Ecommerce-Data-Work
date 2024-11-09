-- Cleaning Ordered Items Table
SELECT * FROM ecommerce_database.df_orderitems;

-- Handeling missing values

SELECT COUNT(*) - COUNT(order_id) AS missing_order_ids, 
       COUNT(*) - COUNT(product_id) AS missing_order_ids, 
       COUNT(*) - COUNT(seller_id) AS missing_sellers, 
       COUNT(*) - COUNT(price) AS missing_prices,
       COUNT(*) - COUNT(shipping_charges) AS missing_shiiping_charges
FROM ecommerce_database.df_orderitems;

-- Checking Duplicates

SELECT order_id, COUNT(*) 
FROM ecommerce_database.df_orderitems 
GROUP BY order_id 
HAVING COUNT(*) > 1;

-- It seems there are no duplicated

-- Looking at the data again
SELECT * FROM ecommerce_database.df_orderitems;

-- Checking for outliers/data that makes sense

SELECT AVG(price),AVG(shipping_charges),
	   MAX(price),MAX(shipping_charges)
FROM ecommerce_database.df_orderitems;

-- Insuring all id values are unique

SELECT * FROM ecommerce_database.df_orderitems;

SELECT COUNT(DISTINCT order_id) AS unique_order_ids, 
       COUNT(order_id) AS total_order_ids,
       COUNT(DISTINCT product_id) AS unique_product_ids, 
       COUNT(product_id) AS total_product_ids,
       COUNT(DISTINCT seller_id) AS unique_seller_ids, 
       COUNT(seller_id) AS total_seller_ids
FROM ecommerce_database.df_orderitems;

-- The number of unique and total order IDs is the same, which suggests that there are no duplicate order_id values in the df_orderitems table.
-- There are 16,604 unique products out of 38,279 total products, indicating that some products are repeated across different orders.
-- There are 2,476 unique sellers out of 38,279 total seller records, which shows that some sellers appear multiple times.