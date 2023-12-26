CREATE VIEW UserOrders AS
SELECT Users.Username, Orders.OrderID, Orders.TotalAmount, Orders.Status
FROM Users
INNER JOIN Orders ON Users.UserID = Orders.UserID;

select * from UserORders;