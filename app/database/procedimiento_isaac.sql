-- Borra el procedimiento InsertarMaquina
DROP PROCEDURE IF EXISTS InsertarMaquina;

-- Borra la función Ultimo_Id_Maquina
DROP FUNCTION IF EXISTS Ultimo_Id_Maquina;

-- Borra el procedimiento InsertarServicio
DROP PROCEDURE IF EXISTS InsertarServicio;

-- Borra la función Ultimo_Id_Servicio
DROP FUNCTION IF EXISTS Ultimo_Id_Servicio;

-- Borra el procedimiento InsertarUtensilio
DROP PROCEDURE IF EXISTS InsertarUtensilio;

-- Borra la función Ultimo_Id_Utensilio
DROP FUNCTION IF EXISTS Ultimo_Id_Utensilio;

-- Borra el procedimiento InsertarAuto2
DROP PROCEDURE IF EXISTS InsertarAuto2;

-- Borra la función Ultimo_Id_Auto
DROP FUNCTION IF EXISTS Ultimo_Id_Auto;

-- Borra el procedimiento BorrarMaquina
DROP PROCEDURE IF EXISTS BorrarMaquina;

-- Borra el procedimiento ActualizarMaquina
DROP PROCEDURE IF EXISTS ActualizarMaquina;

-- Borra el procedimiento MostrarMaquina
DROP PROCEDURE IF EXISTS MostrarMaquina;

-- Borra el procedimiento MostrarMaquinaU
DROP PROCEDURE IF EXISTS MostrarMaquinaU;

-- Borra el procedimiento BorrarAuto
DROP PROCEDURE IF EXISTS BorrarAuto;

-- Borra el procedimiento ActualizarAuto
DROP PROCEDURE IF EXISTS ActualizarAuto;

-- Borra el procedimiento MostrarAuto
DROP PROCEDURE IF EXISTS MostrarAuto;

-- Borra el procedimiento BorrarServicio
DROP PROCEDURE IF EXISTS BorrarServicio;

-- Borra el procedimiento ActualizarServicio
DROP PROCEDURE IF EXISTS ActualizarServicio;

-- Borra el procedimiento MostrarServicio
DROP PROCEDURE IF EXISTS MostrarServicio;

-- Borra el procedimiento BorrarUtensilio
DROP PROCEDURE IF EXISTS BorrarUtensilio;

-- Borra el procedimiento ActualizarUtensilio
DROP PROCEDURE IF EXISTS ActualizarUtensilio;

-- Borra el procedimiento MostrarUtensilio
DROP PROCEDURE IF EXISTS MostrarUtensilio;

-- Borra el procedimiento MostrarAutoU
DROP PROCEDURE IF EXISTS MostrarAutoU;

-- Borra el procedimiento MostrarServicioU
DROP PROCEDURE IF EXISTS MostrarServicioU;

-- Borra el procedimiento MostrarUtensilioU
DROP PROCEDURE IF EXISTS MostrarUtensilioU;


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
DELIMITER ;
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
    IN p_duracion TIME,
    IN p_descripcion VARCHAR(255),
    iN P_url_imagen varchar(255)
    )
BEGIN
	DECLARE id INT;
    SET id = Ultimo_Id_Servicio()+1;
	INSERT INTO servicio 
    VALUES (id, p_nombre, p_precio, p_duracion, p_descripcion, p_url_imagen);
END //
DELIMITER ;
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
DELIMITER ;
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
CREATE PROCEDURE InsertarAuto2(
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
DELIMITER ;

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
    IN p_duracion TIME,
    IN p_descripcion VARCHAR(255),
    IN p_url_imagen VARCHAR(255)
)
BEGIN
    UPDATE servicio
    SET nombre = p_nombre,
        precio = p_precio,
        duracion = p_duracion,
        descripcion = p_descripcion,
        url_imagen = p_url_imagen
    WHERE codServicio = p_codServicio;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE MostrarServicio()
BEGIN
    SELECT s.nombre, s.precio, s.duracion, s.descripcion, s.url_imagen, codServicio FROM servicio s;
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
    SELECT s.nombre, s.precio, s.duracion, s.descripcion, s.url_imagen, codServicio FROM servicio s
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
