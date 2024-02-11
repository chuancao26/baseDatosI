CREATE TABLE admin (
    codAdmin INT PRIMARY KEY auto_increment,
    DNI VARCHAR(8),
    usuario VARCHAR(50)
);


create table 
DELIMITER //
drop function if exists esAdmin;
CREATE FUNCTION esAdmin(username varchar(100)) 
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE adminc INT;
    SELECT COUNT(*) INTO adminc
    FROM cliente c
    WHERE c.usuario = username;
    RETURN adminc > 0;
END//
DELIMITER ;