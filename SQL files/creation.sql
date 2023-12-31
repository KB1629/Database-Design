CREATE TABLE Users ( 
    UserID INT PRIMARY KEY, 
    Username VARCHAR(50) NOT NULL, 
    Email VARCHAR(100) UNIQUE NOT NULL, 
    Password VARCHAR(100) NOT NULL
);  
INSERT INTO Users VALUES(1, 'aakash','aakash@example.com', 'password123');
INSERT INTO Users VALUES(2, 'uthay', 'uthay@example.com', 'securepass');
INSERT INTO Users VALUES(3, 'arjun', 'arjun@example.com', 'mysecret');
INSERT INTO Users VALUES(4, 'sarvesh', 'sarvesh@example.com', '123456'); 
INSERT INTO Users VALUES(5, 'ariva', 'ariva@example.com', 'p@ssw0rd');
INSERT INTO Users VALUES(6, 'aathira', 'aathira@example.com', 'psw0rd');
select*from users;

CREATE TABLE Restaurants ( 
    RestaurantID INT PRIMARY KEY, 
    Name VARCHAR(100) NOT NULL, 
    Location VARCHAR(200), 
    Cuisine VARCHAR(50), 
    Rating DECIMAL(3, 2), 
    OpeningTime varchar(20), 
    ClosingTime varchar(20)
);
insert into REstaurants values(1, 'Chettinad Spice', '123 Gandhi Rd', 'South Indian', 4.5, '09:00:00', '21:30:00'); 
insert into REstaurants values(2, 'Udupi Delights', '456 Temple St', 'South Indian', 4.2, '08:30:00', '22:00:00');
insert into REstaurants values(3, 'Andhra Flavors', '789 Nagar St', 'Andhra Cuisine', 4.7, '10:00:00', '22:30:00'); 
insert into REstaurants values(4, 'Malabar Treats', '567 Coast Rd', 'Kerala Cuisine', 4.0, '11:00:00', '23:00:00'); 
insert into REstaurants values(5, 'Tamil Nadu Bites', '234 netaji St', 'South Indian', 4.8, '10:30:00', '21:30:00'); 
SELECT * FROM users;

CREATE TABLE MenuItems ( 
    ItemID INT PRIMARY KEY, 
    RestaurantID INT, 
    Name VARCHAR(100) NOT NULL, 
    Price DECIMAL(8, 2) NOT NULL, 
    Description varchar(50), 
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID) 
); 
INSERT INTO MenuItems VALUES (1, 1, 'Chettinad Chicken Curry', 449.99, 'Spicy and flavorful chicken curry'); 
INSERT INTO MenuItems VALUES(2, 1, 'Masala Dosa', 220.49, 'Crispy rice crepe with potato filling'); 
INSERT INTO MenuItems VALUES(3, 2, 'Set Dosa', 180.99, 'Soft and spongy mini dosas');
INSERT INTO MenuItems VALUES(4, 2, 'Bisi Bele Bath', 298.99, 'Hot lentil rice with veggies'); 
INSERT INTO MenuItems VALUES(5, 3, 'Gongura Chicken', 314.99, 'Tangy Andhra chicken dish'); 
INSERT INTO MenuItems VALUES(6, 3, 'Pulihora', 125.49, 'Sour tamarind rice with peanuts');
 
CREATE TABLE DeliveryDrivers ( 
    DriverID INT PRIMARY KEY, 
    Name VARCHAR(100) NOT NULL, 
    Phone VARCHAR(15) UNIQUE NOT NULL, 
    VehicleType VARCHAR(50)
);
INSERT INTO DeliveryDrivers VALUES    (1, 'ashwin', '9659865988 ', 'Bike'); 
INSERT INTO DeliveryDrivers VALUES    (2, 'Deepak', '5587456898 ', 'Scooter'); 
INSERT INTO DeliveryDrivers VALUES    (3, 'Naveen', '9864752165 ', 'Car'); 
INSERT INTO DeliveryDrivers VALUES    (4, 'Srinivasan', '9874563210 ', 'Bike'); 
INSERT INTO DeliveryDrivers VALUES    (5, 'Raju', '9564873210 ', 'Scooter'); 

CREATE TABLE Addresses ( 
    AddressID INT PRIMARY KEY,
    UserID INT, 
    Street VARCHAR(150), 
    City VARCHAR(100), 
    State VARCHAR(50), 
    PostalCode VARCHAR(20), 
    FOREIGN KEY (UserID) REFERENCES Users(UserID) 
); 
INSERT INTO Addresses VALUES(1, 1, '123 Kaveri St', 'Chennai', 'TN', '600001');
INSERT INTO Addresses VALUES(2, 2, '456 Nilgiri Rd', 'Bangalore', 'KA', '560001'); 
INSERT INTO Addresses VALUES(3, 3, '789 Godavari St', 'Vijayawada', 'AP', '520001'); 
INSERT INTO Addresses VALUES(4, 4, '567 Malabar Rd', 'Kozhikode', 'KL', '673001'); 
INSERT INTO Addresses VALUES(5, 5, '234 Thamizh St', 'Madurai', 'TN', '625001'); 

CREATE TABLE PaymentMethods ( 
    PaymentMethodID INT PRIMARY KEY, 
    UserID INT, 
    CardNumber VARCHAR(20) UNIQUE NOT NULL, 
    CVV VARCHAR(4), 
    FOREIGN KEY (UserID) REFERENCES Users(UserID) 
);


