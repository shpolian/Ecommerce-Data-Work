-- Cleaning he Products table
SELECT * FROM ecommerce_database.df_products;

-- Handeling missing values

SELECT COUNT(*) - COUNT(product_id) AS missing_product_ids, 
       COUNT(*) - COUNT(product_category_name) AS product_category_name, 
       COUNT(*) - COUNT(product_weight_g) AS missing_weight_type, 
       COUNT(*) - COUNT(product_length_cm) AS missing_length,
       COUNT(*) - COUNT(product_height_cm) AS missing_height,
       COUNT(*) - COUNT(product_height_cm) AS missing_height
FROM ecommerce_database.df_products;

-- No missing values

-- Checking Duplicates

SELECT product_id, COUNT(*) 
FROM ecommerce_database.df_products 
GROUP BY product_id 
HAVING COUNT(*) > 1;

-- I noticed that I have a few duplicates
-- Now I'm trying to do more digging to have a better presepective over the products

SELECT p.*
FROM ecommerce_database.df_products p
JOIN (
    SELECT product_id
    FROM ecommerce_database.df_products 
    GROUP BY product_id 
    HAVING COUNT(*) > 1
) duplicates ON p.product_id = duplicates.product_id;


SELECT *
FROM ecommerce_database.df_products 
WHERE product_id IN (
    SELECT product_id
    FROM ecommerce_database.df_products 
    GROUP BY product_id
    HAVING COUNT(*) > 1
) 
LIMIT 100;

-- Now after identifing the duplicated values and enusring I have a backup file
-- I will delete the duplicates

CREATE TABLE ecommerce_database.df_products_unique AS
SELECT *
FROM ecommerce_database.df_products p1
WHERE p1.product_id = (
    SELECT MIN(p2.product_id)
    FROM ecommerce_database.df_products p2
    WHERE p1.product_id = p2.product_id
);

-- Insuring all customer id values are unique

SELECT COUNT(DISTINCT product_id) AS unique_product_ids, 
       COUNT(product_id) AS total_product_ids 
FROM ecommerce_database.df_products;

-- Staderizing category names

SELECT * FROM ecommerce_database.df_products;

SELECT 
    CONCAT(
        UPPER(SUBSTRING(product_category_name, 1, 1)),
        LOWER(SUBSTRING(SUBSTRING_INDEX(product_category_name, '_', 1), 2)),
        ' ',
        UPPER(SUBSTRING(SUBSTRING_INDEX(product_category_name, '_', -1), 1, 1)),
        LOWER(SUBSTRING(SUBSTRING_INDEX(product_category_name, '_', -1), 2))
    ) AS formatted_category
FROM ecommerce_database.df_products;

-- Removing duplicated words

SELECT 
    CASE 
        WHEN SUBSTRING_INDEX(product_category_name, '_', 1) = SUBSTRING_INDEX(product_category_name, '_', -1)
        THEN CONCAT(
            UPPER(SUBSTRING(product_category_name, 1, 1)), 
            LOWER(SUBSTRING(product_category_name, 2))
        )
        ELSE CONCAT(
            UPPER(SUBSTRING(product_category_name, 1, 1)),
            LOWER(SUBSTRING(SUBSTRING_INDEX(product_category_name, '_', 1), 2)),
            ' ',
            UPPER(SUBSTRING(SUBSTRING_INDEX(product_category_name, '_', -1), 1, 1)),
            LOWER(SUBSTRING(SUBSTRING_INDEX(product_category_name, '_', -1), 2))
        )
    END AS formatted_category
FROM ecommerce_database.df_products;

-- Updating the table

UPDATE ecommerce_database.df_products
SET product_category_name = 
    CASE 
        WHEN SUBSTRING_INDEX(product_category_name, '_', 1) = SUBSTRING_INDEX(product_category_name, '_', -1)
        THEN CONCAT(
            UPPER(SUBSTRING(product_category_name, 1, 1)), 
            LOWER(SUBSTRING(product_category_name, 2))
        )
        ELSE CONCAT(
            UPPER(SUBSTRING(product_category_name, 1, 1)),
            LOWER(SUBSTRING(SUBSTRING_INDEX(product_category_name, '_', 1), 2)),
            ' ',
            UPPER(SUBSTRING(SUBSTRING_INDEX(product_category_name, '_', -1), 1, 1)),
            LOWER(SUBSTRING(SUBSTRING_INDEX(product_category_name, '_', -1), 2))
        )
    END;

SELECT * FROM ecommerce_database.df_products;





