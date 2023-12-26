CREATE TABLE orders1 (
    dish_id NUMBER,
    restaurant_id NUMBER,
    item_name VARCHAR2(255),
    item_price NUMBER,
    item_description VARCHAR2(500)
);

select*from orders1;

CREATE TABLE registration (
    username VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    password VARCHAR2(255) NOT NULL,
    confirm_password VARCHAR2(255) NOT NULL
);