-- Cleaning Ordered Items Table
SELECT * FROM ecommerce_database.df_payments;

-- Handeling missing values

SELECT COUNT(*) - COUNT(order_id) AS missing_order_ids, 
       COUNT(*) - COUNT(payment_sequential) AS missing_payment, 
       COUNT(*) - COUNT(payment_type) AS missing_payment_type, 
       COUNT(*) - COUNT(payment_installments) AS missing_payment_installments,
       COUNT(*) - COUNT(payment_value) AS missing_payment_value
FROM ecommerce_database.df_payments;

-- No missing values

-- Checking Duplicates

SELECT order_id, COUNT(*) 
FROM ecommerce_database.df_payments
GROUP BY order_id 
HAVING COUNT(*) > 1;

-- No duplicates
-- Looking at the data again

SELECT * FROM ecommerce_database.df_payments;

-- Checking for outliers/invalid data

SELECT order_id, payment_value
FROM ecommerce_database.df_payments 
WHERE payment_value < 1 OR payment_value > 5000;

SELECT COUNT(*) AS outlier_count
FROM (
    SELECT order_id, payment_value
    FROM ecommerce_database.df_payments
    WHERE payment_value < 1 OR payment_value > 5000
) AS outliers;

-- There are some outliers that should be checked later in the EDA


-- Insuring all order ids values are unique

SELECT COUNT(DISTINCT order_id) AS unique_order_ids, 
       COUNT(order_id) AS total_order_ids 
FROM ecommerce_database.df_payments;

-- Indeed they are.

