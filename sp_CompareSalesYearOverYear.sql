--3.•	sp_CompareSalesYearOverYear: Compare sales between two years

CREATE PROCEDURE sp_CompareSalesYearOverYear
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        YEAR(O.order_date) AS SalesYear,
        SUM(OI.quantity * OI.list_price * (1 - OI.discount)) AS TotalRevenue,
        COUNT(DISTINCT O.order_id) AS TotalOrders
    FROM Sales.Orders O
    INNER JOIN Sales.Order_Items OI 
        ON O.order_id = OI.order_id
    WHERE 
        O.order_status = 4   
    GROUP BY 
        YEAR(O.order_date)
    ORDER BY 
        SalesYear;
END


EXECUTE sp_CompareSalesYearOverYear

