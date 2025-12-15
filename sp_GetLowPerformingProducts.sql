--5.sp_GetLowPerformingProducts: input minimum quantity sold (have default val) and minimum revenue (have default val)
--I added this myself
CREATE PROCEDURE sp_GetLowPerformingProducts
    @MinQtySold INT = 10,      
    @MinRevenue DECIMAL(18,2) = 100.00
AS
BEGIN
    SET NOCOUNT ON;
	--ISNULL() BECAUSE OF LEFT JOIN!
    SELECT
        P.product_id,
        P.product_name,
        ISNULL(SUM(OI.quantity),0) AS TotalQtySold,
        ISNULL(SUM(OI.quantity * OI.list_price * (1 - ISNULL(OI.discount,0))),0) AS TotalRevenue,
        ISNULL(MAX(S.quantity),0) AS CurrentStock
    FROM Production.Products P
    LEFT JOIN Sales.Order_Items OI 
        ON P.product_id = OI.product_id
    LEFT JOIN Production.Stocks S 
        ON P.product_id = S.product_id
    GROUP BY 
        P.product_id,
        P.product_name
    HAVING
        ISNULL(SUM(OI.quantity),0) < @MinQtySold
        OR ISNULL(SUM(OI.quantity * OI.list_price * (1 - ISNULL(OI.discount,0))),0) < @MinRevenue
    ORDER BY TotalQtySold ASC;
END

EXEC sp_GetLowPerformingProducts 15, 8000.50
