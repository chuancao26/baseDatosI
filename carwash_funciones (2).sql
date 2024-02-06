-- ASISTENCIA -----------------------------------------------------------------------------------
DELIMITER //
drop procedure if exists MarcarEntrada//
CREATE PROCEDURE MarcarEntrada(
    IN codEmpleado_f INTEGER
)
BEGIN
	DECLARE fecha BIGINT;
    SET fecha = (select CONCAT(codEmpleado_f, count(*)) from asistencia);
	INSERT INTO `asistencia` (`codAsistencia`, `fecha`, `horaEntrada`, `horaSalida`, `codEmpleado`) 
    VALUES
    (fecha, curdate(), curtime(), NULL, codEmpleado_f);
	-- SELECT concat_ws(" ",fecha, curdate(), curtime(), NULL, codEmpleado_f) AS Status;
END;
//
DELIMITER ;

CALL MarcarEntrada(1);

DELIMITER //
drop procedure if exists MarcarSalida//
CREATE PROCEDURE MarcarSalida(
    IN codEmpleado_f INTEGER,
    IN codAsistencia_f INTEGER
)
BEGIN
    UPDATE `asistencia`
	SET `horaSalida` = curtime() 
    WHERE `codEmpleado` = codEmpleado_f and `codAsistencia` = codAsistencia_f; 
END;
//
DELIMITER ;

CALL MarcarSalida(1,10);
-- --------------------------------- un DNI existe?
DELIMITER //
drop function if exists DNI_Existe//
CREATE FUNCTION DNI_Existe(p_DNI INT) 
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE dniCount INT;
    SELECT COUNT(*) INTO dniCount
    FROM cliente
    WHERE DNI = p_DNI;
    RETURN dniCount > 0;
END;
//
DELIMITER ;

select DNI_Existe(p.DNI) as Nombre FROM cliente p;
-- ----------------------------- USUARIO 
DELIMITER //

