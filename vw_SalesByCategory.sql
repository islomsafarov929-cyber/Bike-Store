--6.•	vw_SalesByCategory: Sales volume and margin by product category

CREATE VIEW vw_SalesByCategory
AS
WITH SalesCTE AS (
    SELECT
        C.category_id,
        C.category_name,
        OI.quantity,
        OI.list_price,
        ISNULL(OI.discount, 0) AS discount,
        P.list_price as ls,
        (OI.quantity * OI.list_price * (1 - ISNULL(OI.discount, 0))) AS Revenue,
        (OI.quantity * P.list_price) AS Cost
    FROM Sales.Order_Items OI
    INNER JOIN Production.Products P 
        ON OI.product_id = P.product_id
    INNER JOIN Production.Categories C
        ON P.category_id = C.category_id
)
SELECT
    category_id,
    category_name,
    SUM(quantity) AS TotalQuantity,
    SUM(Revenue) AS TotalRevenue,
    SUM(Cost) AS TotalCost,
    SUM(Revenue) - SUM(Cost) AS SalesMargin,
	((SUM(Revenue) - SUM(Cost)) / SUM(Revenue)) * 100 AS MarginPercent
FROM SalesCTE
GROUP BY category_id, category_name;

SELECT * FROM vw_SalesByCategory
