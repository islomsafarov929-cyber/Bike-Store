--5.•	vw_RegionalTrends: Revenue by city or region

CREATE VIEW vw_RegionalTrends
AS
SELECT 
	S.city,
	S.state,
	SUM(OI.quantity * OI.list_price * (1 - OI.discount)) Revenue
FROM Sales.Order_Items OI 
INNER JOIN Sales.Orders O ON OI.order_id = O.order_id
INNER JOIN Sales.Stores S ON O.store_id = S.store_id
GROUP BY 
	S.city,
	S.state;

SELECT * FROM vw_RegionalTrends;