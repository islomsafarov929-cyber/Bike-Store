--4.•	vw_StaffPerformance: Orders and revenue handled per staff

CREATE VIEW vw_StaffPerformance
AS
SELECT 
    S.staff_id,
    CONCAT(S.first_name, ' ', S.last_name) AS FullName,
    COUNT(DISTINCT O.order_id) AS TotalOrders,
    SUM(OI.quantity * OI.list_price * (1 - OI.discount)) AS Revenue
FROM Sales.Order_Items OI
INNER JOIN Sales.Orders O
    ON OI.order_id = O.order_id
INNER JOIN Sales.Staffs S
    ON O.staff_id = S.staff_id
GROUP BY 
    S.staff_id,
    S.first_name,
    S.last_name;
	
SELECT * FROM vw_StaffPerformance;