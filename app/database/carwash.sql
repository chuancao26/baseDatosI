DROP DATABASE IF EXISTS carwash
;
create database carwash;
use carwash;

CREATE TABLE `empleado` (
  `codEmpleado` INTEGER,
  `DNI` CHAR(8),
  `nombres` VARCHAR(50),
  `primerApellido` VARCHAR(30),
  `segundoApellido` VARCHAR(30),
  `fecNacimiento` DATE,
  `sexo` CHAR(10),
  `telefono` CHAR(12),
  `correo` VARCHAR(100),
  `direccion` VARCHAR(100),
  `salario` DECIMAL(10,2),
  `puesto` VARCHAR(20),
  `aniosExperiencia` INTEGER,
  `codHorario` INTEGER,
  PRIMARY KEY (`codEmpleado`)
);
		
CREATE TABLE `cliente` (
  `codCliente` INTEGER,
  `DNI` CHAR(8),
  `nombres` VARCHAR(50),
  `primerApellido` VARCHAR(30),
  `segundoApellido` VARCHAR(30),
  `fecNacimiento` DATE,
  `sexo` CHAR(10),
  `telefono` CHAR(12),
  `correo` VARCHAR(100),
  `direccion` VARCHAR(100),
  PRIMARY KEY (`codCliente`),
  usuario varchar(55),
  password char(255)
);


CREATE TABLE `representante` (
  `codRepresentante` INTEGER,
  `DNI` CHAR(8),
  `nombres` VARCHAR(50),
  `primerApellido` VARCHAR(30),
  `segundoApellido` VARCHAR(30),
  `fecNacimiento` DATE,
  `sexo` CHAR(10),
  `telefono` CHAR(12),
  `correo` VARCHAR(100),
  `direccion` VARCHAR(100),
  PRIMARY KEY (`codRepresentante`)
);

CREATE TABLE `asistencia` (
  `codAsistencia` INTEGER,
  `fecha` DATE,
  `horaEntrada` TIME,
  `horaSalida` TIME,
  `codEmpleado` INTEGER,
  PRIMARY KEY (`codAsistencia`)
);
		
CREATE TABLE `cita` (
  `codCita` INTEGER,
  `fecha` DATE,
  `hora` TIME,
  `progreso` VARCHAR(20),
  `codCliente` INTEGER,
  `codServicio` INTEGER,
  PRIMARY KEY (`codCita`)
);
	
CREATE TABLE `utensilio` (
  `codUtensilio` INTEGER,
  `nombre` VARCHAR(30),
  `descripcion` VARCHAR(50),
  `precio` DECIMAL(10,2),
  `cantidad` INTEGER,
  `unidad` CHAR(5),
  PRIMARY KEY (`codUtensilio`)
);
		
CREATE TABLE `servicio` (
	`codServicio` INTEGER,
	`nombre` VARCHAR(30),
	`precio` DECIMAL(10,2),
	`duracion` TIME,
	`descripcion` VARCHAR(200),
    `url_imagen` VARCHAR(150),
  PRIMARY KEY (`codServicio`)
);


CREATE TABLE `servicio_utensilio` (
  `codServicio` INTEGER,
  `codUtensilio` INTEGER,
  `cantidad` INTEGER,
  PRIMARY KEY (`codServicio`, `codUtensilio`)
);
	
CREATE TABLE `proveedor` (
  `codProveedor` INTEGER,
  `nombre` VARCHAR(30),
  `telefono` CHAR(12),
  `direccion` VARCHAR(100),
  `codRepresentante` INTEGER,
  PRIMARY KEY (`codProveedor`)
);
	
CREATE TABLE `proveedor_utensilio` (
  `codProveedor` INTEGER,
  `codUtensilio` INTEGER,
  `fecha` DATETIME,
  `cantidad` INTEGER,
  `total` DECIMAL(10,2),
  PRIMARY KEY (`codProveedor`, `codUtensilio`)
);

CREATE TABLE `maquina` (
  `codMaquina` INTEGER,
  `nombre` VARCHAR(50),
  `marca` VARCHAR(20),
  `funcion` VARCHAR(50),
  `precio` DECIMAL(10,2),
  `estaOperativa` bit,
  `codProveedor` INTEGER,
  `codLugar` INTEGER,
  PRIMARY KEY (`codMaquina`)
);

