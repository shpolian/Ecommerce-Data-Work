-- Cleaning Ordered Items Table
SELECT * FROM ecommerce_database.df_orders;

-- Handeling missing values

SELECT COUNT(*) - COUNT(order_id) AS missing_order_ids, 
       COUNT(*) - COUNT(customer_id) AS missing_costumer_ids, 
       COUNT(*) - COUNT(order_purchase_timestamp) AS missing_purchase, 
       COUNT(*) - COUNT(order_approved_at) AS missing_approvved
FROM ecommerce_database.df_orders;

-- No missing values

-- Checking Duplicates

SELECT order_id, COUNT(*) 
FROM ecommerce_database.df_orders
GROUP BY order_id 
HAVING COUNT(*) > 1;

-- No duplicates

SELECT * FROM ecommerce_database.df_orders;

-- Validating and Standardizing data formats
-- Updating ecommerce_database.df_orders

SELECT DATE_FORMAT(order_purchase_timestamp, '%d/%m/%Y %H:%i:%s') AS order_purchase,
       DATE_FORMAT(order_approved_at, '%d/%m/%Y %H:%i:%s') AS order_approved
FROM ecommerce_database.df_orders;

-- Adding a new column to store the formatted date and time
ALTER TABLE ecommerce_database.df_orders ADD order_purchase VARCHAR(20),
ADD order_approved VARCHAR(20);

-- Updating the new column with the formatted date and time
UPDATE ecommerce_database.df_orders
SET order_purchase = DATE_FORMAT(order_purchase_timestamp, '%d/%m/%Y %H:%i:%s'),
    order_approved = DATE_FORMAT(order_approved_at, '%d/%m/%Y %H:%i:%s');

-- Now removing the old ones. I have a backup file just in case.

ALTER TABLE ecommerce_database.df_orders
DROP COLUMN order_purchase_timestamp,
DROP COLUMN order_approved_at;

-- Now looking at the new clean table

SELECT * FROM ecommerce_database.df_orders;

-- Insuring all customer and order ids values are unique

SELECT COUNT(DISTINCT customer_id) AS unique_customer_ids, 
       COUNT(customer_id) AS total_customer_ids,
       COUNT(DISTINCT order_id) AS unique_order_ids, 
       COUNT(order_id) AS total_order_ids
FROM ecommerce_database.df_orders;

-- Indeed they are.

-- Adding Approval time Calculation

SELECT * FROM ecommerce_database.df_orders;

SELECT 
    TIMESTAMPDIFF(MINUTE, 
        STR_TO_DATE(`order_purchase`, '%d/%m/%Y %H:%i:%s'), 
        STR_TO_DATE(`order_approved`, '%d/%m/%Y %H:%i:%s')
    ) AS approval_time
FROM 
    ecommerce_database.df_orders;

-- Updating the original table

ALTER TABLE ecommerce_database.df_orders
ADD COLUMN approval_time INT;

UPDATE ecommerce_database.df_orders
SET approval_time = TIMESTAMPDIFF(MINUTE, 
    STR_TO_DATE(`order_purchase`, '%d/%m/%Y %H:%i:%s'), 
    STR_TO_DATE(`order_approved`, '%d/%m/%Y %H:%i:%s')
);

-- Verifing the updated table

SELECT order_purchase, order_approved, approval_time
FROM ecommerce_database.df_orders
LIMIT 10;

SELECT * FROM ecommerce_database.df_orders;

-- Great Success
