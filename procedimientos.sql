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
	select r.codRepresentante codigo,
           concat_ws(' ',r.nombres,r.primerApellido,r.segundoApellido) representante,
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
	select r.codRepresentante codigo,
           concat_ws(' ',r.nombres,r.primerApellido,r.segundoApellido) representante,
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
	select s.codServicio codigo,s.nombre, s.precio, s.duracion
    from servicio s;
END
//
DELIMITER ;
-- Buscar por id
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Servicio//
CREATE PROCEDURE Buscar_Servicio(IN cod INT)
BEGIN
	select s.codServicio codigo,s.nombre, s.precio, s.duracion
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
-- Buscar todos
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Citas//
CREATE PROCEDURE Buscar_Citas()
BEGIN
	select c.codCita codigo, c.fecha, c.hora,c.progreso,
           concat_ws(' ',cl.nombres,cl.primerApellido,cl.segundoApellido) cliente,
           s.nombre servicio
    from cita c
    inner join cliente cl on c.codCliente=cl.codCliente
    inner join servicio s on c.codServicio=s.codServicio;
END
//
DELIMITER ;
-- Buscar por id
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Cita//
CREATE PROCEDURE Buscar_Cita(IN cod INT)
BEGIN
	select c.codCita codigo, c.fecha, c.hora,c.progreso,
           concat_ws(' ',cl.nombres,cl.primerApellido,cl.segundoApellido) cliente,
           s.nombre servicio
    from cita c
    inner join cliente cl on c.codCliente=cl.codCliente
    inner join servicio s on c.codServicio=s.codServicio
    where c.codCita=cod;
END
//
DELIMITER ;
-- Buscar citas por clientes
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Citas_Cliente//
CREATE PROCEDURE Buscar_Citas_Cliente(IN cod INT)
BEGIN
	select c.codCita codigo, c.fecha, c.hora,c.progreso,
           s.nombre servicio
    from cita c
    inner join servicio s on c.codServicio=s.codServicio
    where c.codCliente=cod;
END
//
DELIMITER ;
-- Procedimientos de Maquina
-- Funciones
DELIMITER //
DROP FUNCTION IF EXISTS Ultimo_Id_Maquina//
CREATE FUNCTION Ultimo_Id_Maquina() RETURNS INT DETERMINISTIC
BEGIN
	declare id INTEGER;
	SELECT max(m.codMaquina)
    INTO id
    FROM maquina m;
    return id;
END
//
DELIMITER ;
-- Insertar
DELIMITER //
DROP PROCEDURE IF EXISTS Insertar_Maquina//
CREATE PROCEDURE Insertar_Maquina(
IN nom VARCHAR(50),
IN mar varchar(20),
IN fun VARCHAR(50),
IN pre DECIMAL(10,2),
IN pro INT,
IN lug INT)
BEGIN
	DECLARE id INT;
    SET id = Ultimo_Id_Maquina()+1;
	INSERT INTO `cita` 
    VALUES (id,nom,mar,fun,pre,1,pro,lug);
END
//
DELIMITER ;
-- Actualizar
DELIMITER //
DROP PROCEDURE IF EXISTS Actualizar_Maquina//
CREATE PROCEDURE Actualizar_Maquina(
IN cod INT,
IN nom VARCHAR(50),
IN mar varchar(20),
IN fun VARCHAR(50),
IN pre DECIMAL(10,2),
IN lug INT)
BEGIN
	UPDATE `maquina` 
    SET nombre = nom,
        marca = mar,
        funcion = fun,
        precio = pre,
        codLugar = lug
    WHERE codMaquina = cod;
END
//
DELIMITER ;
-- Actualizar operatividad
DELIMITER //
DROP PROCEDURE IF EXISTS Actualizar_Maquina_Operativa//
CREATE PROCEDURE Actualizar_Maquina_Operativa(IN cod INT,IN est BIT)
BEGIN
	UPDATE `maquina` 
    SET estaOperativa=est
    WHERE codMaquina = cod;
END
//
DELIMITER ;
-- Buscar todos
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Maquinas//
CREATE PROCEDURE Buscar_Maquinas()
BEGIN
	select m.codMaquina codigo, m.nombre, m.funcion,
           p.nombre proveedor ,l.nombre lugar
    from maquina m
    inner join lugar l on l.codLugar=m.codLugar
    inner join proveedor p on p.codProveedor=m.codProveedor;
