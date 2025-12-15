--1.•	vw_StoreSalesSummary: Revenue, #Orders, AOV per store

CREATE VIEW vw_StoreSalesSummary
AS
SELECT 
    S.store_id,
    S.store_name,
    SUM(OI.quantity * OI.list_price * (1 - OI.discount)) AS Revenue,
    COUNT(DISTINCT O.order_id) AS Total_Orders,
    CAST(
        ROUND(
            SUM(OI.quantity * OI.list_price * (1 - OI.discount)) 
            / COUNT(DISTINCT O.order_id)
        , 2) AS DECIMAL(10,2)
    ) AS AOV
FROM Sales.Order_Items AS OI 
INNER JOIN Sales.Orders AS O ON OI.order_id = O.order_id
INNER JOIN Sales.Stores S ON O.store_id = S.store_id
WHERE O.order_status = 4  
GROUP BY 
    S.store_id,
    S.store_name;

SELECT * FROM vw_StoreSalesSummary
ORDER BY store_id;