-- Procedimientos de Representante
-- Funciones
DELIMITER //
DROP FUNCTION IF EXISTS Ultimo_Id_Representante//
CREATE FUNCTION Ultimo_Id_Representante() RETURNS INT DETERMINISTIC
BEGIN
	declare id INTEGER;
	SELECT max(r.codRepresentante)
    INTO id
    FROM representante r;
    return id;
END
//
DELIMITER ;
-- Insertar
DELIMITER //
DROP PROCEDURE IF EXISTS Insertar_Representante//
CREATE PROCEDURE Insertar_Representante(
IN dni CHAR(8),
IN nom VARCHAR(50),
IN pApel VARCHAR(30),
IN sApel VARCHAR(30),
IN fec DATE,
IN sex CHAR(10),
IN tel CHAR(12),
IN cor VARCHAR(100),
IN dir VARCHAR(100))
BEGIN
	DECLARE id INT;
    SET id = Ultimo_Id_Representante()+1;
	INSERT INTO `representante` 
    VALUES (id,dni,nom,pApel,sApel,fec,sex,tel,cor,dir);
END
//
DELIMITER ;
-- Actualizar
DELIMITER //
DROP PROCEDURE IF EXISTS Actualizar_Representante//
CREATE PROCEDURE Actualizar_Representante(
IN cod INT,
IN dni CHAR(8),
IN nom VARCHAR(50),
IN pApel VARCHAR(30),
IN sApel VARCHAR(30),
IN fec DATE,
IN sex CHAR(10),
IN tel CHAR(12),
IN cor VARCHAR(100),
IN dir VARCHAR(100))
BEGIN
	UPDATE `representante` 
    SET DNI = dni,
        nombres = nom,
        primerApellido = pApel,
        segundoApellido = sApel,
        fecNacimiento = fec,
        sexo = sex,
        telefono = tel,
        correo = cor,
        direccion = dir
    WHERE codRepresentante = cod;
END
//
DELIMITER ;
-- Buscar todos
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Representantes//
CREATE PROCEDURE Buscar_Representantes()
BEGIN
	select concat_ws(' ',r.nombres,r.primerApellido,r.segundoApellido) representante,
           r.sexo,
           r.telefono,
           r.correo,
           r.direccion
    from representante r;
END
//
DELIMITER ;
-- Buscar por id
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Representante//
CREATE PROCEDURE Buscar_Representante(IN cod INT)
BEGIN
	select concat_ws(' ',r.nombres,r.primerApellido,r.segundoApellido) representante,
           r.sexo,
           r.telefono,
           r.correo,
           r.direccion
    from representante r
    where r.codRepresentante = cod;
END
//
DELIMITER ;
-- Procedimientos de Servicio
-- Funciones
DELIMITER //
DROP FUNCTION IF EXISTS Ultimo_Id_Servicio//
CREATE FUNCTION Ultimo_Id_Servicio() RETURNS INT DETERMINISTIC
BEGIN
	declare id INTEGER;
	SELECT max(s.codServicio)
    INTO id
    FROM servicio s;
    return id;
END
//
DELIMITER ;
-- Insertar
DELIMITER //
DROP PROCEDURE IF EXISTS Insertar_Servicio//
CREATE PROCEDURE Insertar_Servicio(
IN nom VARCHAR(30),
IN prec DECIMAL(10,2),
IN dura TIME)
BEGIN
	DECLARE id INT;
    SET id = Ultimo_Id_Servicio()+1;
	INSERT INTO `servicio` 
    VALUES (id,nom,prec,dura);
END
//
DELIMITER ;
-- Actualizar
DELIMITER //
DROP PROCEDURE IF EXISTS Actualizar_Servicio//
CREATE PROCEDURE Actualizar_Servicio(
IN cod INT,
IN nom VARCHAR(30),
IN prec DECIMAL(10,2),
IN dura TIME)
BEGIN
	UPDATE `servicio` 
    SET nombre = nom,
        precio = prec,
        duracion = dura
    WHERE codServicio = cod;
END
//
DELIMITER ;
-- Buscar todos
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Servicios//
CREATE PROCEDURE Buscar_Servicios()
BEGIN
	select s.nombre, s.precio, s.duracion
    from servicio s;
END
//
DELIMITER ;
-- Buscar por id
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Servicio//
CREATE PROCEDURE Buscar_Servicio(IN cod INT)
BEGIN
	select s.nombre, s.precio, s.duracion
    from servicio s
    where s.codServicio = cod;
END
//
DELIMITER ;
-- Buscar servicio por tipo auto
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Servicio_Auto//
CREATE PROCEDURE Buscar_Servicio_Auto(IN tipAuto varchar(20))
BEGIN
	select s.nombre, s.precio, s.duracion
    from servicio s
    where s.codServicio = cod
    and upper(s.nombre) like concat('%',upper(tipAuto));
END
//
DELIMITER ;
-- Procedimientos de Cita
-- Funciones
DELIMITER //
DROP FUNCTION IF EXISTS Ultimo_Id_Cita//
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
DELIMITER //
DROP PROCEDURE IF EXISTS Insertar_Cita//
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
-- Actualizar
DELIMITER //
DROP PROCEDURE IF EXISTS Actualizar_Cita//
CREATE PROCEDURE Actualizar_Cita(
IN cod INT,
IN fec DATE,
IN hor TIME,
IN cli INT,
IN ser INT)
BEGIN
	UPDATE `cita` 
    SET fecha = fec,
        hora = hor,
        codCliente = cli,
        codServicio = ser
    WHERE codCita = cod;
END
//
DELIMITER ;