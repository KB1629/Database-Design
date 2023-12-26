
CREATE SEQUENCE review_sequence START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER before_insert_review
BEFORE INSERT ON Reviews
FOR EACH ROW
BEGIN
    :NEW.ReviewID := review_sequence.NEXTVAL;
END;

INSERT INTO Reviews (UserID, RestaurantID, Rating, Comments)
VALUES (6, 1, 5, 'Excellent service and delicious food');

