--4.•	sp_GetCustomerProfile: Returns total spend, orders, and most bought items

CREATE PROCEDURE sp_GetCustomerProfile
AS
BEGIN
    SET NOCOUNT ON;
    
    
    WITH CustomerProducts AS (
        SELECT
            C.customer_id,
            CONCAT(C.first_name, ' ', C.last_name) AS FullName,
            P.product_name,
            SUM(OI.quantity) AS QtyBought,
            SUM(OI.quantity * OI.list_price * (1 - OI.discount)) AS Spend
        FROM Sales.Customers C
        JOIN Sales.Orders O
            ON C.customer_id = O.customer_id
        JOIN Sales.Order_Items OI
            ON O.order_id = OI.order_id
        JOIN Production.Products P
            ON OI.product_id = P.product_id
        WHERE O.order_status = 4 
        GROUP BY
            C.customer_id, CONCAT(C.first_name, ' ', C.last_name), P.product_name
    ),
    
    CustomerTotals AS (
        SELECT
            C.customer_id,
            SUM(OI.quantity * OI.list_price * (1 - OI.discount)) AS TotalSpend,   
            COUNT(DISTINCT O.order_id) AS TotalOrders,                           
            SUM(OI.quantity) AS TotalItemsBought                                 
        FROM Sales.Customers C
        JOIN Sales.Orders O
            ON C.customer_id = O.customer_id
        JOIN Sales.Order_Items OI
            ON O.order_id = OI.order_id
        WHERE O.order_status = 4
        GROUP BY C.customer_id
    ),
    
    Ranked AS (
        SELECT 
            *,
           ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY QtyBought DESC, product_name ASC) AS rn
        FROM CustomerProducts
    )
    
    SELECT 
        R.customer_id,
        R.FullName,
        CT.TotalSpend,         
        CT.TotalOrders,        
        CT.TotalItemsBought,   
        R.product_name AS MostBoughtItem, 
        R.QtyBought AS MostBoughtQty      
    FROM Ranked R
    JOIN CustomerTotals CT
        ON R.customer_id = CT.customer_id
    WHERE R.rn = 1; 
END

EXEC sp_GetCustomerProfile
