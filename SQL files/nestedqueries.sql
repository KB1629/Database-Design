DELETE FROM Favorites 
WHERE FavoriteID = (SELECT FavoriteID FROM Favorites WHERE RestaurantID = 1 AND UserID = 1 );


UPDATE Favorites 
SET RestaurantID = 4 
WHERE FavoriteID = (SELECT FavoriteID FROM Favorites WHERE UserID = 1 AND RestaurantID = 3 );


UPDATE Reviews 
SET Rating = 5, Comments = 'Excellent South Indian food!' 
WHERE ReviewID = (SELECT ReviewID FROM Reviews WHERE UserID = 2 AND RestaurantID = 3 );


