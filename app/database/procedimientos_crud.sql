

DELIMITER //
CREATE FUNCTION Ultimo_Id_Maquina() RETURNS INT DETERMINISTIC
BEGIN
	declare id INTEGER;
	SELECT IFNULL(max(m.codMaquina), 0)
    INTO id
    FROM maquina m;
    return id;
END
//
DELIMITER ;
-- Insertar
DELIMITER //
CREATE PROCEDURE InsertarMaquina(
    IN p_nombre VARCHAR(50),
    IN p_marca VARCHAR(20),
    IN p_funcion VARCHAR(50),
    IN p_precio DECIMAL(10,2),
    IN p_esta_operativa int,
    IN p_codProveedor INT,
    IN p_codLugar INT)
BEGIN
	DECLARE id INT;
    SET id = Ultimo_Id_Maquina()+1;
	INSERT INTO `maquina` 
    VALUES (id,p_nombre, p_marca, p_funcion, p_precio, p_esta_operativa, p_codProveedor, p_codLugar);
END //
DELIMITER;
DELIMITER //

CREATE FUNCTION Ultimo_Id_Servicio() RETURNS INT DETERMINISTIC
BEGIN
	declare id INTEGER;
	SELECT IFNULL(max(s.codServicio), 0)
    INTO id
    FROM servicio s;
    return id;
END
//
DELIMITER ;
-- Insertar
DELIMITER //
CREATE PROCEDURE InsertarServicio(
    IN p_nombre VARCHAR(30),
    IN p_precio DECIMAL(10,2),
    IN p_duracion TIME)
BEGIN
	DECLARE id INT;
    SET id = Ultimo_Id_Servicio()+1;
	INSERT INTO servicio 
    VALUES (id, p_nombre, p_precio, p_duracion);
END //
DELIMITER;
DELIMITER //

CREATE FUNCTION Ultimo_Id_Utensilio() RETURNS INT DETERMINISTIC
BEGIN
	declare id INTEGER;
	SELECT IFNULL(max(u.codUtensilio), 0)
    INTO id
    FROM utensilio u;
    return id;
END
//
DELIMITER ;
-- Insertar
DELIMITER //
CREATE PROCEDURE InsertarUtensilio(
    IN p_nombre VARCHAR(30),
    IN p_descripcion VARCHAR(150),
    IN p_precio DECIMAL(10,2),
    IN p_cantidad INTEGER,
    IN p_unidad CHAR(5))
BEGIN
	DECLARE id INT;
    SET id = Ultimo_Id_Utensilio()+1;
	INSERT INTO utensilio 
    VALUES (id, p_nombre, p_descripcion, p_precio, p_cantidad, p_unidad);
END //
DELIMITER;
DELIMITER //

CREATE FUNCTION Ultimo_Id_Auto() RETURNS INT DETERMINISTIC
BEGIN
	declare id INTEGER;
	SELECT IFNULL(max(a.codAuto), 0)
    INTO id
    FROM auto a;
    return id;
END
//
DELIMITER ;
-- Insertar
DELIMITER //
CREATE PROCEDURE InsertarAuto(
    IN p_placa CHAR(7),
    IN p_tipo VARCHAR(20),
    IN p_volumen INTEGER,
    IN p_color VARCHAR(10),
    IN p_marca VARCHAR(20),
    IN p_modelo VARCHAR(20),
    IN p_codCliente INT)
BEGIN
	DECLARE id INT;
    SET id = Ultimo_Id_Auto()+1;
	INSERT INTO auto 
    VALUES (id, p_placa, p_tipo, p_volumen, p_color, p_marca, p_modelo, p_codCliente);
END //
DELIMITER;

DELIMITER //

CREATE PROCEDURE BorrarMaquina(IN p_codMaquina INT)
BEGIN
    DELETE FROM maquina WHERE codMaquina = p_codMaquina;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE ActualizarMaquina(
    IN p_codMaquina INT,
    IN p_nombre VARCHAR(50),
    IN p_marca VARCHAR(20),
    IN p_funcion VARCHAR(50),
    IN p_precio DECIMAL(10,2),
    IN p_esta_operativa INT,
    IN p_codProveedor INT,
    IN p_codLugar INT
)
BEGIN
    UPDATE maquina
    SET nombre = p_nombre,
        marca = p_marca,
        funcion = p_funcion,
        precio = p_precio,
        estaOperativa = p_esta_operativa,
        codProveedor = p_codProveedor,
        codLugar = p_codLugar
    WHERE codMaquina = p_codMaquina;
