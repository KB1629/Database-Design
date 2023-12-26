CREATE OR REPLACE FUNCTION GetUserOrderTotal(p_user_id  NUMBER)
RETURN NUMBER
IS
    v_total_amount NUMBER;
BEGIN

    SELECT SUM(Orders.TotalAmount)
    INTO v_total_amount
    FROM Orders
    WHERE Orders.UserID = p_user_id;

    RETURN NVL(v_total_amount, 0);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; 
    WHEN OTHERS THEN
        RAISE;
END GetUserOrderTotal;
declare
a number;
b number:=1;
begin
a:=GetUserOrderTotal(b);
dbms_output.put_line(a);
end;
