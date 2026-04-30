# FreshBite-Database-System-Analysis

A complete **SQL-based database project** designed to simulate a real-world food supply and order management system.  
This project covers everything from **raw material sourcing → product creation → order processing → payments → analytics**.

---

## Project Overview

**FreshBite DB** is a relational database built using MySQL that manages:

- Suppliers & raw materials
- Product catalog
- Production batches
- Customers & distributors
- Orders & order items
- Payments
- Inventory tracking

It also includes **advanced SQL queries** for business insights and analytics.

---

## Technologies Used

- MySQL
- SQL (DDL, DML, DQL)
- Window Functions
- Stored Procedures
- Triggers
- Views

---

## Database Structure

### Core Tables

| Table Name | Description |
|------------|------------|
| `suppliers` | Supplier details |
| `raw_materials` | Materials sourced from suppliers |
| `products` | Product catalog |
| `production_batches` | Manufacturing batches |
| `distributors` | Distribution partners |
| `customers` | Customer data |
| `orders` | Customer orders |
| `order_items` | Items in each order |
| `payments` | Payment transactions |
| `inventory` | Product stock |

---

## Features

### Database Operations
- Create & manage relational tables
- Foreign key relationships
- Constraints (PRIMARY KEY, CHECK, etc.)

### Data Analysis Queries
- Aggregations (SUM, AVG, COUNT)
- Joins (INNER JOIN, LEFT JOIN)
- Grouping & Filtering (GROUP BY, HAVING)
- Subqueries

### Advanced SQL
- Window Functions (RANK, LAG)
- Stored Procedure (`top_customers`)
- Triggers:
  - Auto reduce inventory
  - Payment audit logging
- View (`monthly_sales_report`)
- Function (`calc_discount`)

---

## Business Insights Covered

- Revenue by city & category
- Top customers & products
- Monthly sales growth
- Repeat customer rate
- Low inventory detection
- Customer inactivity tracking
- Product performance ranking

---

# Author
Adityamohan Singh