CREATE TABLE `auto` (
  `codAuto` INTEGER,
  `placa` CHAR(7),
  `tipo` VARCHAR(20),
  `volumen` INTEGER,
  `color` VARCHAR(10),
  `marca` VARCHAR(20),
  `modelo` VARCHAR(20),
  `codCliente` INTEGER,
  PRIMARY KEY (`codAuto`)
);
        
CREATE TABLE `membresia` (
  `codMembresia` INTEGER,
  `nombre` VARCHAR(30),
  `descripcion` VARCHAR(50),
  `precio` DECIMAL(10,2),
  `duracion` TIME,
  PRIMARY KEY (`codMembresia`)
);

CREATE TABLE `factura` (
  `codFactura` INTEGER,
  `fecha` DATETIME,
  `total` DECIMAL(10,2),
  `metodoPago` CHAR(15),
  `codCita` INTEGER,
  PRIMARY KEY (`codFactura`)
);

CREATE TABLE `lugar` (
  `codLugar` INTEGER,
  `nombre` VARCHAR(30),
  `ubicacion` CHAR(255),
  `funcion` VARCHAR(100),
  `capacidad` INTEGER,
  PRIMARY KEY (`codLugar`)
);
	
CREATE TABLE `servicio_lugar` (
  `codServicio` INTEGER,
  `codLugar` INTEGER,
  `duracion` INTEGER,
  PRIMARY KEY (`codServicio`, `codLugar`)
);
		
CREATE TABLE `horario` (
  `codHorario` INTEGER,
  `fecInicio` DATE,
  `fecFin` DATE,
  `turno` CHAR(10),
  PRIMARY KEY (`codHorario`)
);
	
CREATE TABLE `maquina_empleado` (
  `codMaquina` INTEGER,
  `codEmpleado` INTEGER,
  PRIMARY KEY (`codMaquina`, `codEmpleado`)
);
	
CREATE TABLE `cliente_membresia` (
  `codCliente` INTEGER,
  `codMembresia` INTEGER,
  `fecInicio` DATE,
  `fecFin` DATE,
  `estaActiva` bit,
  PRIMARY KEY (`codCliente`, `codMembresia`)
);

ALTER TABLE `empleado`
ADD FOREIGN KEY (`codHorario`)
REFERENCES `horario` (`codHorario`)
ON DELETE CASCADE;

ALTER TABLE `asistencia`
ADD FOREIGN KEY (`codEmpleado`)
REFERENCES `empleado` (`codEmpleado`)
ON DELETE CASCADE;

ALTER TABLE `cita`
ADD FOREIGN KEY (`codCliente`)
REFERENCES `cliente` (`codCliente`)
ON DELETE CASCADE;

ALTER TABLE `cita`
ADD FOREIGN KEY (`codServicio`)
REFERENCES `servicio` (`codServicio`)
ON DELETE CASCADE;

ALTER TABLE `servicio_utensilio`
ADD FOREIGN KEY (`codServicio`)
REFERENCES `servicio` (`codServicio`)
ON DELETE CASCADE;

ALTER TABLE `servicio_utensilio`
ADD FOREIGN KEY (`codUtensilio`)
REFERENCES `utensilio` (`codUtensilio`)
ON DELETE CASCADE;

ALTER TABLE `proveedor`
ADD FOREIGN KEY (`codRepresentante`)
REFERENCES `representante` (`codRepresentante`)
ON DELETE CASCADE;

ALTER TABLE `proveedor_utensilio`
ADD FOREIGN KEY (`codProveedor`)
REFERENCES `proveedor` (`codProveedor`)
ON DELETE CASCADE;

ALTER TABLE `proveedor_utensilio`
ADD FOREIGN KEY (`codUtensilio`)
REFERENCES `utensilio` (`codUtensilio`)
ON DELETE CASCADE;

ALTER TABLE `maquina`
ADD FOREIGN KEY (`codProveedor`)
REFERENCES `proveedor` (`codProveedor`)
ON DELETE CASCADE;

ALTER TABLE `maquina`
ADD FOREIGN KEY (`codLugar`)
REFERENCES `lugar` (`codLugar`)
ON DELETE CASCADE;

ALTER TABLE `auto`
ADD FOREIGN KEY (`codCliente`)
REFERENCES `cliente` (`codCliente`)
ON DELETE CASCADE;

