-- INSERTION TO TABLES

--Order of Insertion:
--1.Production.Categories  (FK yo'q)

--2.Production.Brands  (FK yo'q)

--3.Sales.Customers  (FK yo'q)

--4.Sales.Stores  (FK yo'q) (Boshqa jadvallar bunga bog'lanadi)

--5.Production.Products   Brands va Categoriesga bog'liq.

--6.Sales.Staffs   * *Stores**ga bog'liq (va o'ziga).

--7.Production.Stocks    Sales.Stores va **Production.Products**ga bog'liq.

--8.Sales.Orders   Sales.Customers, Sales.Stores va **Sales.Staffs**ga bog'liq.

--9.Sales.Order_Items   Sales.Orders va **Production.Products**ga bog'liq.

--Insertion scripts

-- 1.Production.Categories
BULK INSERT Production.Categories
FROM 'C:\Users\user\OneDrive\Desktop\Projects\Project2\categories.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Production.Categories

--2.Production.Brands 
BULK INSERT Production.Brands 
FROM 'C:\Users\user\OneDrive\Desktop\Projects\Project2\brands.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Production.Brands 

--3.Sales.Customers
BULK INSERT Sales.Customers
FROM 'C:\Users\user\OneDrive\Desktop\Projects\Project2\customers.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Sales.Customers

--4.Sales.Stores
BULK INSERT Sales.Stores
FROM 'C:\Users\user\OneDrive\Desktop\Projects\Project2\stores.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Sales.Stores

--5.Production.Products
BULK INSERT Production.Products
FROM 'C:\Users\user\OneDrive\Desktop\Projects\Project2\products.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Production.Products

--6.Sales.Staffs 
BULK INSERT Sales.Staffs 
FROM 'C:\Users\user\OneDrive\Desktop\Projects\Project2\staffs.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Sales.Staffs 

--7.Production.Stocks
BULK INSERT Production.Stocks
FROM 'C:\Users\user\OneDrive\Desktop\Projects\Project2\stocks.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Production.Stocks

--8.Sales.Orders
BULK INSERT Sales.Orders
FROM 'C:\Users\user\OneDrive\Desktop\Projects\Project2\orders.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Sales.Orders

--9.Sales.Order_Items 
BULK INSERT Sales.Order_Items
FROM 'C:\Users\user\OneDrive\Desktop\Projects\Project2\order_items.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Sales.Order_Items