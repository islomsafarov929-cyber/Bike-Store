--2.•	vw_TopSellingProducts: Rank products by total sales

CREATE VIEW vw_TopSellingProducts
AS
WITH CTE AS (
    SELECT 
        P.product_id,
        P.product_name,
        SUM(OI.quantity * OI.list_price * (1 - OI.discount)) AS TotalSales
    FROM Production.Products P
    INNER JOIN Sales.Order_Items OI 
        ON P.product_id = OI.product_id
    GROUP BY 
        P.product_id,
        P.product_name
)
SELECT 
    DENSE_RANK() OVER (ORDER BY TotalSales DESC) AS Rank,
    product_id,
    product_name,
    TotalSales
FROM CTE;

SELECT * FROM vw_TopSellingProducts