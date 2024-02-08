DROP DATABASE IF EXISTS carwash;
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
  `ubicacion` CHAR(5),
  `funcion` VARCHAR(30),
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

ALTER TABLE `empleado` ADD FOREIGN KEY (codHorario) REFERENCES `horario` (`codHorario`);
ALTER TABLE `asistencia` ADD FOREIGN KEY (codEmpleado) REFERENCES `empleado` (`codEmpleado`);
ALTER TABLE `cita` ADD FOREIGN KEY (codCliente) REFERENCES `cliente` (`codCliente`);
ALTER TABLE `cita` ADD FOREIGN KEY (codServicio) REFERENCES `servicio` (`codServicio`);
ALTER TABLE `servicio_utensilio` ADD FOREIGN KEY (codServicio) REFERENCES `servicio` (`codServicio`);
ALTER TABLE `servicio_utensilio` ADD FOREIGN KEY (codUtensilio) REFERENCES `utensilio` (`codUtensilio`);
ALTER TABLE `proveedor` ADD FOREIGN KEY (codRepresentante) REFERENCES `representante` (`codRepresentante`);
ALTER TABLE `proveedor_utensilio` ADD FOREIGN KEY (codProveedor) REFERENCES `proveedor` (`codProveedor`);
ALTER TABLE `proveedor_utensilio` ADD FOREIGN KEY (codUtensilio) REFERENCES `utensilio` (`codUtensilio`);
ALTER TABLE `maquina` ADD FOREIGN KEY (codProveedor) REFERENCES `proveedor` (`codProveedor`);
ALTER TABLE `maquina` ADD FOREIGN KEY (codLugar) REFERENCES `lugar` (`codLugar`);
ALTER TABLE `auto` ADD FOREIGN KEY (codCliente) REFERENCES `cliente` (`codCliente`);
ALTER TABLE `factura` ADD FOREIGN KEY (codCita) REFERENCES `cita` (`codCita`);
ALTER TABLE `servicio_lugar` ADD FOREIGN KEY (codServicio) REFERENCES `servicio` (`codServicio`);
ALTER TABLE `servicio_lugar` ADD FOREIGN KEY (codLugar) REFERENCES `lugar` (`codLugar`);
ALTER TABLE `maquina_empleado` ADD FOREIGN KEY (codMaquina) REFERENCES `maquina` (`codMaquina`);
ALTER TABLE `maquina_empleado` ADD FOREIGN KEY (codEmpleado) REFERENCES `empleado` (`codEmpleado`);
ALTER TABLE `cliente_membresia` ADD FOREIGN KEY (codCliente) REFERENCES `cliente` (`codCliente`);
ALTER TABLE `cliente_membresia` ADD FOREIGN KEY (codMembresia) REFERENCES `membresia` (`codMembresia`);