ALTER TABLE `factura`
ADD FOREIGN KEY (`codCita`)
REFERENCES `cita` (`codCita`)
ON DELETE CASCADE;

ALTER TABLE `servicio_lugar`
ADD FOREIGN KEY (`codServicio`)
REFERENCES `servicio` (`codServicio`)
ON DELETE CASCADE;

ALTER TABLE `servicio_lugar`
ADD FOREIGN KEY (`codLugar`)
REFERENCES `lugar` (`codLugar`)
ON DELETE CASCADE;

ALTER TABLE `maquina_empleado`
ADD FOREIGN KEY (`codMaquina`)
REFERENCES `maquina` (`codMaquina`)
ON DELETE CASCADE;

ALTER TABLE `maquina_empleado`
ADD FOREIGN KEY (`codEmpleado`)
REFERENCES `empleado` (`codEmpleado`)
ON DELETE CASCADE;

ALTER TABLE `cliente_membresia`
ADD FOREIGN KEY (`codCliente`)
REFERENCES `cliente` (`codCliente`)
ON DELETE CASCADE;

ALTER TABLE `cliente_membresia`
ADD FOREIGN KEY (`codMembresia`)
REFERENCES `membresia` (`codMembresia`)
ON DELETE CASCADE;
-- Insertar datos en la tabla horario
INSERT INTO horario (codHorario, fecInicio, fecFin, turno)
VALUES
(1, '2024-02-10', '2024-02-10', 'Mañana'),
(2, '2024-02-10', '2024-02-10', 'Tarde'),
(3, '2024-02-10', '2024-02-10', 'Noche');
-- Insertar datos en la tabla empleado
INSERT INTO empleado (codEmpleado, DNI, nombres, primerApellido, segundoApellido, fecNacimiento, sexo, telefono, correo, direccion, salario, puesto, aniosExperiencia, codHorario)
VALUES
(1, '12345678', 'Juan', 'Pérez', 'Gómez', '1990-05-15', 'Masculino', '123456789', 'juan@example.com', 'Calle Principal 123', 1500.00, 'Recepcionista', 3, 1),
(2, '23456789', 'María', 'García', 'López', '1992-08-20', 'Femenino', '987654321', 'maria@example.com', 'Avenida Central 456', 1800.00, 'Estilista', 5, 2),
(3, '34567890', 'Pedro', 'López', 'Martínez', '1988-03-10', 'Masculino', '567890123', 'pedro@example.com', 'Calle Secundaria 789', 1700.00, 'Lavador', 4, 3),
(4, '45678901', 'Ana', 'Martínez', 'Pérez', '1995-11-25', 'Femenino', '012345678', 'ana@example.com', 'Calle Nueva 234', 1600.00, 'Encargada', 6, 1),
(5, '56789012', 'Carlos', 'Gómez', 'Fernández', '1993-07-18', 'Masculino', '789012345', 'carlos@example.com', 'Avenida Principal 567', 1900.00, 'Masajista', 7, 2);

-- Insertar datos en la tabla cliente
INSERT INTO cliente (codCliente, DNI, nombres, primerApellido, segundoApellido, fecNacimiento, sexo, telefono, correo, direccion, usuario, password)
VALUES
(1, '98765432', 'Laura', 'Hernández', 'Díaz', '1987-12-05', 'Femenino', '654321098', 'laura@example.com', 'Calle Principal 321', 'laura_hd', 'laura123'),
(2, '87654321', 'David', 'Rodríguez', 'Sánchez', '1985-09-18', 'Masculino', '543210987', 'david@example.com', 'Avenida Central 654', 'david_rs', 'david123'),
(3, '76543210', 'Elena', 'Gómez', 'Pérez', '1990-04-30', 'Femenino', '432109876', 'elena@example.com', 'Calle Secundaria 987', 'elena_gp', 'elena123'),
(4, '65432109', 'Sergio', 'Fernández', 'López', '1994-10-15', 'Masculino', '321098765', 'sergio@example.com', 'Avenida Nueva 210', 'sergio_fl', 'sergio123'),
(5, '54321098', 'Carmen', 'Martínez', 'García', '1998-02-20', 'Femenino', '210987654', 'carmen@example.com', 'Calle Principal 876', 'carmen_mg', 'carmen123');

