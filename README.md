# Ecommerce-Data-Work
The E-commerce Order Dataset provides comprehensive information related to orders, items within orders, customers, payments, and products for an e-commerce platform. This dataset is structured with multiple tables, each containing specific information about various aspects of the e-commerce operations.

Dataset Features
Orders Table:
•	order_id: Unique identifier for an order, acting as the primary key.
•	customer_id: Unique identifier for a customer. This table may not be unique at this level.
•	order_status: Indicates the status of an order (e.g., delivered, cancelled, processing, etc.).
•	order_purchase_timestamp: Timestamp when the order was made by the customer.
•	order_approved_at: Timestamp when the order was approved from the seller's side.
•	order_delivered_timestamp: Timestamp when the order was delivered at the customer's location.
•	order_estimated_delivery_date: Estimated date of delivery shared with the customer while placing the order.
Order Items Table
•	order_id: Unique identifier for an order.
•	order_item_id: Item number in each order, acting as part of the primary key along with the order_id.
•	product_id: Unique identifier for a product.
•	seller_id: Unique identifier for the seller.
•	price: Selling price of the product.
•	shipping_charges: Charges associated with the shipping of the product.
Customers Table
•	customer_id: Unique identifier for a customer, acting as the primary key.
•	customer_zip_code_prefix: Customer's Zip code.
•	customer_city: Customer's city.
•	customer_state: Customer's state.
Payments Table
•	order_id: Unique identifier for an order.
•	payment_sequential: Provides information about the sequence of payments for the given order.
•	payment_type: Type of payment (e.g., credit_card, debit_card, etc.).
•	payment_installments: Payment installment number in case of credit cards.
•	payment_value: Transaction value.
Products Table
•	product_id: Unique identifier for each product, acting as the primary key.
•	product_category_name: Name of the category the product belongs to.
•	product_weight_g: Product weight in grams.
•	product_length_cm: Product length in centimeters.
•	product_height_cm: Product height in centimeters.
•	product_width_cm: Product width in centimeters.