END
//
DELIMITER ;
-- Buscar por id
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Maquina//
CREATE PROCEDURE Buscar_Maquina(IN cod INT)
BEGIN
	select m.codMaquina codigo, m.nombre, m.funcion,
           p.nombre proveedor ,l.nombre lugar
    from maquina m
    inner join lugar l on l.codLugar=m.codLugar
    inner join proveedor p on p.codProveedor=m.codProveedor
    where m.codMaquina=cod;
END
//
DELIMITER ;
-- Buscar maquina por proveedor
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Maquinas_Proveedor//
CREATE PROCEDURE Buscar_Maquinas_Proveedor(IN cod INT)
BEGIN
	select m.codMaquina codigo, m.nombre, m.funcion
    from maquina m
    inner join proveedor p on p.codProveedor=m.codProveedor
    where m.codProveedor=cod;
END
//
DELIMITER ;
-- Buscar maquina por lugar
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Maquinas_Lugar//
CREATE PROCEDURE Buscar_Maquinas_Lugar(IN cod INT)
BEGIN
	select m.codMaquina codigo, m.nombre, 
           m.funcion, l.nombre lugar
    from maquina m
    inner join lugar l on l.codLugar=m.codLugar
    where m.codProveedor=cod;
END
//
DELIMITER ;
-- Procedimientos de Proveedor
-- Funciones
DELIMITER //
DROP FUNCTION IF EXISTS Ultimo_Id_Proveedor//
CREATE FUNCTION Ultimo_Id_Proveedor() RETURNS INT DETERMINISTIC
BEGIN
	declare id INTEGER;
	SELECT max(p.codProveedor)
    INTO id
    FROM proveedor p;
    return id;
END
//
DELIMITER ;
-- Insertar
DELIMITER //
DROP PROCEDURE IF EXISTS Insertar_Proveedor//
CREATE PROCEDURE Insertar_Proveedor(
IN nom VARCHAR(30),
IN tel CHAR(12),
IN dir VARCHAR(100),
IN rep INT)
BEGIN
	DECLARE id INT;
    SET id = Ultimo_Id_Proveedor()+1;
	INSERT INTO `proveedor` 
    VALUES (id,nom,tel,dir,rep);
END
//
DELIMITER ;
-- Actualizar
DELIMITER //
DROP PROCEDURE IF EXISTS Actualizar_Proveedor//
CREATE PROCEDURE Actualizar_Proveedor(
IN cod INT,
IN nom VARCHAR(30),
IN tel CHAR(12),
IN dir VARCHAR(100))
BEGIN
	UPDATE `proveedor` 
    SET nombre = nom,
        telefono = tel,
        direccion = dir
    WHERE codProveedor = cod;
END
//
DELIMITER ;
-- Buscar todos
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Proveedores//
CREATE PROCEDURE Buscar_Proveedores()
BEGIN
	select p.codProveedor codigo, p.nombre, 
           p.telefono,p.direccion,
           concat_ws(' ',r.nombres,r.primerApellido,r.segundoApellido) representante
    from proveedor p
    inner join representante r on r.codRepresentante=p.codRepresentante;
END
//
DELIMITER ;
-- Buscar por id
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Proveedor//
CREATE PROCEDURE Buscar_Proveedor(IN cod INT)
BEGIN
	select p.codProveedor codigo, p.nombre, 
           p.telefono,p.direccion,
           concat_ws(' ',r.nombres,r.primerApellido,r.segundoApellido) representante
    from proveedor p
    inner join representante r on r.codRepresentante=p.codRepresentante
    where p.codProveedor=cod;
END
//
DELIMITER ;
-- Procedimientos de Utensilios
-- Funciones
DELIMITER //
DROP FUNCTION IF EXISTS Ultimo_Id_Utensilio//
CREATE FUNCTION Ultimo_Id_Utensilio() RETURNS INT DETERMINISTIC
BEGIN
	declare id INTEGER;
	SELECT max(u.codUtensilio)
    INTO id
    FROM utensilio u;
    return id;
