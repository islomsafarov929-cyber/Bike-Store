--3.•	vw_InventoryStatus: Items running low on stock

CREATE  VIEW vw_InventoryStatus
AS
SELECT 
    P.product_id,
    P.product_name,
    P.list_price,
    S.quantity,
    CASE WHEN S.quantity <= 5 THEN 'Running Low' ELSE 'Sufficient' END AS Status
FROM Production.Stocks S
INNER JOIN Production.Products P ON S.product_id = P.product_id;


SELECT * FROM vw_InventoryStatus