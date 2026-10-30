create database u2_db;
use u2_db;

# table departments
create table tbl_departments(dept_id int Primary key,
dept_name varchar(50) not null,
manager_name varchar(100),
location varchar(50)
);

# table employees
create table tbl_employees(
emp_id int primary key,
emp_name varchar(100) not null,
dept_id int,
salary decimal(10,2) check (salary>0),
hire_date date default (current_date),
city varchar(50),
email varchar(50),
foreign key (dept_id)
references tbl_departments(dept_id));

# table customers

create table tbl_customers(cust_id int primary key,
cust_name varchar(100) not null,
email varchar(100) unique,
phone_no varchar(15),
city varchar(50));

# table products
create table tbl_products (
pro_id int primary key,
pro_name varchar(100) not null,
category varchar(50),
unit_price decimal(10,2) check(unit_price >0),
stock_quantity int default 0);

# table orders
create table tbl_orders(order_id int primary key,
cust_id int,
order_date date not null,
ord_status varchar(20) default "Pending",
foreign key (cust_id)
references tbl_customers(cust_id));

# table order_items


create table tbl_order_items(order_id int,
pro_id int,
quantity int not null,check(quantity > 0),
discount decimal(5,2) default 0,
primary key(order_id,pro_id),
foreign key (order_id) 
references tbl_orders(order_id),
foreign key (pro_id)
references tbl_products(pro_id));


show tables;

select count(*) from tbl_employees;



# Constraint violations

insert into tbl_departments (dept_id,dept_name,manager_name,location)
values (10,"IT","Mr.X","Delhi");

insert into tbl_employees(emp_id,emp_name,dept_id,salary,hire_date,city,email)
values (111,"Test User",99,50000,'2024-01-01',"Delhi","test@company.com");

insert into tbl_products values (11,"Testpro","Test",-100,10);

# Section B
select emp_name,salary,city from tbl_employees where dept_id = 10;

select emp_name,salary,city from tbl_employees where salary between 50000 and 60000;

select emp_name,salary,city from tbl_employees where city = "Ahmedabad" and salary > 55000;

select emp_name,salary,city from tbl_employees where dept_id = 10 or dept_id = 20;

select emp_name,dept_id from tbl_employees where not dept_id = 50;

select emp_name,hire_date from tbl_employees where hire_date > '2020-01-01';

SELECT emp_name, dept_id
FROM tbl_employees
WHERE dept_id IN (10, 30, 50);

SELECT emp_name, salary
FROM tbl_employees
WHERE salary BETWEEN 45000 AND 55000;

# order by

SELECT emp_name, salary
FROM tbl_employees
ORDER BY salary ASC;

SELECT emp_name, salary
FROM tbl_employees
ORDER BY salary DESC;

SELECT emp_name, dept_id, salary
FROM tbl_employees
ORDER BY dept_id ASC, salary DESC;

# Q-5 Limit Offset

SELECT emp_name, salary
FROM tbl_employees
ORDER BY salary DESC
LIMIT 3;

SELECT emp_name, emp_id
FROM tbl_employees
ORDER BY emp_id ASC
LIMIT 5 OFFSET 5;

SELECT emp_name, salary
FROM tbl_employees
WHERE dept_id = 10
ORDER BY salary DESC
LIMIT 2;


# Q-6 Distinct

SELECT DISTINCT city
FROM tbl_employees;

SELECT DISTINCT dept_id, city
FROM tbl_employees;

SELECT DISTINCT ord_status
FROM tbl_orders
WHERE order_date > '2024-01-01';

# Q-7: Agg function
SELECT
    SUM(salary) AS TotalSalary,
    AVG(salary) AS AvgSalary
FROM tbl_employees;

SELECT
    MAX(salary) AS HighestSalary,
    MIN(salary) AS LowestSalary
FROM tbl_employees;

SELECT COUNT(*) AS TotalEmployees
FROM tbl_employees;


# Q-8 Group by having

SELECT dept_id, COUNT(*) AS EmployeeCount
FROM tbl_employees
GROUP BY dept_id
ORDER BY EmployeeCount DESC;

SELECT dept_id, ROUND(AVG(salary), 2) AS AvgSalary
FROM tbl_employees
GROUP BY dept_id;

SELECT dept_id, AVG(salary) AS AvgSalary
FROM tbl_employees
GROUP BY dept_id
HAVING AVG(salary) > 50000;


SELECT dept_id, COUNT(*) AS EmployeeCount
FROM tbl_employees
GROUP BY dept_id
HAVING COUNT(*) > 1;


# Q-9 : Query Execution flow
SELECT dept_id, AVG(salary) AS AvgSalary
FROM tbl_employees
WHERE salary > 45000
GROUP BY dept_id
HAVING AVG(salary) > 50000
ORDER BY AvgSalary DESC
LIMIT 2;


# Section D
# Q-10

SELECT emp_name
FROM tbl_employees
WHERE emp_name LIKE 'A%';

SELECT emp_name
FROM tbl_employees
WHERE emp_name LIKE '%a';

SELECT emp_name
FROM tbl_employees
WHERE emp_name LIKE '%ar%';

SELECT emp_name
FROM tbl_employees
WHERE emp_name LIKE '_____';

SELECT emp_name
FROM tbl_employees
WHERE emp_name NOT LIKE '%e%';

# Q-11

SELECT order_id, order_date
FROM tbl_orders
WHERE order_date BETWEEN '2024-02-01' AND '2024-03-31';

SELECT pro_name, category
FROM tbl_products
WHERE category IN ('Electronics', 'Furniture');


SELECT dept_id, dept_name, manager_name
FROM tbl_departments
WHERE manager_name IS NULL;

SELECT emp_name, email
FROM tbl_employees
WHERE email IS NOT NULL;


# Q-12
SELECT
    emp_name,
    salary,
    CASE
        WHEN salary > 60000 THEN 'High'
        WHEN salary BETWEEN 50000 AND 60000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM tbl_employees
ORDER BY salary DESC;


SELECT CONCAT(emp_name, ' (', city, ') - ', salary) AS EmployeeDetails
FROM tbl_employees;


SELECT
    dept_id,
    dept_name,
    COALESCE(manager_name, 'Not Assigned') AS manager_name
FROM tbl_departments;


SELECT
    emp_name,
    LENGTH(emp_name) AS NameLength
FROM tbl_employees
WHERE LENGTH(emp_name) > 10;

SELECT
    emp_name,
    SUBSTRING(emp_name, 1, 3) AS ShortName
FROM tbl_employees;

SELECT
    emp_name,
    salary,
    ROUND(salary, -3) AS RoundedSalary
FROM tbl_employees;

SELECT
    emp_name,
    FLOOR(salary / 1000) AS FloorValue,
    CEIL(salary / 1000) AS CeilValue
FROM tbl_employees;

# Section E
SELECT
    e.emp_name,
    d.dept_name,
    e.salary
FROM tbl_employees e
INNER JOIN tbl_departments d
    ON e.dept_id = d.dept_id
ORDER BY d.dept_name ASC, e.salary DESC;


SELECT
    c.cust_name AS customer_name,
    COUNT(o.order_id) AS TotalOrders
FROM tbl_customers c
LEFT JOIN tbl_orders o
    ON c.cust_id = o.cust_id
GROUP BY c.cust_id, c.cust_name
ORDER BY TotalOrders DESC;


