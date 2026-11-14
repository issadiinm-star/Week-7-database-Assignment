-- ============================================================
-- Question 1: Achieving First Normal Form (1NF)
-- ============================================================
-- Transformation: Split the multi-valued Products column so that 
-- each row contains only one atomic product value per order.

CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    PRIMARY KEY (OrderID, Product)
);

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES 
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');


-- ============================================================
-- Question 2: Achieving Second Normal Form (2NF)
-- ============================================================
-- Partial Dependency Identified: CustomerName depends only on 
-- OrderID rather than the full composite key (OrderID, Product).
-- Solution: Separate order-level details into an Orders table 
-- and product-level details into an OrderItems table.

-- 1. Create the Orders table (stores order-level attributes)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- 2. Create the OrderItems table (stores product & quantity per order)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- 3. Insert normalized records into Orders
INSERT INTO Orders (OrderID, CustomerName)
VALUES 
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- 4. Insert normalized records into OrderItems
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES 
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);
