-- BIKE STORE ANALYSIS PROJECT

-- CREATE DATABASE BIKE STORE
CREATE DATABASE Bike_store;
USE Bike_store;

-- CREATE TABLES
CREATE TABLE Brands(
 brand_id INT PRIMARY KEY,
 brand_name VARCHAR(30) NOT NULL
);

CREATE TABLE Stores(
 store_id INT PRIMARY KEY,
 store_name VARCHAR(50) NOT NULL,
 phone VARCHAR(20),
 email VARCHAR (50),
 street VARCHAR(50),
 city VARCHAR(50),
 state VARCHAR(50),
 zip_code VARCHAR(10)
);

CREATE TABLE Customers(
 customer_id INT PRIMARY KEY,
 first_name VARCHAR(30) NOT NULL,
 last_name VARCHAR(30) NOT NULL,
 phone VARCHAR(30),
 email VARCHAR(50) NOT NULL,
 street VARCHAR(50),
 city VARCHAR(50),
 state VARCHAR(20),
 zip_code VARCHAR(10)
);

CREATE TABLE Categories(
 category_id INT PRIMARY KEY,
 category_name VARCHAR(30) NOT NULL
);

CREATE TABLE Products(
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  brand_id INT NOT NULL,
  category_id INT NOT NULL,
  model_year INT NOT NULL,
  list_price DECIMAL(10, 2),
  FOREIGN KEY (brand_id) REFERENCES Brands(brand_id)
  ON DELETE CASCADE 
  ON UPDATE CASCADE,
  FOREIGN KEY (category_id) REFERENCES Categories(category_id)
  ON DELETE CASCADE 
  ON UPDATE CASCADE
);

CREATE TABLE Staffs(
 staff_id INT PRIMARY KEY,
 first_name VARCHAR(30) NOT NULL,
 last_name VARCHAR(30) NOT NULL,
 email VARCHAR(50) NOT NULL,
 phone VARCHAR(30),
 active INT,
 store_id INT NOT NULL,
 manager_id INT NOT NULL,
 FOREIGN KEY (manager_id) REFERENCES Staffs(staff_id),
 FOREIGN KEY (store_id) REFERENCES Stores(store_id)
  ON DELETE CASCADE 
  ON UPDATE CASCADE
);
ALTER TABLE Staffs MODIFY manager_id INT;

CREATE TABLE Stocks(
 store_id INT NOT NULL,
 product_id INT NOT NULL,
 quantity INT,
 PRIMARY KEY (store_id, product_id),
 FOREIGN KEY (store_id) REFERENCES Stores(store_id)
  ON DELETE CASCADE 
  ON UPDATE CASCADE,
 FOREIGN KEY (product_id) REFERENCES Products(product_id)
  ON DELETE CASCADE 
  ON UPDATE CASCADE
);

CREATE TABLE Orders(
 order_id INT PRIMARY KEY,
 customer_id INT NOT NULL,
 order_status INT NOT NULL,
 order_date DATE NOT NULL,
 required_date DATE NOT NULL, 
 shipped_date DATE, 
 store_id INT NOT NULL,
 staff_id INT NOT NULL,
 FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
  ON DELETE CASCADE 
  ON UPDATE CASCADE,
 FOREIGN KEY (store_id) REFERENCES Stores(store_id)
  ON DELETE CASCADE 
  ON UPDATE CASCADE, 
FOREIGN KEY (staff_id) REFERENCES Staffs(staff_id)
  ON DELETE CASCADE 
  ON UPDATE CASCADE
);

CREATE TABLE Order_items(
 order_id INT NOT NULL,
 item_id INT NOT NULL,
 product_id INT NOT NULL,
 quantity INT,
 list_price DECIMAL(10, 2),
 discount DECIMAL(10, 2),
 PRIMARY KEY (order_id, item_id),
 FOREIGN KEY (order_id) REFERENCES Orders(order_id)
  ON DELETE CASCADE 
  ON UPDATE CASCADE,
 FOREIGN KEY (product_id) REFERENCES Products(product_id)
  ON DELETE CASCADE 
  ON UPDATE CASCADE
);

SHOW TABLES;

-- IMPORT DATA USING 'TABLE DATA IMPORT WIZARD'


-- QUERIES & SOLUTION 

-- 1. Can you retrieve the first name, last name, and email of all customers from New York?
SELECT first_name, last_name, email
FROM Customers
WHERE State = 'NY';

-- 2. What are the names of all products that have a list price over $1000, ordered from most expensive to least expensive?
SELECT product_name, list_price
FROM Products
WHERE List_price > 1000
ORDER BY list_price DESC;

-- 3. Could you list all orders that were shipped on or after January 15th, 2016?
SELECT * 
FROM Orders
WHERE shipped_date >= '2016-01-15';

-- 4. Which staff members are currently active, and at which store do they work? 
SELECT St.first_name, last_name, S.store_name
FROM Staffs St
INNER JOIN Stores S
on St.store_id = S.store_id
WHERE St.active = 1;

-- 5. What are the names of all bicycle brands available in the stores?
SELECT brand_name
FROM Brands;

-- 6. How many products are there in each product category?
SELECT c.category_name, COUNT(p.product_id) AS product_count
FROM Categories c
Join Products p
ON c.category_id = p.category_id
GROUP BY c.category_name;

-- 7. Which store has the highest number of staff members?
SELECT st.store_name, COUNT(s.staff_id) AS No_staff
FROM Stores st
JOIN staffs s
ON st.store_id = s.store_id
GROUP BY st.store_name
ORDER BY No_staff DESC
LIMIT 1;

-- 8. Can you find the total revenue for each brand, considering the quantity, list price, and discount?
SELECT b.brand_name, SUM(o.quantity * o.list_price * (1 - o.discount)) AS total_revenue
FROM Brands b
JOIN Products p
on b.brand_id = p.brand_id
JOIN order_items o
on o.product_id = p.product_id
GROUP BY b.brand_name;

-- 9. Which customers have placed more than 5 orders?
SELECT c.first_name, c.last_name, COUNT(o.order_id) AS Total_order
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) > 5;

-- 10. What is the name of the most expensive product? 
SELECT product_name
FROM Products
WHERE list_price = (SELECT MAX(list_price) FROM products);

-- 11. Could you list the products that have never been ordered?
SELECT product_name
FROM Products p
JOIN Order_items oi
ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;

-- 12. List all products that are out of stock in the 'Santa Cruz Bikes' store?
SELECT p.product_name
FROM Products p
JOIN Stocks s
ON p.product_id = s.product_id
JOIN Stores st
on st.store_id = s.store_id
WHERE st.store_name = 'Santa Cruz Bikes' AND s.quantity = 0;

-- 13. Find the average discount given on all orders?
SELECT AVG(discount) AS avg_discount
FROM Order_items;

-- 14. List the staff members who manage at least one other staff member?
SELECT DISTINCT m.first_name, m.last_name
FROM staffs e
JOIN staffs m
on e.staff_id = m.manager_id;

-- 15. Find the total number of bikes sold for each brand?
SELECT b.brand_name, SUM(oi.quantity) AS total_sales
FROM Brands b
JOIN Products p
ON b.brand_id = p.brand_id
JOIN Order_items oi
on oi.product_id = p.product_id
GROUP BY b.brand_name;

-- END OF THE PROJECT