-- Insertar datos en la tabla representante
INSERT INTO representante (codRepresentante, DNI, nombres, primerApellido, segundoApellido, fecNacimiento, sexo, telefono, correo, direccion)
VALUES
(1, '09876543', 'José', 'Fernández', 'Gómez', '1975-06-12', 'Masculino', '901234567', 'jose@example.com', 'Avenida Central 123'),
(2, '10987654', 'Isabel', 'Martínez', 'Rodríguez', '1980-03-25', 'Femenino', '890123456', 'isabel@example.com', 'Calle Nueva 456'),
(3, '21098765', 'Antonio', 'López', 'Sánchez', '1978-11-08', 'Masculino', '789012345', 'antonio@example.com', 'Calle Secundaria 789'),
(4, '32109876', 'Ana', 'García', 'Pérez', '1983-07-23', 'Femenino', '678901234', 'ana@example.com', 'Avenida Principal 234'),
(5, '43210987', 'Miguel', 'Hernández', 'Martínez', '1970-12-30', 'Masculino', '567890123', 'miguel@example.com', 'Avenida Nueva 567');

-- Insertar datos en la tabla asistencia
INSERT INTO asistencia (codAsistencia, fecha, horaEntrada, horaSalida, codEmpleado)
VALUES
(1, '2024-02-10', '08:00:00', '17:00:00', 1),
(2, '2024-02-10', '09:00:00', '18:00:00', 2),
(3, '2024-02-10', '10:00:00', '19:00:00', 3),
(4, '2024-02-10', '11:00:00', '20:00:00', 4),
(5, '2024-02-10', '12:00:00', '21:00:00', 5);
-- Insertar datos en la tabla servicio
INSERT INTO servicio (codServicio, nombre, precio, duracion, descripcion, url_imagen)
VALUES
(1, 'Corte de cabello', 20.00, '01:00:00','fdsf','sdsd'),
(2, 'Lavado de cabello', 15.00, '00:30:00','qwe','sdadsa'),
(3, 'Masaje relajante', 30.00, '01:30:00','adsad','asdsad'),
(4, 'Manicura', 25.00, '01:00:00','sadas','dasdsa'),
(5, 'Pedicura', 25.00, '01:00:00','asdsa','asdasd');

-- Insertar datos en la tabla cita
INSERT INTO cita (codCita, fecha, hora, progreso, codCliente, codServicio)
VALUES
(1, '2024-02-10', '08:30:00', 'En progreso', 1, 1),
(2, '2024-02-10', '09:30:00', 'En espera', 2, 2),
(3, '2024-02-10', '10:30:00', 'Completada', 3, 3),
(4, '2024-02-10', '11:30:00', 'En progreso', 4, 4),
(5, '2024-02-10', '12:30:00', 'En espera', 5, 5);

-- Insertar datos en la tabla utensilio
INSERT INTO utensilio (codUtensilio, nombre, descripcion, precio, cantidad, unidad)
VALUES
(1, 'Escoba', 'Para limpieza', 10.00, 20, 'Uni'),
(2, 'Detergente', 'Para lavado', 15.00, 15, 'Lo'),
(3, 'Toallas', 'Para secado', 8.00, 30, 'Uni'),
(4, 'Guantes', 'Para protección', 12.00, 25, 'Par'),
(5, 'Cubeta', 'Para agua', 7.00, 10, 'Uni');


-- Insertar datos en la tabla servicio_utensilio
INSERT INTO servicio_utensilio (codServicio, codUtensilio, cantidad)
VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 2),
(4, 4, 1),
(5, 5, 1);

-- Insertar datos en la tabla proveedor
INSERT INTO proveedor (codProveedor, nombre, telefono, direccion, codRepresentante)
VALUES
(1, 'Proveedor A', '123456789', 'Calle Principal 123', 1),
(2, 'Proveedor B', '234567890', 'Avenida Central 456', 2),
(3, 'Proveedor C', '345678901', 'Calle Secundaria 789', 3),
(4, 'Proveedor D', '456789012', 'Avenida Nueva 123', 4),
(5, 'Proveedor E', '567890123', 'Calle Principal 456', 5);

