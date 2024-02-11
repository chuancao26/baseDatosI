use carwash;
INSERT INTO auto (codAuto, placa, tipo, volumen, color, marca, modelo, codCliente) 
VALUES 
(1, 'ABC123', 'Sedán', 2000, 'Azul', 'Toyota', 'Corolla', -3901),
(2, 'XYZ789', 'Camioneta', 2500, 'Negro', 'Ford', 'Explorer', -3901),
(3, 'DEF456', 'Hatchback', 1800, 'Rojo', 'Honda', 'Civic', -3901);
select * from auto;
INSERT INTO membresia (codMembresia, nombre, descripcion, precio, duracion) 
VALUES 
(1, 'Básica', 'Lavado exterior', 10.00, '1:00:00'),
(2, 'Estándar', 'Lavado exterior e interior', 20.00, '2:00:00'),
(3, 'Premium', 'Lavado exterior e interior con encerado', 30.00, '3:00:00');
select * from membresia;
INSERT INTO cliente_membresia (codCliente, codMembresia, fecInicio, fecFin, estaActiva) 
VALUES 
(-3901, 1, '2024-01-01', '2024-12-31', 1);
select * from cliente_membresia;
INSERT INTO servicio (codServicio, nombre, precio, duracion) 
VALUES 
(1, 'Lavado exterior', 15.00, '0:30:00'),
(2, 'Lavado interior', 20.00, '0:45:00'),
(3, 'Encerado', 25.00, '1:00:00'),
(4, 'Aspirado', 10.00, '0:15:00'),
(5, 'Lavado de motor', 30.00, '0:45:00'),
(6, 'Desinfección', 25.00, '0:30:00'),
(7, 'Lavado de llantas', 10.00, '0:20:00'),
(8, 'Lavado de tapicería', 40.00, '1:30:00'),
(9, 'Pulido de faros', 15.00, '0:30:00'),
(10, 'Tratamiento de pintura', 50.00, '2:00:00');
select * from servicio;

select * from auto join cliente on auto.codCliente = cliente.codCliente where cliente.DNI = '123'
