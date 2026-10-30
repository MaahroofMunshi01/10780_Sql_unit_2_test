# SQL Unit Test II – Database Queries

## 📌 Project Overview
This project demonstrates SQL fundamentals and practical query-writing skills using MySQL. It creates a database named `u2_db` and uses six related tables to practice filtering, sorting, aggregation, pattern matching, functions, and joins.

## 🗄️ Database and Tables

The project contains the following six tables:

1. **tbl_departments** – Stores department ID, department name, manager name, and location.
2. **tbl_employees** – Stores employee details, department, salary, hire date, city, and email.
3. **tbl_customers** – Stores customer details and contact information.
4. **tbl_products** – Stores product names, categories, unit prices, and stock quantities.
5. **tbl_orders** – Stores customer orders, order dates, and order statuses.
6. **tbl_order_items** – Stores products included in each order, quantity, and discount.

### Constraints Used
- `PRIMARY KEY`
- `FOREIGN KEY`
- `NOT NULL`
- `UNIQUE`
- `CHECK`
- `DEFAULT`

## 📝 SQL Concepts Covered

- Database and table creation
- Filtering using `WHERE`, `AND`, `OR`, and `NOT`
- Filtering with `BETWEEN` and `IN`
- Sorting using `ORDER BY ASC` and `ORDER BY DESC`
- Pagination using `LIMIT` and `OFFSET`
- Removing duplicates using `DISTINCT`
- Aggregate functions: `SUM()`, `AVG()`, `MAX()`, `MIN()`, and `COUNT()`
- Grouping data using `GROUP BY`
- Filtering groups using `HAVING`
- Understanding SQL query execution flow
- Pattern matching using `LIKE` and `NOT LIKE`
- Date filtering and NULL checking
- Conditional statements using `CASE`
- String functions: `CONCAT()`, `COALESCE()`, `LENGTH()`, and `SUBSTRING()`
- Numeric functions: `ROUND()`, `FLOOR()`, and `CEIL()`
- Joining tables using `INNER JOIN` and `LEFT JOIN`
- Calculating customer order counts
- Calculating discounted product totals

## ⚙️ Database Setup

The project creates a database named `u2_db`.

```sql
CREATE DATABASE u2_db;
USE u2_db;
```

## 🔗 Table Relationships

- `tbl_employees.dept_id` references `tbl_departments.dept_id`.
- `tbl_orders.cust_id` references `tbl_customers.cust_id`.
- `tbl_order_items.order_id` references `tbl_orders.order_id`.
- `tbl_order_items.pro_id` references `tbl_products.pro_id`.

These relationships maintain referential integrity between related tables.

## 💻 Example Queries

### 1. Find Employees in a Department

```sql
SELECT emp_name, salary, city
FROM tbl_employees
WHERE dept_id = 10;
```

### 2. Find the Top 3 Highest-Paid Employees

```sql
SELECT emp_name, salary
FROM tbl_employees
ORDER BY salary DESC
LIMIT 3;
```

### 3. Calculate the Average Salary by Department

```sql
SELECT dept_id, ROUND(AVG(salary), 2) AS AvgSalary
FROM tbl_employees
GROUP BY dept_id;
```

### 4. Count Orders for Each Customer

```sql
SELECT
    c.cust_name AS customer_name,
    COUNT(o.order_id) AS TotalOrders
FROM tbl_customers c
LEFT JOIN tbl_orders o
    ON c.cust_id = o.cust_id
GROUP BY c.cust_id, c.cust_name
ORDER BY TotalOrders DESC;
```

### 5. Display Employees with Their Department Names

```sql
SELECT
    e.emp_name,
    d.dept_name,
    e.salary
FROM tbl_employees e
INNER JOIN tbl_departments d
    ON e.dept_id = d.dept_id
ORDER BY d.dept_name ASC, e.salary DESC;
```

## 🛠️ Tools Used

- **MySQL** – Database management and SQL query execution.
- **MySQL Workbench** – Writing and executing SQL queries.
- **GitHub** – Project storage and version control.

## 📂 Project File

- `10780_Sql_u2.sql` – Contains database creation statements, table definitions, constraints, and SQL practice queries.

## ⚠️ Notes

The SQL script includes examples intended to test database constraints. Some statements deliberately attempt invalid inserts, such as referencing a nonexistent department or inserting a negative product price. These statements may produce errors by design.

## 👨‍💻 Author

**Maahroof Munshi**
