-- Question 1: Achieving 1NF

-- Create a temporary table to simulate the original ProductDetail table.
CREATE TEMPORARY TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(255),
    Products VARCHAR(255)
);

-- Insert the given data into the temporary table.
INSERT INTO ProductDetail (OrderID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Transform the table into 1NF.
CREATE TEMPORARY TABLE ProductDetail1NF AS
SELECT
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
FROM
    ProductDetail
CROSS JOIN
    (SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) n -- Adjust the number of unions if you expect more than 5 products
WHERE
    SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1) <> '';

-- Display the result.
SELECT * FROM ProductDetail1NF;

-- Question 2: Achieving 2NF

-- Create a temporary table to simulate the original OrderDetails table.
CREATE TEMPORARY TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255),
    Quantity INT
);

-- Insert the given data into the temporary table.
INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'Alan wangwe', 'Laptop', 2),
(101, 'Alan wangwe', 'Mouse', 1),
(102, 'sarah thurea', 'Tablet', 3),
(102, 'sarah thurea', 'Keyboard', 1),
(102, 'sarah thurea', 'Mouse', 2),
(103, 'Emily Achieng', 'Phone', 1);

-- Create a separate table for orders with OrderID and CustomerName.
CREATE TEMPORARY TABLE Orders2NF AS
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create a separate table for order items with OrderID, Product, and Quantity.
CREATE TEMPORARY TABLE OrderItems2NF AS
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Display the results.
SELECT * FROM Orders2NF;
SELECT * FROM OrderItems2NF;
-- Question 1: Achieving 1NF

-- Assuming a temporary table ProductDetail with the given data exists.

CREATE TEMPORARY TABLE ProductDetail1NF AS
SELECT
    OrderID,
    CustomerName,
    SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1) AS Product
FROM
    ProductDetail
CROSS JOIN
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3) AS numbers
WHERE
    LENGTH(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1)) > 0;

-- Display the result of 1NF transformation
SELECT * FROM ProductDetail1NF;


-- Question 2: Achieving 2NF

-- Assuming a temporary table OrderDetails with the given data exists.

-- Create a separate table for Orders (OrderID, CustomerName)
CREATE TEMPORARY TABLE Orders2NF AS
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create a separate table for OrderItems (OrderID, Product, Quantity)
CREATE TEMPORARY TABLE OrderItems2NF AS
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Display the results of 2NF transformation
SELECT * FROM Orders2NF;
SELECT * FROM OrderItems2NF;
