--1.•	sp_CalculateStoreKPI: Input store ID, return full KPI breakdown

CREATE PROCEDURE sp_CalculateStoreKPI
    @StoreID INT 
AS
BEGIN
    SET NOCOUNT ON; 

    
    IF NOT EXISTS (SELECT 1 FROM Sales.Stores WHERE store_id = @StoreID)
    BEGIN
        SELECT 
            @StoreID AS StoreID, 
            CAST(NULL AS DECIMAL(18, 2)) AS TotalRevenue, 
            CAST(NULL AS INT) AS TotalOrders, 
            CAST(NULL AS DECIMAL(18, 2)) AS AverageOrderValue
        WHERE 1 = 0;
        RETURN;
    END

    
    ;WITH StoreSales AS ( 
        SELECT
            O.order_id,
            SUM(OI.quantity * OI.list_price * (1 - OI.discount)) AS OrderRevenue
        FROM Sales.Orders O
        JOIN Sales.Order_Items OI
            ON O.order_id = OI.order_id
        WHERE 
            O.store_id = @StoreID    
            AND O.order_status = 4     
        GROUP BY O.order_id
    )
    
    SELECT
        @StoreID AS StoreID,
        ISNULL(SUM(SS.OrderRevenue), 0.00) AS TotalRevenue,             
        ISNULL(COUNT(SS.order_id), 0) AS TotalOrders,                  
        ISNULL(SUM(SS.OrderRevenue) / NULLIF(COUNT(SS.order_id), 0), 0.00) AS AverageOrderValue 
    FROM StoreSales SS;

END
GO

exec sp_CalculateStoreKPI 1