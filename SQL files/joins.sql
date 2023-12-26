SELECT Users.*, Orders.* 
FROM Users 
INNER JOIN Orders ON Users.UserID = Orders.UserID; 

SELECT Users.Username, Restaurants.Name AS RestaurantName, Orders.TotalAmount 
FROM Users 
INNER JOIN Orders ON Users.UserID = Orders.UserID 
INNER JOIN Restaurants ON Orders.RestaurantID = Restaurants.RestaurantID; 

SELECT Users.Username, Restaurants.Name AS RestaurantName, Reviews.Rating, reviews.comments
FROM Users 
LEFT JOIN Reviews ON Users.UserID = Reviews.UserID 
LEFT JOIN Restaurants ON Reviews.RestaurantID = Restaurants.RestaurantID; 

 