-- Insertar datos en la tabla proveedor_utensilio
INSERT INTO proveedor_utensilio (codProveedor, codUtensilio, fecha, cantidad, total)
VALUES
(1, 1, '2024-02-10 10:00:00', 5, 50.00),
(2, 2, '2024-02-10 11:00:00', 3, 45.00),
(3, 3, '2024-02-10 12:00:00', 4, 32.00),
(4, 4, '2024-02-10 13:00:00', 2, 24.00),
(5, 5, '2024-02-10 14:00:00', 1, 7.00);
-- Insertar datos en la tabla lugar
INSERT INTO lugar (codLugar, nombre, ubicacion, funcion, capacidad)
VALUES
(1, 'Salón principal', 'U', 'Salón de espera', 50),
(2, 'Área de lavado', 'U', 'Área de lavado de cabello', 30),
(3, 'Sala de masajes', 'U', 'Sala de masajes terapéuticos', 20),
(4, 'Área de manicura', 'U', 'Área de manicura y pedicura', 15),
(5, 'Zona de estacionamiento', '', 'Zona de estacionamiento de clientes', 50);
-- Insertar datos en la tabla maquina
INSERT INTO maquina (codMaquina, nombre, marca, funcion, precio, estaOperativa, codProveedor, codLugar)
VALUES
(1, 'Máquina 1', 'Marca A', 'Función A', 1000.00, 1, 1, 1),
(2, 'Máquina 2', 'Marca B', 'Función B', 1200.00, 0, 2, 2),
(3, 'Máquina 3', 'Marca C', 'Función C', 1500.00, 1, 3, 3),
(4, 'Máquina 4', 'Marca D', 'Función D', 1800.00, 0, 4, 4),
(5, 'Máquina 5', 'Marca E', 'Función E', 2000.00, 1, 5, 5);

-- Insertar datos en la tabla auto
INSERT INTO auto (codAuto, placa, tipo, volumen, color, marca, modelo, codCliente)
VALUES
(1, 'ABC123', 'Sedán', 4, 'Rojo', 'Toyota', 'Corolla', 1),
(2, 'DEF456', 'Camioneta', 8, 'Negro', 'Ford', 'Explorer', 2),
(3, 'GHI789', 'Hatchback', 3, 'Azul', 'Volkswagen', 'Golf', 3),
(4, 'JKL012', 'SUV', 6, 'Blanco', 'Honda', 'CR-V', 4),
(5, 'MNO345', 'Coupé', 2, 'Gris', 'Chevrolet', 'Camaro', 5);

-- Insertar datos en la tabla membresia
INSERT INTO membresia (codMembresia, nombre, descripcion, precio, duracion)
VALUES
(1, 'Membresía Bronce', 'Membresía básica', 50.00, '01:00:00'),
(2, 'Membresía Plata', 'Membresía estándar', 75.00, '02:00:00'),
(3, 'Membresía Oro', 'Membresía premium', 100.00, '03:00:00'),
(4, 'Membresía Diamante', 'Membresía de lujo', 150.00, '04:00:00'),
(5, 'Membresía VIP', 'Membresía exclusiva', 200.00, '05:00:00');

-- Insertar datos en la tabla factura
INSERT INTO factura (codFactura, fecha, total, metodoPago, codCita)
VALUES
(1, '2024-02-10 08:30:00', 20.00, 'Efectivo', 1),
(2, '2024-02-10 09:30:00', 15.00, 'Tarjeta', 2),
(3, '2024-02-10 10:30:00', 30.00, 'Efectivo', 3),
(4, '2024-02-10 11:30:00', 25.00, 'Tarjeta', 4),
(5, '2024-02-10 12:30:00', 25.00, 'Efectivo', 5);



-- Insertar datos en la tabla servicio_lugar
INSERT INTO servicio_lugar (codServicio, codLugar, duracion)
VALUES
(1, 1, 60),
(2, 2, 30),
(3, 3, 90),
(4, 4, 60),
(5, 5, 60);

INSERT INTO `cliente` (`codCliente`, `DNI`, `nombres`, `primerApellido`, `segundoApellido`, `fecNacimiento`, `sexo`, `telefono`, `correo`, `direccion`, `usuario`, `password`) 
VALUES (666, 666666, 'Juan', 'Pérez', 'González', '1990-05-15', 'Masculino', '123456789', 'juan@example.com', 'Calle Principal 123', 'admin', 'admin');


