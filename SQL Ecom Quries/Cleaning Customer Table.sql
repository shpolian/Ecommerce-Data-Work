-- Cleaning customers table

SELECT * FROM ecommerce_database.df_customers;

-- Handeling missing values

SELECT COUNT(*) - COUNT(customer_id) AS missing_customer_ids, 
       COUNT(*) - COUNT(customer_zip_code_prefix) AS missing_zip_codes, 
       COUNT(*) - COUNT(customer_city) AS missing_cities, 
       COUNT(*) - COUNT(customer_state) AS missing_states
FROM ecommerce_database.df_customers;


-- Checking Duplicates

SELECT customer_id, COUNT(*) 
FROM ecommerce_database.df_customers 
GROUP BY customer_id 
HAVING COUNT(*) > 1;

-- It seems there are no duplicated

-- Looking at the data again
SELECT * FROM ecommerce_database.df_customers;

-- Validating and Standardizing data formats

UPDATE ecommerce_database.df_customers
SET customer_city = UPPER(TRIM(customer_city)),
    customer_state = UPPER(TRIM(customer_state));
    
SELECT * FROM ecommerce_database.df_customers;

-- Checking for outliers/invalid data

SELECT customer_id, customer_zip_code_prefix 
FROM ecommerce_database.df_customers 
WHERE customer_zip_code_prefix < 1000 OR customer_zip_code_prefix > 99999;

-- Zip codes seem to be valid

-- Insuring all customer id values are unique

SELECT COUNT(DISTINCT customer_id) AS unique_customer_ids, 
       COUNT(customer_id) AS total_customer_ids 
FROM ecommerce_database.df_customers;

-- All id's are indeed unique


    