END //

DELIMITER ;
DELIMITER //
CREATE PROCEDURE MostrarMaquina()
BEGIN
    SELECT m.nombre, m.marca, m.funcion, m.precio, m.estaOperativa, m.codProveedor, m.codLugar, codMaquina FROM maquina m;
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE MostrarMaquinaU(in codMaquina int)
BEGIN
    SELECT m.nombre, m.marca, m.funcion, m.precio, m.estaOperativa, m.codProveedor, m.codLugar, codMaquina FROM maquina m
    where m.codMaquina = codMaquina;
END //
DELIMITER ;
DELIMITER //

CREATE PROCEDURE BorrarAuto(IN p_codAuto INT)
BEGIN
    DELETE FROM auto WHERE codAuto = p_codAuto;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE ActualizarAuto(
    IN p_codAuto INT,
    IN p_placa CHAR(7),
    IN p_tipo VARCHAR(20),
    IN p_volumen INTEGER,
    IN p_color VARCHAR(10),
    IN p_marca VARCHAR(20),
    IN p_modelo VARCHAR(20),
    IN p_codCliente INT
)
BEGIN
    UPDATE auto
    SET placa = p_placa,
        tipo = p_tipo,
        volumen = p_volumen,
        color = p_color,
        marca = p_marca,
        modelo = p_modelo,
        codCliente = p_codCliente
    WHERE codAuto = p_codAuto;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE MostrarAuto()
BEGIN
    SELECT a.placa, a.tipo, a.volumen, a.color, a.marca, a.modelo, a.codCliente, codAuto FROM auto a;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE BorrarServicio(IN p_codServicio INT)
BEGIN
    DELETE FROM servicio WHERE codServicio = p_codServicio;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE ActualizarServicio(
    IN p_codServicio INT,
    IN p_nombre VARCHAR(30),
    IN p_precio DECIMAL(10,2),
    IN p_duracion TIME
)
BEGIN
    UPDATE servicio
    SET nombre = p_nombre,
        precio = p_precio,
        duracion = p_duracion
    WHERE codServicio = p_codServicio;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE MostrarServicio()
BEGIN
    SELECT s.nombre, s.precio, s.duracion, codServicio FROM servicio s;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE BorrarUtensilio(IN p_codUtensilio INT)
BEGIN
    DELETE FROM utensilio WHERE codUtensilio = p_codUtensilio;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE ActualizarUtensilio(
    IN p_codUtensilio INT,
    IN p_nombre VARCHAR(30),
    IN p_descripcion VARCHAR(150),
    IN p_precio DECIMAL(10,2),
    IN p_cantidad INTEGER,
    IN p_unidad CHAR(5)
)
BEGIN
    UPDATE utensilio
    SET nombre = p_nombre,
        descripcion = p_descripcion,
        precio = p_precio,
        cantidad = p_cantidad,
        unidad = p_unidad
    WHERE codUtensilio = p_codUtensilio;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE MostrarUtensilio()
BEGIN
    SELECT u.nombre, u.descripcion, u.precio, u.cantidad, u.unidad, codUtensilio FROM utensilio u;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE MostrarAutoU(IN codAuto INT)
BEGIN
    SELECT a.placa, a.tipo, a.volumen, a.color, a.marca, a.modelo, a.codCliente, codAuto FROM auto a
    WHERE a.codAuto = codAuto;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE MostrarServicioU(IN codServicio INT)
BEGIN
    SELECT s.nombre, s.precio, s.duracion, codServicio FROM servicio s
    WHERE s.codServicio = codServicio;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE MostrarUtensilioU(IN codUtensilio INT)
BEGIN
    SELECT u.nombre, u.descripcion, u.precio, u.cantidad, u.unidad, codUtensilio FROM utensilio u
    WHERE u.codUtensilio = codUtensilio;
END //

DELIMITER ;

