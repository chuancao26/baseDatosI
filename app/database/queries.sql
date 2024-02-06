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
CREATE FUNCTION Usuario_Existe(p_usuario VARCHAR(100)) 
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE userCount INT;
    SELECT COUNT(*) INTO userCount
    FROM mysql.user
    WHERE User = p_usuario;
    RETURN userCount > 0;
END;
//
DELIMITER //

CREATE PROCEDURE CrearUsuario(
    IN p_usuario VARCHAR(100),
    IN p_contraseña VARCHAR(100)
)
BEGIN
	declare extistU bool;
    set extistU = Usuario_Existe(extistU);
    -- Crear el usuario
    IF NOT extistU THEN
		SET @create_user_sql := CONCAT('CREATE USER ''', p_usuario, ''' IDENTIFIED BY ''', p_contraseña, ''';');
		PREPARE create_user_stmt FROM @create_user_sql;
		EXECUTE create_user_stmt;
		DEALLOCATE PREPARE create_user_stmt;

		-- Otorgar privilegios
		GRANT ALL PRIVILEGES ON cliente.* TO p_usuario;
		GRANT ALL PRIVILEGES ON citas.* TO p_usuario;
		GRANT ALL PRIVILEGES ON auto.* TO p_usuario;
		GRANT ALL PRIVILEGES ON membresia.* TO p_usuario;
	else
		select "El usuario ya existe";
	end if;

    -- Actualizar privilegios
    FLUSH PRIVILEGES;
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE crear_usuario (
    IN p_nombre_usuario VARCHAR(50),
    IN p_contrasena VARCHAR(50)
)
BEGIN
    DECLARE usuario_existente INT;

    -- Verificar si el usuario ya existe
    SELECT COUNT(*) INTO usuario_existente
    FROM mysql.user
    WHERE user = p_nombre_usuario;

    -- Si el usuario no existe, crearlo
    IF usuario_existente = 0 THEN
        SET @sql = CONCAT('CREATE USER ''', p_nombre_usuario, '''@''localhost'' IDENTIFIED BY ''', p_contrasena, '''');
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        
        -- Asignar privilegios
        SET @sql = CONCAT('GRANT ALL PRIVILEGES ON *.* TO ''', p_nombre_usuario, '''@''localhost''');
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        
        SELECT 'Usuario creado exitosamente.' AS mensaje;
    ELSE
        SELECT 'El usuario ya existe.' AS mensaje;
    END IF;
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
    DECLARE COD BIGINT;
    SET dniExists = DNI_Existe(c_DNI);
    SET COD = c_DNI- YEAR(CURDATE())-2000;

    IF NOT dniExists THEN
        INSERT INTO `cliente` (`codCliente`,`DNI`,`nombres`,`primerApellido`,`segundoApellido`,`fecNacimiento`,`sexo`,`telefono`,`correo`,`direccion`) 
        VALUES (COD, c_DNI, c_Nombres, c_PrimerApellido, c_SegundoApellido, c_fechNacimiento, c_Sexo, c_Telefono, c_correo, c_direccion);

        -- Llamar al procedimiento para crear el usuario
        CALL crear_usuario(c_usuario, c_contraseña);

        SELECT 'Cliente insertado correctamente y usuario creado.' AS Status;
    ELSE
        SELECT 'DNI ya existe. No se puede insertar.' AS Status;
    END IF;
END //

DELIMITER ;