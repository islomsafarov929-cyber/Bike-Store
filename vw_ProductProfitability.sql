--7.vw_ProductProfitability: revenue, cost, margin by product
--I added this myself
CREATE VIEW vw_ProductProfitability
AS
WITH ProductBase AS (
    SELECT 
        P.product_id,
        P.product_name,
        SUM(OI.quantity * OI.list_price * (1 - ISNULL(OI.discount, 0))) AS Revenue,
        SUM(OI.quantity * P.list_price) AS Cost,
        SUM(OI.quantity * OI.list_price * (1 - ISNULL(OI.discount, 0))) 
            - SUM(OI.quantity * P.list_price) AS Margin
    FROM Sales.Order_Items OI
    JOIN Production.Products P 
        ON OI.product_id = P.product_id
    GROUP BY 
        P.product_id,
        P.product_name
)
SELECT 
    product_id,
    product_name,
    Revenue,
    Cost,
    Margin,
    CASE WHEN Revenue = 0 THEN 0 
         ELSE (Margin * 100.0 / Revenue) END AS MarginPercent,
    CASE WHEN Revenue = 0 THEN 0
         WHEN (Margin * 100.0 / Revenue) >= 50 THEN 1
         ELSE 0 END AS TopProfitableFlag,
    CASE WHEN Revenue = 0 THEN 0
         WHEN (Margin * 100.0 / Revenue) < 10 THEN 1
         ELSE 0 END AS WorstProfitableFlag
FROM ProductBase;

SELECT * FROM vw_ProductProfitability