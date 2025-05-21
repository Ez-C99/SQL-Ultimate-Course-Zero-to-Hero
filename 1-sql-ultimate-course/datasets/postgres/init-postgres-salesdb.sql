-- Connect to the default database (typically postgres)
\c postgres

-- Drop the SalesDB database if it exists and then create it.
DROP DATABASE IF EXISTS "SalesDB";
CREATE DATABASE "SalesDB";

-- Connect to the newly created database.
\c "SalesDB"

-- Drop the Sales schema if it exists (CASCADE drops dependent objects) and create a new one.
DROP SCHEMA IF EXISTS "Sales" CASCADE;
CREATE SCHEMA "Sales";

-- ======================================================
-- Table: Customers
-- ======================================================
CREATE TABLE "Sales".Customers (
    CustomerID INT NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50),
    Score INT,
    CONSTRAINT pk_customers PRIMARY KEY (CustomerID)
);

INSERT INTO "Sales".Customers (CustomerID, FirstName, LastName, Country, Score) VALUES
    (1, 'Jossef', 'Goldberg', 'Germany', 350),
    (2, 'Kevin', 'Brown', 'USA', 900),
    (3, 'Mary', NULL, 'USA', 750),
    (4, 'Mark', 'Schwarz', 'Germany', 500),
    (5, 'Anna', 'Adams', 'USA', NULL);

-- ======================================================
-- Table: Employees
-- ======================================================
CREATE TABLE "Sales".Employees (
    EmployeeID INT NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    BirthDate DATE,
    Gender CHAR(1),
    Salary INT,
    ManagerID INT,
    CONSTRAINT pk_employees PRIMARY KEY (EmployeeID)
);

INSERT INTO "Sales".Employees (EmployeeID, FirstName, LastName, Department, BirthDate, Gender, Salary, ManagerID) VALUES
    (1, 'Frank', 'Lee', 'Marketing', '1988-12-05', 'M', 55000, NULL),
    (2, 'Kevin', 'Brown', 'Marketing', '1972-11-25', 'M', 65000, 1),
    (3, 'Mary', NULL, 'Sales', '1986-01-05', 'F', 75000, 1),
    (4, 'Michael', 'Ray', 'Sales', '1977-02-10', 'M', 90000, 2),
    (5, 'Carol', 'Baker', 'Sales', '1982-02-11', 'F', 55000, 3);

-- ======================================================
-- Table: Products
-- ======================================================
CREATE TABLE "Sales".Products (
    ProductID INT NOT NULL,
    Product VARCHAR(50),
    Category VARCHAR(50),
    Price INT,
    CONSTRAINT pk_products PRIMARY KEY (ProductID)
);

INSERT INTO "Sales".Products (ProductID, Product, Category, Price) VALUES
    (101, 'Bottle', 'Accessories', 10),
    (102, 'Tire', 'Accessories', 15),
    (103, 'Socks', 'Clothing', 20),
    (104, 'Caps', 'Clothing', 25),
    (105, 'Gloves', 'Clothing', 30);

-- ======================================================
-- Table: Orders
-- ======================================================
CREATE TABLE "Sales".Orders (
    OrderID INT NOT NULL,
    ProductID INT,
    CustomerID INT,
    SalesPersonID INT,
    OrderDate DATE,
    ShipDate DATE,
    OrderStatus VARCHAR(50),
    ShipAddress VARCHAR(255),
	BillAddress VARCHAR(255),
    Quantity INT,
    Sales INT,
	CONSTRAINT pk_orders PRIMARY KEY (OrderID)
);

INSERT INTO "Sales".Orders (OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, ShipAddress, BillAddress, Quantity, Sales) 
VALUES
    (1,  101, 2, 3, '2025-01-01', '2025-01-05', 'Delivered','9833 Mt. Dias Blv.', '1226 Shoe St.',  1, 10),
    (2,  102, 3, 3, '2025-01-05', '2025-01-10', 'Shipped','250 Race Court',NULL, 1, 15),
    (3,  101, 1, 5, '2025-01-10', '2025-01-25', 'Delivered','8157 W. Book','8157 W. Book', 2, 20),
    (4,  105, 1, 3, '2025-01-20', '2025-01-25', 'Shipped', '5724 Victory Lane', '', 2, 60),
    (5,  104, 2, 5, '2025-02-01', '2025-02-05', 'Delivered', NULL, NULL, 1, 25),
    (6,  104, 3, 5, '2025-02-05', '2025-02-10', 'Delivered','1792 Belmont Rd.',NULL, 2, 50),
    (7,  102, 1, 1, '2025-02-15', '2025-02-27', 'Delivered','136 Balboa Court', '', 2, 30),
    (8,  101, 4, 3, '2025-02-18', '2025-02-27', 'Shipped','2947 Vine Lane','4311 Clay Rd', 3, 90),
    (9,  101, 2, 3, '2025-03-10', '2025-03-15', 'Shipped','3768 Door Way', '', 2, 20),
    (10, 102, 3, 5, '2025-03-15', '2025-03-20', 'Shipped',NULL, NULL, 0, 60);


-- ======================================================
-- Table: OrdersArchive
-- ======================================================

-- Create OrdersArchive table
CREATE TABLE "Sales".OrdersArchive (
    OrderID INT ,
    ProductID INT,
    CustomerID INT,
    SalesPersonID INT,
    OrderDate DATE,
    ShipDate DATE,
    OrderStatus VARCHAR(50),
    ShipAddress VARCHAR(255),
    BillAddress VARCHAR(255),
    Quantity INT,
    Sales INT
);

-- Insert data into OrdersArchive table
INSERT INTO "Sales".OrdersArchive VALUES
    (1, 101, 2, 3, '2024-04-01', '2024-04-05', 'Shipped', '123 Main St', '456 Billing St', 1, 10),
    (2, 102, 3, 3, '2024-04-05', '2024-04-10', 'Shipped', '456 Elm St', '789 Billing St', 1, 15),
    (3, 101, 1, 4, '2024-04-10', '2024-04-25', 'Shipped', '789 Maple St', '789 Maple St', 2, 20),
    (4, 105, 1, 3, '2024-04-20', '2024-04-25', 'Shipped', '987 Victory Lane', '', 2, 60),
    (4, 105, 1, 3, '2024-04-20', '2024-04-25', 'Delivered', '987 Victory Lane', '', 2, 60),
    (5, 104, 2, 5, '2024-05-01', '2024-05-05', 'Shipped', '345 Oak St', '678 Pine St', 1, 25),
    (6, 104, 3, 5, '2024-05-05', '2024-05-10', 'Delivered', '543 Belmont Rd.', NULL, 2, 50),
    (6, 104, 3, 5, '2024-05-05', '2024-05-10', 'Delivered', '543 Belmont Rd.', '3768 Door Way', 2, 50),
    (6, 101, 3, 5, '2024-05-05', '2024-05-10', 'Delivered', '543 Belmont Rd.', '3768 Door Way', 2, 50),
    (7, 102, 3, 5, '2024-06-15', '2024-06-20', 'Shipped', '111 Main St', '222 Billing St', 0, 60);