END
//
DELIMITER ;
-- Insertar
DELIMITER //
DROP PROCEDURE IF EXISTS Insertar_Utensilio//
CREATE PROCEDURE Insertar_Utensilio(
IN nom VARCHAR(30),
IN des VARCHAR(50),
IN pre DECIMAL(10,2),
IN can INT,
IN uni CHAR(5))
BEGIN
	DECLARE id INT;
    SET id = Ultimo_Id_Utensilio()+1;
	INSERT INTO `utensilio` 
    VALUES (id,nom,des,pre,can,uni);
END
//
DELIMITER ;
-- Actualizar
DELIMITER //
DROP PROCEDURE IF EXISTS Actualizar_Utensilio//
CREATE PROCEDURE Actualizar_Utensilio(
IN cod INT,
IN nom VARCHAR(30),
IN des VARCHAR(50),
IN pre DECIMAL(10,2),
IN can INT,
IN uni CHAR(5))
BEGIN
	UPDATE `utensilio` 
    SET nombre = nom,
		descripcion = des,
		precio = pre,
		cantidad = can,
		unidad = uni
    WHERE codUtensilio = cod;
END
//
DELIMITER ;
-- Buscar todos
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Utensilios//
CREATE PROCEDURE Buscar_Utensilios()
BEGIN
	select u.codUtensilio codigo, u.nombre, u.cantidad,
		   u.unidad,u.precio
    from utensilio u;
END
//
DELIMITER ;
-- Buscar todos los utensilios de un proveedor
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Utensilios//
CREATE PROCEDURE Buscar_Utensilios(IN cod INT)
BEGIN
	select u.codUtensilio codigo, u.nombre, u.cantidad,
		   u.unidad,u.precio
    from utensilio u
    inner join proveedor_utensilio pu on pu.codUtensilio=u.codUtensilio
    inner join proveedor p on p.codProveedor=pu.codProveedor
    where p.codProveedor=cod;
END
//
DELIMITER ;
-- Buscar por id
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Utensilio//
CREATE PROCEDURE Buscar_Utensilio(IN cod INT)
BEGIN
	select u.codUtensilio codigo, u.nombre, u.cantidad,
		   u.unidad,u.precio
    from utensilio u
    where u.codUtensilio=cod;
END
//
DELIMITER ;
-- Procedimientos de lugar
-- Funciones
DELIMITER //
DROP FUNCTION IF EXISTS Ultimo_Id_Lugar//
CREATE FUNCTION Ultimo_Id_Lugar() RETURNS INT DETERMINISTIC
BEGIN
	declare id INTEGER;
	SELECT max(l.codLugar)
    INTO id
    FROM lugar l;
    return id;
END
//
DELIMITER ;
-- Insertar
DELIMITER //
DROP PROCEDURE IF EXISTS Insertar_Lugar//
CREATE PROCEDURE Insertar_Lugar(
IN nom VARCHAR(30),
IN ubi CHAR(5),
IN fun VARCHAR(30),
IN cap INT)
BEGIN
	DECLARE id INT;
    SET id = Ultimo_Id_Lugar()+1;
	INSERT INTO `lugar` 
    VALUES (id,nom,ubi,fun,cap);
END
//
DELIMITER ;
-- Actualizar
DELIMITER //
DROP PROCEDURE IF EXISTS Actualizar_Lugar//
CREATE PROCEDURE Actualizar_Lugar(
IN cod INT,
IN nom VARCHAR(30),
IN ubi CHAR(5),
IN fun VARCHAR(30),
IN cap INT)
BEGIN
	UPDATE `lugar` 
    SET nombre = nom,
		ubicacion = ubi,
		funcion = fun,
		capacidad = cap
    WHERE codLugar = cod;
END
//
DELIMITER ;
-- Buscar todos
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Lugares//
CREATE PROCEDURE Buscar_Lugares()
BEGIN
	select l.codLugar codigo, l.nombre,l.ubicacion,
           l.capacidad
    from lugar l;
END
//
DELIMITER ;
-- Buscar id
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_Lugar//
CREATE PROCEDURE Buscar_Lugar(IN cod INT)
BEGIN
	select l.codLugar codigo, l.nombre,l.ubicacion,
           l.capacidad
    from lugar l
    where l.codLugar=cod;
END
//
DELIMITER ;