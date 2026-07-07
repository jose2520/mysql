-- Create the system database
CREATE DATABASE bd_jose_diaz_estersitha;

-- Select the database to work with
USE bd_jose_diaz_estersitha;

-- Create the table that will store countries
CREATE TABLE eco_country(
    eco_id INT AUTO_INCREMENT PRIMARY KEY,
    eco_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create the table that will store cities
CREATE TABLE eco_cities (
    eco_id INT AUTO_INCREMENT PRIMARY KEY,
    eco_name VARCHAR(100) NOT NULL UNIQUE,
    eco_country_id INT NOT NULL,
    CONSTRAINT fk_eco_city_country FOREIGN KEY (eco_country_id) REFERENCES eco_country(eco_id) -- Relationship between the city and its country
);

-- Create the table that will store product categories
CREATE TABLE eco_categories (
    eco_id INT AUTO_INCREMENT PRIMARY KEY,
    eco_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create the table that will store customers
CREATE TABLE eco_customers (
    eco_id INT AUTO_INCREMENT PRIMARY KEY,
    eco_name VARCHAR(100) NOT NULL,
    eco_city_id INT NOT NULL,
    CONSTRAINT fk_eco_customer_city FOREIGN KEY (eco_city_id) REFERENCES eco_cities(eco_id) -- Relationship between the customer and its city
);

-- Create the table that will store products
CREATE TABLE eco_products (
    eco_id INT AUTO_INCREMENT PRIMARY KEY,
    eco_name VARCHAR(100) NOT NULL UNIQUE,
    eco_category_id INT NOT NULL,
    eco_price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_eco_product_category FOREIGN KEY (eco_category_id) REFERENCES eco_categories(eco_id) -- Relationship between the product and its category
);

-- Create the table that will store distribution centers
CREATE TABLE eco_distribution_centers (
    eco_id INT AUTO_INCREMENT PRIMARY KEY,
    eco_name VARCHAR(100) NOT NULL,
    eco_city_id INT NOT NULL,
    CONSTRAINT fk_eco_dc_city FOREIGN KEY (eco_city_id) REFERENCES eco_cities(eco_id) -- Relationship between the distribution center and its city
);

-- Create the table that will store product inventory per center
CREATE TABLE eco_inventories (
    eco_id INT AUTO_INCREMENT PRIMARY KEY,
    eco_dc_id INT NOT NULL,
    eco_product_id INT NOT NULL,
    eco_stock INT NOT NULL DEFAULT 0, -- Quantity available in stock, with initial value zero
    CONSTRAINT uk_eco_dc_product UNIQUE (eco_dc_id, eco_product_id), -- Avoid duplicate products per center
    CONSTRAINT fk_eco_inventory_dc FOREIGN KEY (eco_dc_id) REFERENCES eco_distribution_centers(eco_id), -- Relationship between inventory and distribution center
    CONSTRAINT fk_eco_inventory_product FOREIGN KEY (eco_product_id) REFERENCES eco_products(eco_id) -- Relationship between inventory and product
);

-- Create the table that will store purchase orders
CREATE TABLE eco_orders (
    eco_id INT AUTO_INCREMENT PRIMARY KEY,
    eco_date DATE NOT NULL, -- Date the order was placed
    eco_customer_id INT NOT NULL, -- Identifier of the customer who placed the order
    CONSTRAINT fk_eco_order_customer FOREIGN KEY (eco_customer_id) REFERENCES eco_customers(eco_id) -- Relationship between the order and the customer
);

-- Create the table that will store details of each order
CREATE TABLE eco_order_details (
    eco_id INT AUTO_INCREMENT PRIMARY KEY,
    eco_order_id INT NOT NULL,
    eco_product_id INT NOT NULL,
    eco_quantity INT NOT NULL, -- Requested quantity of the product
    eco_unit_price DECIMAL(10, 2) NOT NULL, -- Unit price of the product in that order
    CONSTRAINT fk_eco_detail_order FOREIGN KEY (eco_order_id) REFERENCES eco_orders(eco_id), -- Relationship between the detail and the order
    CONSTRAINT fk_eco_detail_product FOREIGN KEY (eco_product_id) REFERENCES eco_products(eco_id) -- Relationship between the detail and the product
);

-- Insert data from the dataset into the corresponding tables

-- Insert the base country of the dataset
INSERT INTO eco_country (eco_name) VALUES
('Colombia');

SELECT * FROM eco_country;

-- Insert the country's cities
INSERT INTO eco_cities (eco_name, eco_country_id) VALUES
('Bogotá', 1),
('Medellín', 1),
('Cali', 1),
('Barranquilla', 1),
('Cartagena', 1),
('Bucaramanga', 1),
('Pereira', 1),
('Manizales', 1),
('Cúcuta', 1);

SELECT * FROM eco_cities;

-- Insert the available product categories
INSERT INTO eco_categories (eco_name) VALUES
('Fruit'),
('Dairy'),
('Meat'),
('Grain'),
('Oil'),
('Vegetable');

SELECT * FROM eco_categories;

-- Insert customers registered in the system
INSERT INTO eco_customers (eco_name, eco_city_id) VALUES
('Super Max', 1),
('Fresh Mart', 2),
('Mini Shop', 3),
('Super Max', 4),
('Eco Store', 5),
('Market One', 6),
('Retail Co', 7),
('Food Plus', 8),
('Green Buy', 1),
('Quick Food', 9);

SELECT * FROM eco_customers;

-- Insert products from the catalog
INSERT INTO eco_products (eco_name, eco_category_id, eco_price) VALUES
('Apple Gala', 1, 2.50),
('Banana', 1, 1.20),
('Whole Milk', 2, 3.80),
('Chicken Breast', 3, 6.50),
('Chicken', 3, 6.50),
('Rice 1kg', 4, 2.00),
('Extra Virgin Olive Oil', 5, 8.90),
('Eggs x12', 2, 4.20),
('Dozen Eggs', 2, 4.20),
('Tomato', 6, 1.80),
('Iceberg Lettuce', 6, 1.10),
('Pasta', 4, 2.30),
('Spaghetti', 4, 2.30);

SELECT * FROM eco_products;

-- Insert distribution centers associated with cities
INSERT INTO eco_distribution_centers (eco_name, eco_city_id) VALUES
('Center North', 1),
('Center West', 2),
('South Hub', 3),
('Coastal DC', 4),
('East Hub', 6),
('Coffee Center', 7);

SELECT * FROM eco_distribution_centers;

-- Insert initial inventory per center and product
INSERT INTO eco_inventories ( eco_dc_id, eco_product_id, eco_stock) VALUES
(1, 1, 95),
(2, 2, 165),
(3, 3, 52),
(4, 4, 70),
(4, 5, 60),
(4, 6, 182),
(5, 7, 36),
(6, 8, 90),
(6, 9, 81),
(6, 10, 104),
(1, 11, 43),
(5, 12, 140),
(5, 13, 127);

SELECT * FROM eco_inventories;

-- Insert registered purchase orders
INSERT INTO eco_orders (eco_id, eco_date, eco_customer_id) VALUES
(1001, '2026-05-01', 1),
(1002, '2026-05-02', 1),
(1003, '2026-05-02', 2),
(1004, '2026-05-03', 2),
(1005, '2026-05-04', 3),
(1006, '2026-05-05', 3),
(1007, '2026-05-06', 4),
(1008, '2026-05-07', 4),
(1009, '2026-05-08', 5),
(1010, '2026-05-09', 5),
(1011, '2026-05-10', 6),
(1012, '2026-05-11', 6),
(1013, '2026-05-12', 7),
(1014, '2026-05-13', 7),
(1015, '2026-05-14', 8),
(1016, '2026-05-15', 8),
(1017, '2026-05-16', 9),
(1018, '2026-05-17', 9),
(1019, '2026-05-18', 10),
(1020, '2026-05-19', 10);

SELECT * FROM eco_orders;

-- Insert details of each order with products and quantities
INSERT INTO eco_order_details (eco_order_id, eco_product_id, eco_quantity, eco_unit_price) VALUES
(1001, 1, 10, 2.50),
(1002, 1, 5, 2.50),
(1003, 2, 20, 1.20),
(1004, 2, 15, 1.20),
(1005, 3, 12, 3.80),
(1006, 3, 8, 3.80),
(1007, 4, 25, 6.50),
(1008, 5, 10, 6.50),
(1009, 6, 30, 2.00),
(1010, 6, 18, 2.00),
(1011, 7, 6, 8.90),
(1012, 7, 4, 8.90),
(1013, 8, 14, 4.20),
(1014, 9, 9, 4.20),
(1015, 10, 22, 1.80),
(1016, 10, 16, 1.80),
(1017, 11, 11, 1.10),
(1018, 11, 7, 1.10),
(1019, 12, 19, 2.30),
(1020, 13, 13, 2.30);

SELECT * FROM eco_order_details;


-- Data Manipulation Language (DML) scripts

-- Insert a customer.
INSERT INTO eco_customers (eco_name, eco_city_id)
VALUES ('Melanis Diaz', 4);

INSERT INTO eco_orders (eco_date, eco_customer_id)
VALUES (CURDATE(), LAST_INSERT_ID());

-- Update action
-- Modify the name of an existing distribution center to demonstrate data update.
UPDATE eco_distribution_centers
SET eco_name = 'Center North'
WHERE eco_id = 1;

-- ### Delete action
-- Delete a product only if it has no associated orders, avoiding invalid operations due to integrity constraints.
DELETE FROM eco_products
WHERE eco_id = 12
  AND NOT EXISTS (
      SELECT 1
      FROM eco_order_details od
      WHERE od.eco_product_id = eco_products.eco_id
  );
  
  
-- Business SQL queries

-- Query 1: Available inventory by product

-- Business requirement: As a supply manager, I need to know current stocks to plan new purchases.
SELECT p.eco_name AS product_name, SUM(i.eco_stock) AS total_available_stock
FROM eco_inventories i
INNER JOIN eco_products p ON i.eco_product_id = p.eco_id
GROUP BY p.eco_id, p.eco_name
ORDER BY total_available_stock DESC;

-- Query 2: Order history by city

-- Business requirement: As a sales director, I need to know which cities generate the most order volume.
SELECT c.eco_name AS city_name, COUNT(o.eco_id) AS total_orders_placed
FROM eco_orders o
INNER JOIN eco_customers cu ON o.eco_customer_id = cu.eco_id
INNER JOIN eco_cities c ON cu.eco_city_id = c.eco_id
GROUP BY c.eco_id, c.eco_name
ORDER BY total_orders_placed DESC;

-- Query 3: Total sales by category

-- Business requirement: As a financial manager, I need to identify which categories generate higher revenues.
SELECT cat.eco_name AS category_name,
       SUM(od.eco_quantity * od.eco_unit_price) AS total_revenue
FROM eco_order_details od
INNER JOIN eco_products p ON od.eco_product_id = p.eco_id
INNER JOIN eco_categories cat ON p.eco_category_id = cat.eco_id
GROUP BY cat.eco_id, cat.eco_name
ORDER BY total_revenue DESC;

-- Query 4: Products with lower inventory

-- Business requirement: As a logistics coordinator, I need to know products close to running out.
SELECT p.eco_name AS product_name, SUM(i.eco_stock) AS current_stock
FROM eco_inventories i
INNER JOIN eco_products p ON i.eco_product_id = p.eco_id
GROUP BY p.eco_id, p.eco_name
ORDER BY current_stock ASC
LIMIT 5;

-- Query 5: Customers with the most orders

-- Business requirement: As a sales director, I need to identify the most active customers.
SELECT cu.eco_name AS customer_name,
       COUNT(o.eco_id) AS number_of_orders
FROM eco_orders o
INNER JOIN eco_customers cu ON o.eco_customer_id = cu.eco_id
GROUP BY cu.eco_id, cu.eco_name
ORDER BY number_of_orders DESC
LIMIT 5;

-- Query 6: Economic value of inventory by distribution center

-- Business requirement: As a general manager, I need to know the value of inventory stored in each logistics center.
SELECT dc.eco_name AS distribution_center,
       SUM(i.eco_stock * p.eco_price) AS total_inventory_value
FROM eco_inventories i
INNER JOIN eco_distribution_centers dc ON i.eco_dc_id = dc.eco_id
INNER JOIN eco_products p ON i.eco_product_id = p.eco_id
GROUP BY dc.eco_id, dc.eco_name
ORDER BY total_inventory_value DESC;



-- Advanced database objects

-- Commercial views (Two SQL views oriented to commercial analysis.)

-- 1
CREATE OR REPLACE VIEW eco_vw_commercial_product_performance AS
SELECT p.eco_name AS product,
       cat.eco_name AS category,
       SUM(od.eco_quantity) AS total_units_sold,
       SUM(od.eco_quantity * od.eco_unit_price) AS total_sales_amount
FROM eco_order_details od
INNER JOIN eco_products p ON od.eco_product_id = p.eco_id
INNER JOIN eco_categories cat ON p.eco_category_id = cat.eco_id
GROUP BY p.eco_id, p.eco_name, cat.eco_name;

-- 2
CREATE OR REPLACE VIEW eco_vw_customer_geo_segments AS
SELECT c.eco_name AS city,
       COUNT(DISTINCT cu.eco_id) AS total_unique_customers,
       COUNT(o.eco_id) AS total_orders_generated
FROM eco_cities c
LEFT JOIN eco_customers cu ON c.eco_id = cu.eco_city_id
LEFT JOIN eco_orders o ON cu.eco_id = o.eco_customer_id
GROUP BY c.eco_id, c.eco_name;

SELECT * FROM eco_vw_commercial_product_performance;

SELECT * FROM eco_vw_customer_geo_segments;




