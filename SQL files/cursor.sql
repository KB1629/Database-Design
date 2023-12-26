DECLARE
    CURSOR user_cursor IS
        SELECT UserID, Username, Email FROM Users;
    v_user_id Users.UserID%TYPE;
    v_username Users.Username%TYPE;
    v_email Users.Email%TYPE;
BEGIN
    OPEN user_cursor;
    LOOP
        FETCH user_cursor INTO v_user_id, v_username, v_email;
        EXIT WHEN user_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('User ID: ' || v_user_id || ', Username: ' || v_username || ', Email: ' || v_email);
    END LOOP;
    CLOSE user_cursor;
END;

