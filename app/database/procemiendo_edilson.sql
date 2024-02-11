DELIMITER //

CREATE PROCEDURE GetCodClienteByDNI( dni_param VARCHAR(20))
BEGIN
    SELECT codCliente FROM cliente WHERE DNI = dni_param;
END//

DELIMITER ;


use carwash;
-- Procedimientos de Cita
-- Funciones
--

-- obtener factura maxima
DELIMITER //
CREATE PROCEDURE obtenerFacturaMaxima()
BEGIN
    DECLARE maxCodFactura INT;
    SELECT MAX(codFactura) INTO maxCodFactura FROM factura;
    SELECT * FROM factura WHERE codFactura = maxCodFactura;
END //
DELIMITER ;

-- obtener Monto_a_Pagar
DELIMITER //
DROP FUNCTION IF EXISTS obtenerPrecioServicio//
CREATE FUNCTION obtenerPrecioServicio(codigo INT)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE precio_ DECIMAL(10,2);
    SELECT precio INTO precio_ FROM servicio WHERE codServicio = codigo;
    
    RETURN precio_;
END //
DELIMITER ;

-- obtener_ultimo id factura
DELIMITER //
DROP FUNCTION IF EXISTS Ultimo_Id_Factura//
CREATE FUNCTION Ultimo_Id_Factura() RETURNS INT DETERMINISTIC
BEGIN
	declare id INTEGER;
	SELECT max(f.codFactura)
    INTO id
    FROM factura f;
    return id;
END
//
DELIMITER ;

-- insertar_factura

DELIMITER //
DROP PROCEDURE IF EXISTS generarFactura//
CREATE PROCEDURE generarFactura(
     codigoServicio INT,
     metodoPago CHAR(15)
)
BEGIN
    DECLARE fechaHoraActual DATETIME;
    DECLARE id int;
    DECLARE total decimal(10,2);
    DECLARE codigoCita INT;
    
    SET fechaHoraActual = NOW();
    SET id = 1 + Ultimo_Id_Factura();
    SET total = obtenerPrecioServicio(codigoServicio);
    SET codigoCita = Ultimo_Id_Cita();
    
    INSERT INTO factura (codFactura, fecha, total, metodoPago, codCita)
    VALUES (id,fechaHoraActual, total, metodoPago, codigoCita);
END //
DELIMITER ;

DROP FUNCTION IF EXISTS Ultimo_Id_Cita;
-- div
DELIMITER //

CREATE FUNCTION Ultimo_Id_Cita() RETURNS INT DETERMINISTIC
BEGIN
	declare id INTEGER;
	SELECT max(c.codCita)
    INTO id
    FROM cita c;
    return id;
END
//
DELIMITER ;
-- Insertar
DROP PROCEDURE IF EXISTS Insertar_Cita;
DELIMITER //

CREATE PROCEDURE Insertar_Cita(
IN fec DATE,
IN hor TIME,
IN cli INT,
IN ser INT)
BEGIN
	DECLARE id INT;
    SET id = Ultimo_Id_Cita()+1;
	INSERT INTO `cita` 
    VALUES (id,fec,hor,'RESERVADO',cli,ser);
END
//
DELIMITER ;
//
DELIMITER ;
-- Procedimientos de Cita
-- Funciones
drop function Ultimo_Id_Cita;
DELIMITER //
CREATE FUNCTION Ultimo_Id_Cita() RETURNS INT DETERMINISTIC
BEGIN
	declare id INTEGER;
	SELECT max(c.codCita)
    INTO id
    FROM cita c;
    return id;
END
//
DELIMITER ;
-- Insertar
DROP PROCEDURE IF EXISTS Insertar_Cita;
DELIMITER //

CREATE PROCEDURE Insertar_Cita(

IN fec DATE,
IN hor TIME,
IN cli INT,
IN ser INT)
BEGIN
	DECLARE id INT;
    SET id = Ultimo_Id_Cita()+1;
	INSERT INTO cita 
    VALUES (id,fec,hor,'RESERVADO',cli,ser);
END
//
DELIMITER ;