CREATE PROCEDURE CrearUsuario(
    IN p_usuario VARCHAR(100),
    IN p_contraseña VARCHAR(100)
)
BEGIN
    -- Crear el usuario
    SET @create_user_sql := CONCAT('CREATE USER ''', p_usuario, ''' IDENTIFIED BY ''', p_contraseña, ''';');
    PREPARE create_user_stmt FROM @create_user_sql;
    EXECUTE create_user_stmt;
    DEALLOCATE PREPARE create_user_stmt;

    -- Otorgar privilegios
    GRANT ALL PRIVILEGES ON cliente.* TO p_usuario;
    GRANT ALL PRIVILEGES ON citas.* TO p_usuario;
    GRANT ALL PRIVILEGES ON auto.* TO p_usuario;
    GRANT ALL PRIVILEGES ON membresia.* TO p_usuario;

    -- Actualizar privilegios
    FLUSH PRIVILEGES;
END //

DELIMITER ;


-- ----------------------------------------------CREAR CLIENTE
DELIMITER //
drop procedure if exists Insertar_Cliente;
CREATE PROCEDURE Insertar_Cliente(
    IN c_DNI INT,
    IN c_Nombres VARCHAR(20),
    IN c_PrimerApellido VARCHAR(30),
    IN c_SegundoApellido VARCHAR(30),
    IN c_fechNacimiento DATE,
    IN c_Sexo CHAR (10),
    IN c_Telefono CHAR (12),
    IN c_correo VARCHAR(100),
    IN c_direccion VARCHAR(100),
    IN c_usuario VARCHAR(100), -- Nuevo parámetro para el usuario
    IN c_contraseña VARCHAR(100) -- Nuevo parámetro para la contraseña
)
BEGIN
    DECLARE dniExists BOOLEAN;
    DECLARE COD INT;
    SET dniExists = DNI_Existe(c_DNI);
    SET COD = CONCAT(YEAR(CURDATE())-2000, c_DNI);

    IF NOT dniExists THEN
        INSERT INTO `cliente` (`codCliente`,`DNI`,`nombres`,`primerApellido`,`segundoApellido`,`fecNacimiento`,`sexo`,`telefono`,`correo`,`direccion`) 
        VALUES (COD, c_DNI, c_Nombres, c_PrimerApellido, c_SegundoApellido, c_fechNacimiento, c_Sexo, c_Telefono, c_correo, c_direccion);

        -- Llamar al procedimiento para crear el usuario
        CALL CrearUsuario(c_usuario, c_contraseña);

        SELECT 'Cliente insertado correctamente y usuario creado.' AS Status;
    ELSE
        SELECT 'DNI ya existe. No se puede insertar.' AS Status;
    END IF;
END //

DELIMITER ;
CALL Insertar_Cliente(1234556, "A", "B", "C", CURDATE(), "F", "911", "a@gmail.com", "Calee", "nombre_usuario", "contraseña_usuario");

-- --------------------------------------------MODIFICAR DATOS------------------------

DELIMITER //
drop procedure if exists UpdateCliente//
CREATE PROCEDURE UpdateCliente(
	IN c_codCliente INT,
    IN c_DNI INT,
    IN c_Nombres VARCHAR(20),
    IN c_PrimerApellido VARCHAR(30),
    IN c_SegundoApellido VARCHAR(30),
    IN c_FechNacimiento DATE,
    IN c_Sexo CHAR (10),
    IN c_Telefono CHAR (12),
    IN c_correo VARCHAR(100),
    IN c_direccion varchar(100)
)
BEGIN
	DECLARE dniExists BOOLEAN;
    SET dniExists = DNI_Existe(c_DNI);

    IF dniExists THEN
        UPDATE Cliente
		SET 
			`nombres` = c_Nombres,
			`primerApellido` = c_PrimerApellido,
			`segundoApellido` = c_SegundoApellido,
			`fecNacimiento` = c_FechNacimiento,
			`sexo` = c_Sexo,
			`telefono` = c_Telefono,
			`correo` = c_correo,
			`direccion` = c_direccion
		WHERE codCliente = c_codCliente;
	 ELSE
        SELECT 'DNI No existe' AS Status;
    END IF;
END;
//
DELIMITER ;

call UpdateCliente(24123,123,"C","B","A",'1990-01-01',"F",911,"a@gmail.com", "Calee");

-- ---------------------------------------------------------------------------------------
DELIMITER //
drop function if exists cod_Existe//
CREATE FUNCTION cod_Existe(codCliente_f INT) 
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE codCount INT;
    SELECT COUNT(*) INTO codCount
    FROM cliente_membresia
    WHERE codCliente = codCliente_f;
    RETURN codCount > 0;
END;
//
DELIMITER ;

-- --------------------------------------- crear cliente

INSERT INTO membresia (codMembresia, nombre, descripcion, precio, duracion)
VALUES
  (1, 'Membresia Estándar', 'Acceso básico', 19.99, '5:000:00'),
  (2, 'Membresia Premium', 'Acceso completo', 49.99, '10:00:00'),
  (3, 'Membresia VIP', 'Acceso exclusivo', 99.99, '20:00:00');
  
DELIMITER //
drop procedure if exists CrearClienteMembresia//
CREATE PROCEDURE CrearClienteMembresia(
	IN f_codCliente INT,
    IN f_codMembresia INT
)BEGIN
	DECLARE codExists BOOLEAN;   DECLARE actual BOOLEAN;     DECLARE fin DATE; 
    SET fin = (SELECT ADDDATE(CURDATE(), interval m.duracion minute)
				from membresia m    where m.codMembresia=f_codMembresia);
	IF NOT cod_Existe(codExists) THEN
        INSERT INTO cliente_membresia (`codCliente`, `codMembresia`, `fecInicio`, `fecFin`, `estaActiva`)
		VALUES (f_codCliente,f_codMembresia,curdate(),fin, true);
		-- select CONCAT_WS(" ",f_codCliente,f_codMembresia,curdate(),fin, true) ;
    ELSE
		set actual = ( select m.codCliente from cliente_membresia m where m.codCliente=f_codCliente);
		IF NOT actual THEN
			UPDATE cliente_membresia
			SET 
				`fecInicio` = curdate(),
				`fecFin` = fin,
				`estaActiva` = true
				WHERE codCliente = f_codCliente;
		ELSE
			SET fin = (SELECT ADDDATE(m.fecFin, interval m.duracion minute)
				from cliente_membresia m    where m.codMembresia=f_codMembresia);
			UPDATE cliente_membresia
			SET 
				`fecFin` = fin
				WHERE codCliente = c_codCliente;
		END IF;
	END IF;
END;
//
DELIMITER ;

call CrearClienteMembresia(24123,1);
-- --------------------------------------------------------------------BUSCAR PLACA
DELIMITER //
drop function if exists Placa_Existe//
CREATE FUNCTION Placa_Existe(PlacaCliente_f INT) 
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE PlacaCount INT;
    SELECT COUNT(*) INTO PlacaCount
    FROM auto
    WHERE codAuto = PlacaCliente_f;
    RETURN PlacaCount > 0;
END;
//
DELIMITER ;
-- ----------------------------------------------------- cast
-- Primero, elimina la función si existe
DROP FUNCTION IF EXISTS ConvertirCharAEntero;

-- Luego, crea la función
DELIMITER //
CREATE FUNCTION ConvertirCharAEntero(p_valor CHAR(50)) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;

    WHILE i <= LENGTH(p_valor) DO
        IF ASCII(SUBSTRING(p_valor, i, 1)) BETWEEN ASCII('0') AND ASCII('9') THEN
            SET resultado = resultado * 10 + CAST(SUBSTRING(p_valor, i, 1) AS SIGNED);
        ELSE
            SET resultado = resultado * 26 + ASCII(SUBSTRING(p_valor, i, 1)) - ASCII('A') + 1;
        END IF;
        SET i = i + 1;
    END WHILE;

    RETURN resultado;
END //
DELIMITER ;



-- --------------------------------------------------------------------REGISTRO AUTO
DELIMITER //
drop procedure if exists InsertarAuto//
CREATE PROCEDURE InsertarAuto(
    IN p_placa CHAR(7),
    IN p_tipo VARCHAR(20),
    IN p_volumen INTEGER,
    IN p_color VARCHAR(10),
    IN p_marca VARCHAR(20),
    IN p_modelo VARCHAR(20),
    IN p_codCliente INTEGER
)
BEGIN
	declare COD Integer;
    set COD = concat(ConvertirCharAEntero(p_placa)/1,p_codCliente);
    IF NOT Placa_Existe(COD) THEN
		INSERT INTO auto (codAuto, placa, tipo, volumen, color, marca, modelo, codCliente)
		VALUES (COD, p_placa, p_tipo, p_volumen, p_color, p_marca, p_modelo, p_codCliente);
        -- select concat_ws("/",COD, p_placa, p_tipo, p_volumen, p_color, p_marca, p_modelo, p_codCliente);
	ELSE
		SELECT "Ya ha registrado esta placa"; 
	END IF;
END;
//
DELIMITER ;
CALL InsertarAuto('ABC1234', 'Sedán', 2000, 'Rojo', 'Toyota', 'Camry', 24123);
-- REGISTRO AUTO
-- BUSCAR POR ID
DELIMITER //
drop procedure if exists MostrarMisAuto//
CREATE PROCEDURE MostrarMisAuto(
    IN p_codCliente INTEGER
)
BEGIN
	declare COD Integer;
    set COD = (select COUNT(*) from auto where codCliente=p_codCliente);
    IF COD THEN
		select a.codAuto, a.placa, a.tipo, a.volumen, a.color, a.marca, a.modelo, a.codCliente
        FROM auto a
        Inner join cliente c ON c.codCliente=a.codCliente
        where c.codCliente=p_codCliente
        ;
	ELSE
		SELECT "No ha registrado ningún auto aún"; 
	END IF;
END;
//
DELIMITER ;
CALL MostrarMisAuto(24123);

-- ---------------------------------- Insertar empleado
DELIMITER //
drop procedure if exists Insertar_Empleado//
CREATE PROCEDURE Insertar_Empleado(
	IN codEmpleado int,
	IN DNI char(8),
	IN nombres varchar(50), 
	IN primerApellido varchar(30),
	IN segundoApellido varchar(30), 
	IN fecNacimiento date,
	IN sexo char(10), 
	IN telefono char(12), 
	IN correo varchar(100), 
	IN direccion varchar(100), 
	IN salario decimal(10,2), 
	IN puesto varchar(20), 
	IN aniosExperiencia int, 
	IN codHorario int
)
BEGIN
	DECLARE dniExists BOOLEAN;
    SET dniExists = DNI_Existe(DNI);
    
    IF NOT dniExists THEN
        INSERT INTO `empleado` (
			  `codEmpleado`,
			  `DNI`,
			  `nombres`,
			  `primerApellido`,
			  `segundoApellido`,
			  `fecNacimiento`,
			  `sexo`,
			  `telefono`,
			  `correo`,
			  `direccion`,
			  `salario`,
			  `puesto`,
			  `aniosExperiencia`,
			  `codHorario`
			) VALUES (
			  `codEmpleado`,
			  `DNI`,
			  `nombres`,
			  `primerApellido`,
			  `segundoApellido`,
			  `fecNacimiento`,
			  `sexo`,
			  `telefono`,
			  `correo`,
			  `direccion`,
			  `salario`,
			  `puesto`,
			  `aniosExperiencia`,
			  `codHorario`
			);
    ELSE
        SELECT 'DNI Already Exists. Cannot Insert.' AS Status;
    END IF;
END;
//
DELIMITER ;
call Insertar_Empleado(1,123444,"A","B","C",curdate(),"F","911","a@gmail.com", "Calee", 12.33, "nADA", 2, 1);

-- HORARIO

DELIMITER //
DROP PROCEDURE IF EXISTS Insertar_Horario//
CREATE PROCEDURE Insertar_Horario(
    IN c_codHorario INT,
    IN c_fecInicio DATE,
    IN c_fecFin DATE,
    IN c_turno CHAR(10)
)
BEGIN
    DECLARE codHorarioExists BOOLEAN;
    SET codHorarioExists = CodHorario_Existe(c_codHorario);
    
    IF NOT codHorarioExists THEN
        INSERT INTO `horario` (
            `codHorario`,
            `fecInicio`,
            `fecFin`,
            `turno`
        ) VALUES (
            c_codHorario,
            c_fecInicio,
            c_fecFin,
            c_turno
        );
    ELSE
        SELECT 'CodHorario Already Exists. Cannot Insert.' AS Status;
    END IF;
END;
//

CREATE FUNCTION CodHorario_Existe(c_codHorario INT) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE existsCount INT;
    SELECT COUNT(*) INTO existsCount FROM `horario` WHERE `codHorario` = c_codHorario;
    IF existsCount > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
//

DELIMITER ;

CALL Insertar_Horario(1, '2024-02-05', '2024-02-06', 'Mañana');

-- -------------------------------------------------------
-- Función para verificar si un código de factura ya existe
DELIMITER //
CREATE FUNCTION CodFactura_Existe(c_codFactura INT) RETURNS BOOLEAN
BEGIN
    DECLARE existsCount INT;
    SELECT COUNT(*) INTO existsCount FROM `factura` WHERE `codFactura` = c_codFactura;
    RETURN existsCount > 0;
END;
//
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Insertar_Factura//
CREATE PROCEDURE Insertar_Factura(
    IN c_fecha DATETIME,
    IN c_total DECIMAL(10,2),
    IN c_metodoPago CHAR(15),
    IN c_codCita INT
)
BEGIN
    DECLARE codFacturaExists BOOLEAN;
    DECLARE COD INTEGER;
    SET codFacturaExists = CodFactura_Existe(c_codFactura);
    SET COD = (select CONCAT(c_codCita, count(*)) from asistencia);
    
    IF NOT codFacturaExists THEN
        INSERT INTO `factura` (
            `codFactura`,
            `fecha`,
            `total`,
            `metodoPago`,
            `codCita`
        ) VALUES (
            c_codFactura,
            c_fecha,
            c_total,
            c_metodoPago,
            c_codCita
        );
    ELSE
        SELECT 'CodFactura Already Exists. Cannot Insert.' AS Status;
    END IF;
END;
//
-- ------------------------------
DELIMITER //
CREATE FUNCTION MaquinaEmpleado_Existe(c_codMaquina INT, c_codEmpleado INT) RETURNS BOOLEAN
BEGIN
    DECLARE existsCount INT;
    SELECT COUNT(*) INTO existsCount FROM `maquina_empleado` WHERE `codMaquina` = c_codMaquina AND `codEmpleado` = c_codEmpleado;
    RETURN existsCount > 0;
END;
//
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Insertar_MaquinaEmpleado//
CREATE PROCEDURE Insertar_MaquinaEmpleado(
    IN c_codMaquina INT,
    IN c_codEmpleado INT
)
BEGIN
    DECLARE maquinaEmpleadoExists BOOLEAN;
    SET maquinaEmpleadoExists = MaquinaEmpleado_Existe(c_codMaquina, c_codEmpleado);
    
    IF NOT maquinaEmpleadoExists THEN
        INSERT INTO `maquina_empleado` (
            `codMaquina`,
            `codEmpleado`
        ) VALUES (
            c_codMaquina,
            c_codEmpleado
        );
    ELSE
        SELECT 'Relación Maquina-Empleado Already Exists. Cannot Insert.' AS Status;
    END IF;
END;
//
