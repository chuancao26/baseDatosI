use carwash;
select * from cliente;

DELIMITER //

CREATE PROCEDURE BuscarAutosPorDNI(IN dni_param CHAR(8))
BEGIN
    SELECT *
    FROM auto
    JOIN cliente ON auto.codCliente = cliente.codCliente
    WHERE cliente.DNI = dni_param;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE BuscarClienteDNI(IN dni_param CHAR(8))
BEGIN
    SELECT codCliente, DNI, nombres, primerApellido, segundoApellido, fecNacimiento, sexo, telefono, correo, direccion
    FROM cliente
    WHERE DNI = dni_param;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE InsertarAuto(
    IN placa_param CHAR(7),
    IN tipo_param VARCHAR(20),
    IN volumen_param INTEGER,
    IN color_param VARCHAR(10),
    IN marca_param VARCHAR(20),
    IN modelo_param VARCHAR(20),
    IN dni_param CHAR(8)
)
BEGIN
    DECLARE cliente_id INTEGER;
	DECLARE max_codAuto INTEGER;
    SELECT codCliente INTO cliente_id FROM cliente WHERE DNI = dni_param;

    SET max_codAuto = 0;
    SELECT IFNULL(MAX(codAuto), 0) + 1 INTO max_codAuto FROM auto;

    INSERT INTO auto (codAuto, placa, tipo, volumen, color, marca, modelo, codCliente) 
    VALUES (max_codAuto, placa_param, tipo_param, volumen_param, color_param, marca_param, modelo_param, cliente_id);
    
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE ObtenerFacturaPorDNI (IN dniCliente CHAR(8))
BEGIN
    SELECT f.codFactura, f.fecha, f.total, f.metodoPago, f.codCita
    FROM factura f
    JOIN cita c ON f.codCita = c.codCita
    JOIN cliente cl ON c.codCliente = cl.codCliente
    WHERE cl.DNI = dniCliente;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE EliminarAuto(IN p_codAuto INT)
BEGIN
    DELETE FROM auto WHERE codAuto = p_codAuto;
END//

DELIMITER ;






