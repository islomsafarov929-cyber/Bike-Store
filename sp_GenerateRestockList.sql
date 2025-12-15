--2.•	sp_GenerateRestockList: Output low-stock items per store

CREATE PROCEDURE sp_GenerateRestockList
    @STORE_ID INT,
    @LowStockThreshold INT = 7 
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        P.product_id,
        P.product_name,
        S.quantity
    FROM Sales.Stores ST
    INNER JOIN Production.Stocks S
        ON ST.store_id = S.store_id
    INNER JOIN Production.Products P
        ON S.product_id = P.product_id
    WHERE ST.store_id = @STORE_ID
      AND S.quantity <= @LowStockThreshold
    ORDER BY S.quantity ASC, P.product_name;
END


EXEC sp_GenerateRestockList 2, 5