INSERT INTO PaymentMethods VALUES(1, 1, '** ** ** 1234', '123');
INSERT INTO PaymentMethods VALUES(2, 2, '** ** ** 5678', '456'); 
INSERT INTO PaymentMethods VALUES(3, 3, '** ** ** 9012', '789'); 
INSERT INTO PaymentMethods VALUES(4, 4, '** ** ** 3456', '234'); 
INSERT INTO PaymentMethods VALUES(5, 5, '** ** ** 7890', '567'); 

CREATE TABLE Orders ( 
    OrderID INT PRIMARY KEY, 
    UserID INT, 
    RestaurantID INT, 
    TotalAmount DECIMAL(10, 2), 
    Status VARCHAR(50), 
    FOREIGN KEY (UserID) REFERENCES Users(UserID), 
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID) 
);
INSERT INTO Orders VALUES(1, 1, 1, 669.47, 'Delivered');
INSERT INTO Orders VALUES(2, 2, 3, 998.97, 'In Progress'); 
INSERT INTO Orders VALUES(3, 3, 2, 499.48, 'Cancelled'); 
INSERT INTO Orders VALUES(4, 4, 4, 684.95, 'Delivered'); 
INSERT INTO Orders VALUES(5, 5, 5, 499.44, 'Delivered'); 

CREATE TABLE OrderItems ( 
    OrderItemID INT PRIMARY KEY, 
    OrderID INT, 
    ItemID INT, 
    Quantity INT, 
    Subtotal DECIMAL(10, 2), 
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID), 
    FOREIGN KEY (ItemID) REFERENCES MenuItems(ItemID) 
);
INSERT INTO OrderItems VALUES(1, 1, 2, 2, 440.98); 
INSERT INTO OrderItems VALUES(2, 1, 4, 1, 298.99); 
INSERT INTO OrderItems VALUES(3, 2, 6, 3, 376.47); 
INSERT INTO OrderItems VALUES(4, 3, 1, 1, 449.99); 
INSERT INTO OrderItems VALUES(5, 4, 3, 2, 361.98);
INSERT INTO OrderItems VALUES(6, 5, 5, 4, 1259.76); 

CREATE TABLE Payments ( 
    PaymentID INT PRIMARY KEY, 
    OrderID INT, 
    PaymentMethodID INT, 
    Amount DECIMAL(10, 2), 
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID), 
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods(PaymentMethodID) 
);
INSERT INTO Payments VALUES(1, 1, 1, 1461.00); 
INSERT INTO Payments VALUES(2, 2, 2, 2173.50);
INSERT INTO Payments VALUES(3, 3, 3, 900.00);
INSERT INTO Payments VALUES(4, 4, 4, 1948.50); 
INSERT INTO Payments VALUES(5, 5, 5, 1047.00); 



CREATE TABLE Delivery ( 
    DeliveryID INT PRIMARY KEY, 
    OrderID INT, 
    DriverID INT, 
    DeliveryDate TIMESTAMP, 
    Status VARCHAR(50), 
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID), 
    FOREIGN KEY (DriverID) REFERENCES DeliveryDrivers(DriverID) 
); 
INSERT INTO Delivery VALUES   (1, 1, 1, to_timestamp('2023-08-03 13:45:00','yyyy-mm-dd hh24:mi:ss'), 'Delivered'); 
INSERT INTO Delivery VALUES   (2, 2, 2, to_timestamp('2023-08-05 14:30:00','yyyy-mm-dd hh24:mi:ss'), 'In Progress'); 
INSERT INTO Delivery VALUES   (3, 3, 1, to_timestamp('2023-08-07 16:20:00','yyyy-mm-dd hh24:mi:ss'), 'Cancelled'); 
INSERT INTO Delivery VALUES   (4, 4, 3, to_timestamp('2023-08-08 11:10:00','yyyy-mm-dd hh24:mi:ss'), 'Delivered'); 
INSERT INTO Delivery VALUES   (5, 5, 4, to_timestamp('2023-08-10 18:00:00','yyyy-mm-dd hh24:mi:ss'), 'Delivered'); 

CREATE TABLE Favorites ( 
    FavoriteID INT PRIMARY KEY, 
    UserID INT, 
    RestaurantID INT, 
    FOREIGN KEY (UserID) REFERENCES Users(UserID), 
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
); 

INSERT INTO Favorites VALUES(1, 1, 1 ); 
INSERT INTO Favorites VALUES(2, 1, 3 ); 
INSERT INTO Favorites VALUES(3, 2, 5 ); 
INSERT INTO Favorites VALUES(4, 3, 2 ); 
INSERT INTO Favorites VALUES(5, 4, 4 ); 

CREATE TABLE Reviews ( 
    ReviewID INT PRIMARY KEY, 
    UserID INT, 
    RestaurantID INT, 
    Rating int, 
    Comments VARCHAR(50), 
    FOREIGN KEY (UserID) REFERENCES Users(UserID), 
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID) 
); 

INSERT INTO Reviews VALUES   (1, 1, 1, 4, 'Delicious South Indian food!'); 
INSERT INTO Reviews VALUES   (2, 2, 3, 4, 'Authentic Andhra flavors.'); 
INSERT INTO Reviews VALUES   (3, 3, 2, 3, 'Decent food but service could be better.'); 
INSERT INTO Reviews VALUES   (4, 4, 4, 4, 'Loved the Malabar cuisine.'); 
INSERT INTO Reviews VALUES   (5, 5, 5, 4, 'Great Tamil Nadu dishes, will order again.'); 

DELETE FROM Favorites WHERE FavoriteID = 1;
DELETE FROM Reviews WHERE ReviewID = 1;

UPDATE Favorites SET RestaurantID = 4 WHERE FavoriteID = 2;
UPDATE Reviews SET Rating = 5, Comments = 'Excellent South Indian food!' WHERE ReviewID = 2;

