# Bike-store-sql-project
This project performs a comprehensive analysis of a fictional bikestore's sales data using SQL. By setting up a relational database from a set of CSV files, this analysis explores the dataset to answer key business questions related to sales, customers, products, and staff performance. It serves as a practical demonstration of data import, database management, and analytical querying in a real-world business context.

-- Project Workflow & Objectives
The primary objective was to successfully set up a relational database, import a multi-table dataset, and then use SQL to query the data and extract meaningful insights.

-- How It Was Done: Database Schema Creation: A new database was created in MySQL. The table structures for the 9 CSV files were defined with appropriate data types, primary keys, and foreign keys to establish relationships.

Data Import & Troubleshooting: The data was imported using the MySQL Workbench "Table Data Import Wizard".

-- Tools & Technology

Database: MySQL

Language: SQL

IDE/Client: MySQL Workbench

-- Dataset

The dataset is comprised of 9 CSV files, representing a relational database schema for a bikestore network.

brands.csv: Contains information about product brands.

categories.csv: Contains product categories.

customers.csv: Customer information, including name and location.

order_items.csv: Details of each item within an order.

orders.csv: High-level order information, including customer, store, and dates.

products.csv: Product details, including name, brand, category, and price.

staffs.csv: Employee information, including their store and manager.

stocks.csv: Information on product stock levels at each store.

stores.csv: Store information, including name and location.

-- Data Analysis & Questions Answered The core of the project was to answer specific business questions by writing SQL queries. The analysis ranged from basic data retrieval to more complex aggregations and joins.

Customer & Order Analysis

Can you retrieve the first name, last name, and email of all customers from New York?

Could you list all orders that were shipped on or after January 15th, 2016?

Which customers have placed more than 5 orders?

Product & Brand Analysis

What are the names of all products that have a list price over $1000, ordered from most expensive to least expensive?

What are the names of all bicycle brands available in the stores?

How many products are there in each product category?

Can you find the total revenue for each brand, considering the quantity, list price, and discount?

What is the name of the most expensive product?

Could you list the products that have never been ordered?

What is the total number of bikes sold for each brand?

Store & Staff Performance

Which staff members are currently active, and at which store do they work?

Which store has the highest number of staff members?

List the staff members who manage at least one other staff member?

Inventory & Financials

List all products that are out of stock in the 'Santa Cruz Bikes' store?

Find the average discount given on all orders?

-- Dataset was downloaded from kaggle.

-- Thank you

