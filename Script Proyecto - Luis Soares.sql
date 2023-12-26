/*
Base de datos utilizada para gestionar las ventas de 
un supermercado a traves del registro de facturas 
*/

-- CREACION DE TABLAS 

-- creacion de base de datos
DROP SCHEMA IF EXISTS ventas_supermercado;
CREATE SCHEMA ventas_supermercado;
USE ventas_supermercado;

-- Proveedores (tabla donde se registrarán todos los proveedores que le suministren mercancía al supermercado)
CREATE TABLE proveedores (
    proveedor_id INT PRIMARY KEY,
    nombre VARCHAR(255),
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    email VARCHAR(255)
);

-- Clientes (tabla donde se registrán todos los nuevos clientes que realicen compras en cualquiera de las sucursales)
CREATE TABLE Clientes (
    cliente_id INT PRIMARY KEY,
    nombre VARCHAR(255),
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    email VARCHAR(255)
);

-- Productos (tabla donde se registrarán todos los productos en inventario)
CREATE TABLE productos (
    producto_id INT PRIMARY KEY,
    nombre VARCHAR(255),
    precio DECIMAL(10,2),
    stock INT,
    proveedor_id INT,
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(proveedor_id)
);

-- Supervisores (tabla donde se registrarán los supervisores activos encargados de grupos de 5 vendedores, no necesariamnete de la misma sucurdsal)
CREATE TABLE supervisores (
    supervisor_id INT PRIMARY KEY,
    nombre VARCHAR(255)
);

-- Sucursales (tabla donde se registrarán las sucursales que operan en los diferentes territorios)
CREATE TABLE Sucursales (
    sucursal_id INT PRIMARY KEY,
    nombre VARCHAR(255),
    direccion VARCHAR(255),
    supervisor_id INT,
    FOREIGN KEY (supervisor_id) REFERENCES Supervisores(supervisor_id)
);

-- Vendedores (tabla donde se registrarán los vendedores activos en cada una de las sucursales)
CREATE TABLE Vendedores (
    vendedor_id INT PRIMARY KEY,
    nombre VARCHAR(255),
    supervisor_id INT,
    sucursal_id INT,
    FOREIGN KEY (supervisor_id) REFERENCES Supervisores(supervisor_id),
    FOREIGN KEY (sucursal_id) REFERENCES Sucursales(sucursal_id)
);

-- Facturas (tabla donde se registrarán todas las trasancciones de venta que se realicen)
CREATE TABLE Facturas (
    factura_id INT PRIMARY KEY,
    fecha DATE,
    total DECIMAL (10, 2),
    cliente_id INT,
    vendedor_id INT,
    sucursal_id INT,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
    FOREIGN KEY (vendedor_id) REFERENCES Vendedores(vendedor_id),
    FOREIGN KEY (sucursal_id) REFERENCES Sucursales(sucursal_id)
    );

 
-- Evaluaciones (tabla donde se registrarán las evaluaciones de desempeño que realizan los supervisores sobre los vendedores)
CREATE TABLE Evaluaciones (
    evaluacion_id INT AUTO_INCREMENT PRIMARY KEY,
    supervisor_id INT,
    vendedor_id INT,
    fecha_evaluacion DATE,
    puntaje INT,
    comentario TEXT,
    FOREIGN KEY (supervisor_id) REFERENCES Supervisores(supervisor_id),
    FOREIGN KEY (vendedor_id) REFERENCES Vendedores(vendedor_id)
);

-- Valoraciones de Sucursales 
CREATE TABLE Valoraciones_sucursales (
    valoracion_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    sucursal_id INT,
    variedad_productos INT,
    atencion_cliente INT,
    limpieza_orden INT,
    precios_ofertas INT,
    experiencia_compra INT,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
    FOREIGN KEY (sucursal_id) REFERENCES Sucursales(sucursal_id)
);


-- INSERCION DE DATOS


-- Insertar Proveedores
INSERT INTO Proveedores (proveedor_id, nombre, direccion, telefono, email) VALUES
(1, 'Sabores del Caribe C.A.', 'Av. Playa Azul, Caracas', '0212-1234567', 'ventas@saborescaribe.com'),
(2, 'Aromas del Valle', 'Calle Bella Vista, Barcelona', '0212-2345678', 'ventas@aromasvalle.com'),
(3, 'Delicias del Sur Mayorista', 'Av. Tropical, Valencia', '0212-3456789', 'ventas@deliciassur.com'),
(4, 'Gourmet Galleria', 'Calle de las Delicias, Maracaibo', '0212-4567890', 'ventas@gourmetgalleria.com'),
(5, 'Mar y Tierra Distribuciones', 'Av. Palmeras, Barquisimeto', '0212-5678901', 'ventas@marytierradist.com'),
(6, 'Sabor y Estilo Gastronómico', 'Calle Sibarita, La Asunción', '0212-6789012', 'ventas@saboryestilogastro.com'),
(7, 'Exquisiteces del Caribe', 'Av. del Sol, Maracaibo', '0212-7890123', 'ventas@exquisitecescaribe.com'),
(8, 'Estrellas del Sabor', 'Carrera del Gusto, Valencia', '0212-8901234', 'ventas@estrellasabor.com'),
(9, 'Sabores Tropicales Mayorista', 'Calle del Coco, Barcelona', '0212-9012345', 'ventas@saborestropicalesmayorista.com'),
(10, 'Frescos del Edén', 'Av. de las Frutas, Caracas', '0212-0123456', 'ventas@frescoseden.com'),
(11, 'Tradición Culinary Delights', 'Av. de las Especias, Valencia', '0212-1234567', 'ventas@tradicionculinarydelights.com'),
(12, 'Nacionales e Importados Selectos', 'Av. de los Sabores, Barquisimeto', '0212-2345678', 'ventas@nacionalesimportados.com'),
(13, 'Gastronomía del Mundo', 'Calle Sibarita, La Asunción', '0212-3456789', 'ventas@gastronomiadelmundo.com'),
(14, 'Delicias del Caribe Mayorista', 'Av. del Sabor, Caracas', '0212-4567890', 'ventas@deliciasdelcaribemayorista.com'),
(15, 'Sabores de la Tierra y el Mar', 'Calle Aromática, Maracaibo', '0212-5678901', 'ventas@saborestierraymar.com'),
(16, 'Suministros del Sur Selectos', 'Av. de las Especias, Valencia', '0212-6789012', 'ventas@suministrosdelsur.com'),
(17, 'Productos Mediterráneos Gourmet', 'Carrera del Sabor, Barcelona', '0212-7890123', 'ventas@mediterraneosgourmet.com'),
(18, 'Estrella del Caribe Mayorista', 'Av. de los Sabores, Caracas', '0212-8901234', 'ventas@estrelladelcaribemayorista.com'),
(19, 'Tradición Venezolana Delicatessen', 'Av. de las Delicias, Barquisimeto', '0212-9012345', 'ventas@tradicionvenezolanadelicatessen.com'),
(20, 'Gourmet del Este Exclusivo', 'Av. de las Esencias, Valencia', '0212-0123456', 'ventas@gourmetdeleste.com'),
(21, 'Delicias Tropicales Distribuciones', 'Calle Especiada, Barcelona', '0212-1234567', 'ventas@deliciastropicalesdist.com'),
(22, 'Suministros del Caribe C.A.', 'Av. de las Esencias, Caracas', '0212-2345678', 'ventas@suministroscaribe.com'),
(23, 'Frescos del Sur Mayorista', 'Carrera del Sabor, Maracaibo', '0212-3456789', 'ventas@frescosdelmundo.com'),
(24, 'Marítima del Sabor', 'Calle del Gusto, Valencia', '0212-4567890', 'ventas@maritimadelsabor.com'),
(25, 'Mayorista de Sabores Exóticos', 'Av. de los Sabores, Barquisimeto', '0212-5678901', 'ventas@mayoristadesabores.com'),
(26, 'Sabor del Caribe Selecto', 'Calle de las Especias, La Asunción', '0212-6789012', 'ventas@sabordelcaribeselecto.com'),
(27, 'Distribuidora de Delicias Gourmet', 'Av. de los Sabores, Maracaibo', '0212-7890123', 'ventas@distribuidoradedelicias.com'),
(28, 'Estrella del Sur Selectos', 'Carrera del Sabor, Valencia', '0212-8901234', 'ventas@estrelladelsurselectos.com'),
(29, 'Gourmet del Este Exclusivo', 'Av. de las Delicias, Maracaibo', '0212-9012345', 'ventas@gourmetdelesteexclusivo.com'),
(30, 'Tradición Gourmet del Caribe', 'Calle Especiada, Valencia', '0212-0123456', 'ventas@tradiciongourmetdelcaribe.com');


-- Insertar Clientes
INSERT INTO Clientes (cliente_id, nombre, direccion, telefono, email) VALUES
(1, 'Elena Martínez', 'Calle Primavera, Caracas', '0412-1234567', 'elena.martinez@example.com'),
(2, 'Carlos Rivas', 'Av. del Sol, Barcelona', '0424-2345678', 'carlos.rivas@example.com'),
(3, 'Luisa Pérez', 'Carrera 20, Valencia', '0412-3456789', 'luisa.perez@example.com'),
(4, 'Pedro González', 'Av. Libertador, Maracaibo', '0424-4567890', 'pedro.gonzalez@example.com'),
(5, 'María Rodríguez', 'Calle Mayor, Barquisimeto', '0412-5678901', 'maria.rodriguez@example.com'),
(6, 'Juan Martínez', 'Av. Universidad, La Asunción', '0424-6789012', 'juan.martinez@example.com'),
(7, 'Carmen López', 'Calle Bolívar, Caracas', '0412-7890123', 'carmen.lopez@example.com'),
(8, 'Javier Hernández', 'Carrera del Este, Valencia', '0424-8901234', 'javier.hernandez@example.com'),
(9, 'Isabella Gómez', 'Av. Principal, Barcelona', '0412-9012345', 'isabella.gomez@example.com'),
(10, 'Miguel Sánchez', 'Calle del Carmen, Maracaibo', '0424-0123456', 'miguel.sanchez@example.com'),
(11, 'Ana Díaz', 'Calle del Sol, Barquisimeto', '0412-1234567', 'ana.diaz@example.com'),
(12, 'Diego Ramírez', 'Av. de las Flores, Caracas', '0424-2345678', 'diego.ramirez@example.com'),
(13, 'Lucía Fernández', 'Carrera del Sur, Valencia', '0412-3456789', 'lucia.fernandez@example.com'),
(14, 'Manuel Pérez', 'Av. del Este, Barcelona', '0424-4567890', 'manuel.perez@example.com'),
(15, 'Sofía González', 'Calle Principal, Maracaibo', '0412-5678901', 'sofia.gonzalez@example.com'),
(16, 'David Martínez', 'Av. de los Sueños, La Asunción', '0424-6789012', 'david.martinez@example.com'),
(17, 'Valentina Sánchez', 'Av. del Sol, Caracas', '0412-7890123', 'valentina.sanchez@example.com'),
(18, 'Mateo Gómez', 'Calle de los Sueños, Valencia', '0424-8901234', 'mateo.gomez@example.com'),
(19, 'Camila Hernández', 'Carrera de los Deseos, Barcelona', '0412-9012345', 'camila.hernandez@example.com'),
(20, 'Daniel Díaz', 'Av. de los Sueños, Maracaibo', '0424-0123456', 'daniel.diaz@example.com'),
(21, 'Paula López', 'Calle de los Deseos, Barquisimeto', '0412-1234567', 'paula.lopez@example.com'),
(22, 'Joaquín Ramírez', 'Av. del Sol, Caracas', '0424-2345678', 'joaquin.ramirez@example.com'),
(23, 'Emma Martínez', 'Carrera del Este, Valencia', '0412-3456789', 'emma.martinez@example.com'),
(24, 'Santiago Sánchez', 'Av. Principal, Barcelona', '0424-4567890', 'santiago.sanchez@example.com'),
(25, 'Olivia Gómez', 'Calle del Carmen, Maracaibo', '0412-5678901', 'olivia.gomez@example.com'),
(26, 'Lucas Pérez', 'Calle del Sol, Barquisimeto', '0424-6789012', 'lucas.perez@example.com'),
(27, 'Amelia González', 'Av. de las Flores, Caracas', '0412-7890123', 'amelia.gonzalez@example.com'),
(28, 'Matías Ramírez', 'Av. de las Flores, Valencia', '0424-8901234', 'matias.ramirez@example.com'),
(29, 'Emma Díaz', 'Calle del Este, Maracaibo', '0412-9012345', 'emma.diaz@example.com'),
(30, 'Tomás Martínez', 'Av. del Sol, Barquisimeto', '0424-0123456', 'tomas.martinez@example.com'),
(31, 'Laura Rodríguez', 'Av. de las Estrellas, Maracaibo', '0412-2345678', 'laura.rodriguez@example.com'),
(32, 'Mateo Martínez', 'Calle del Sabor, Barquisimeto', '0424-3456789', 'mateo.martinez@example.com'),
(33, 'Sofía Pérez', 'Av. de los Sueños, Valencia', '0412-4567890', 'sofia.perez@example.com'),
(34, 'Luis González', 'Carrera del Este, Barcelona', '0424-5678901', 'luis.gonzalez@example.com'),
(35, 'Valentina Sánchez', 'Av. Principal, Maracaibo', '0412-6789012', 'valentina.sanchez@example.com'),
(36, 'Diego Martínez', 'Calle de las Estrellas, La Asunción', '0424-7890123', 'diego.martinez@example.com'),
(37, 'Mía González', 'Av. de las Delicias, Caracas', '0412-8901234', 'mia.gonzalez@example.com'),
(38, 'Lucas Pérez', 'Av. del Este, Valencia', '0424-9012345', 'lucas.perez@example.com'),
(39, 'Isabella Díaz', 'Calle del Sol, Maracaibo', '0412-0123456', 'isabella.diaz@example.com'),
(40, 'Joaquín López', 'Calle de los Sueños, Barquisimeto', '0424-1234567', 'joaquin.lopez@example.com'),
(41, 'Emma Ramírez', 'Av. de los Deseos, Caracas', '0412-2345678', 'emma.ramirez@example.com'),
(42, 'Santiago Sánchez', 'Carrera de las Delicias, Valencia', '0424-3456789', 'santiago.sanchez@example.com'),
(43, 'Olivia Martínez', 'Av. del Sol, Barcelona', '0412-4567890', 'olivia.martinez@example.com'),
(44, 'Lucas Rodríguez', 'Av. de las Estrellas, Maracaibo', '0424-5678901', 'lucas.rodriguez@example.com'),
(45, 'Valentina Díaz', 'Calle de las Delicias, Barquisimeto', '0412-6789012', 'valentina.diaz@example.com'),
(46, 'Mateo Pérez', 'Calle del Este, La Asunción', '0424-7890123', 'mateo.perez@example.com'),
(47, 'Sofía López', 'Av. del Sol, Maracaibo', '0412-8901234', 'sofia.lopez@example.com'),
(48, 'Diego Ramírez', 'Av. de los Deseos, Valencia', '0424-9012345', 'diego.ramirez@example.com'),
(49, 'Mía González', 'Carrera de las Delicias, Caracas', '0412-0123456', 'mia.gonzalez@example.com'),
(50, 'Lucas Martínez', 'Av. de las Estrellas, Barcelona', '0424-1234567', 'lucas.martinez@example.com'),
(51, 'Valentina Pérez', 'Av. de las Delicias, Maracaibo', '0412-2345678', 'valentina.perez@example.com'),
(52, 'Mateo López', 'Calle del Sol, Barquisimeto', '0424-3456789', 'mateo.lopez@example.com'),
(53, 'Sofía Ramírez', 'Av. del Este, La Asunción', '0412-4567890', 'sofia.ramirez@example.com'),
(54, 'Luis Martínez', 'Av. de los Sueños, Caracas', '0424-5678901', 'luis.martinez@example.com'),
(55, 'Valentina Díaz', 'Carrera del Este, Valencia', '0412-6789012', 'valentina.diaz@example.com'),
(56, 'Diego Sánchez', 'Calle de los Sueños, Barcelona', '0424-7890123', 'diego.sanchez@example.com'),
(57, 'Olivia López', 'Av. del Sol, Maracaibo', '0412-8901234', 'olivia.lopez@example.com'),
(58, 'Lucas Ramírez', 'Av. de las Delicias, Maracaibo', '0424-9012345', 'lucas.ramirez@example.com'),
(59, 'Sofía Díaz', 'Carrera de las Delicias, Valencia', '0412-0123456', 'sofia.diaz@example.com'),
(60, 'Mía Pérez', 'Av. de las Estrellas, Barcelona', '0424-1234567', 'mia.perez@example.com');

-- Insertar Productos
INSERT INTO Productos (producto_id, nombre, precio, stock, proveedor_id) VALUES
(1, 'Arroz', 2.50, 100, 1),
(2, 'Frijoles', 1.80, 150, 2),
(3, 'Leche', 3.20, 200, 3),
(4, 'Huevos', 1.50, 180, 4),
(5, 'Salsa de soja', 2.30, 120, 5),
(6, 'Pasta', 1.20, 160, 6),
(7, 'Aceite de cocina', 3.00, 120, 7),
(8, 'Pan', 2.00, 180, 8),
(9, 'Pollo', 5.00, 90, 9),
(10, 'Carne de res', 8.00, 60, 10),
(11, 'Pescado', 6.50, 70, 11),
(12, 'Harina de trigo', 2.30, 130, 12),
(13, 'Azúcar', 1.80, 140, 13),
(14, 'Sal', 0.90, 190, 14),
(15, 'Café', 4.50, 110, 15),
(16, 'Refresco', 1.80, 200, 16),
(17, 'Galletas', 1.50, 170, 17),
(18, 'Chocolate', 2.50, 140, 18),
(19, 'Mermelada', 2.00, 160, 19),
(20, 'Salsa de tomate', 1.50, 180, 20),
(21, 'Té', 3.00, 140, 21),
(22, 'Yogur', 2.00, 160, 22),
(23, 'Queso', 4.50, 90, 23),
(24, 'Mantequilla', 2.20, 120, 24),
(25, 'Jugos', 2.50, 130, 25),
(26, 'Helado', 3.00, 70, 26),
(27, 'Vino', 6.00, 60, 27),
(28, 'Papas fritas', 1.80, 190, 28),
(29, 'Agua mineral', 1.00, 200, 29),
(30, 'Cerveza', 3.50, 80, 30);

-- Insertar Supervisores
INSERT INTO Supervisores (supervisor_id, nombre) VALUES
(1, 'Juan Pérez'),
(2, 'María González'),
(3, 'Carlos Martínez'),
(4, 'Laura Rodríguez'),
(5, 'Pedro Sánchez'),
(6, 'Ana López');


-- Insertar Sucursales 
INSERT INTO Sucursales (sucursal_id, nombre, direccion, supervisor_id) VALUES
(1, 'Caracas', 'Dirección Caracas', 1),
(2, 'Barcelona', 'Dirección Barcelona', 2),
(3, 'Valencia', 'Dirección Valencia', 3),
(4, 'Maracaibo', 'Dirección Maracaibo', 4),
(5, 'Barquisimeto', 'Dirección Barquisimeto', 5),
(6, 'Nueva Esparta', 'Dirección Nueva Esparta', 6);


-- Insertar vendedores de la sucursal Caracas
INSERT INTO Vendedores (vendedor_id, nombre, sucursal_id, supervisor_id) VALUES
(1, 'Juan Pérez', 1, 1),
(2, 'María González', 1, 1),
(3, 'Luis Rodríguez', 1, 1),
(4, 'Ana Martínez', 1, 1),
(5, 'Carlos Gómez', 1, 1);

-- Insertar vendedores de la sucursal Barcelona
INSERT INTO Vendedores (vendedor_id, nombre, sucursal_id, supervisor_id) VALUES
(6, 'Pedro López', 2, 2),
(7, 'Laura Sánchez', 2, 2),
(8, 'José García', 2, 2),
(9, 'Marta Díaz', 2, 2),
(10, 'David Fernández', 2, 2);

-- Insertar vendedores de la sucursal Valencia
INSERT INTO Vendedores (vendedor_id, nombre, sucursal_id, supervisor_id) VALUES
(11, 'Sandra Pérez', 3, 3),
(12, 'Ricardo Gómez', 3, 3),
(13, 'Carmen Martínez', 3, 3),
(14, 'Javier Rodríguez', 3, 3),
(15, 'Patricia López', 3, 3);

-- Insertar vendedores de la sucursal Maracaibo
INSERT INTO Vendedores (vendedor_id, nombre, sucursal_id, supervisor_id) VALUES
(16, 'Alejandro Fernández', 4, 4),
(17, 'Silvia Sánchez', 4, 4),
(18, 'Diego González', 4, 4),
(19, 'Isabel Díaz', 4, 4),
(20, 'Manuel Pérez', 4, 4);

-- Insertar vendedores de la sucursal Barquisimeto
INSERT INTO Vendedores (vendedor_id, nombre, sucursal_id, supervisor_id) VALUES
(21, 'Eduardo Rodríguez', 5, 5),
(22, 'Olga Martínez', 5, 5),
(23, 'Raúl López', 5, 5),
(24, 'Luisa Sánchez', 5, 5),
(25, 'Fernando Gómez', 5, 5);

-- Insertar vendedores de la sucursal Nueva Esparta
INSERT INTO Vendedores (vendedor_id, nombre, sucursal_id, supervisor_id) VALUES
(26, 'Mario Pérez', 6, 6),
(27, 'Laura González', 6, 6),
(28, 'Carlos Díaz', 6, 6),
(29, 'Mónica Rodríguez', 6, 6),
(30, 'Roberto Gómez', 6, 6);

-- Insertar facturas 
INSERT INTO Facturas (factura_id, fecha, total, vendedor_id, cliente_id, sucursal_id) VALUES
(1, '2023-11-01', 150.00, 1, 1, 1),
(2, '2023-11-02', 120.50, 2, 2, 2),
(3, '2023-11-03', 200.25, 3, 3, 3),
(4, '2023-11-04', 80.75, 4, 4, 4),
(5, '2023-11-05', 90.60, 5, 5, 5),
(6, '2023-11-06', 175.30, 6, 6, 6),
(7, '2023-11-07', 130.20, 7, 7, 1),
(8, '2023-11-08', 190.75, 8, 8, 2),
(9, '2023-11-09', 110.50, 9, 9, 3),
(10, '2023-11-10', 95.00, 10, 10, 4),
(11, '2023-11-11', 160.80, 11, 11, 5),
(12, '2023-11-12', 140.25, 12, 12, 6),
(13, '2023-11-13', 75.90, 13, 13, 1),
(14, '2023-11-14', 105.60, 14, 14, 2),
(15, '2023-11-15', 200.40, 15, 15, 3),
(16, '2023-11-16', 170.30, 16, 16, 4),
(17, '2023-11-17', 90.25, 17, 17, 5),
(18, '2023-11-18', 110.80, 18, 18, 6),
(19, '2023-11-19', 130.50, 19, 19, 1),
(20, '2023-11-20', 180.70, 20, 20, 2),
(21, '2023-11-21', 95.40, 21, 21, 3),
(22, '2023-11-22', 75.60, 22, 22, 4),
(23, '2023-11-23', 160.25, 23, 23, 5),
(24, '2023-11-24', 190.90, 24, 24, 6),
(25, '2023-11-25', 120.80, 25, 25, 1),
(26, '2023-11-26', 140.00, 26, 26, 2),
(27, '2023-11-27', 185.60, 27, 27, 3),
(28, '2023-11-28', 95.75, 28, 28, 4),
(29, '2023-11-29', 110.30, 29, 29, 5),
(30, '2023-11-30', 170.20, 30, 30, 6),
(31, '2023-12-01', 120.50, 1, 31, 1),
(32, '2023-12-02', 155.25, 2, 32, 2),
(33, '2023-12-03', 200.40, 3, 33, 3),
(34, '2023-12-04', 85.60, 4, 34, 4),
(35, '2023-12-05', 90.75, 5, 35, 5),
(36, '2023-12-06', 160.30, 6, 36, 6),
(37, '2023-12-07', 135.25, 7, 37, 1),
(38, '2023-12-08', 105.80, 8, 38, 2),
(39, '2023-12-09', 190.50, 9, 39, 3),
(40, '2023-12-10', 110.70, 10, 1, 4),
(41, '2023-12-11', 150.90, 11, 2, 5),
(42, '2023-12-12', 120.80, 12, 3, 6),
(43, '2023-12-13', 180.00, 13, 4, 1),
(44, '2023-12-14', 140.20, 14, 5, 2),
(45, '2023-12-15', 95.40, 15, 6, 3),
(46, '2023-12-16', 160.30, 16, 7, 4),
(47, '2023-12-17', 120.25, 17, 8, 5),
(48, '2023-12-18', 110.50, 18, 9, 6),
(49, '2023-12-19', 190.75, 19, 10, 1),
(50, '2023-12-20', 200.90, 20, 11, 2),
(51, '2023-12-21', 130.80, 21, 12, 3),
(52, '2023-12-22', 90.60, 22, 13, 4),
(53, '2023-12-23', 140.25, 23, 14, 5),
(54, '2023-12-24', 155.60, 24, 15, 6),
(55, '2023-12-25', 75.90, 25, 16, 1),
(56, '2023-12-26', 130.60, 26, 17, 2),
(57, '2023-12-27', 190.20, 27, 18, 3),
(58, '2023-12-28', 110.90, 28, 19, 4),
(59, '2023-12-29', 150.80, 29, 20, 5),
(60, '2023-12-30', 135.75, 30, 21, 6),
(61, '2024-01-01', 170.40, 1, 22, 1),
(62, '2024-01-02', 120.50, 2, 23, 2),
(63, '2024-01-03', 155.60, 3, 24, 3),
(64, '2024-01-04', 90.75, 4, 25, 4),
(65, '2024-01-05', 200.20, 5, 26, 5),
(66, '2024-01-06', 140.30, 6, 27, 6),
(67, '2024-01-07', 185.25, 7, 28, 1),
(68, '2024-01-08', 95.80, 8, 29, 2),
(69, '2024-01-09', 110.50, 9, 30, 3),
(70, '2024-01-10', 140.60, 10, 31, 4),
(71, '2024-01-11', 160.90, 11, 32, 5),
(72, '2024-01-12', 120.80, 12, 33, 6),
(73, '2024-01-13', 180.00, 13, 34, 1),
(74, '2024-01-14', 140.20, 14, 35, 2),
(75, '2024-01-15', 95.40, 15, 36, 3),
(76, '2024-01-16', 160.25, 16, 37, 4),
(77, '2024-01-17', 200.90, 17, 38, 5),
(78, '2024-01-18', 120.80, 18, 39, 6),
(79, '2024-01-19', 140.60, 19, 40, 1),
(80, '2024-01-20', 185.30, 20, 41, 2),
(81, '2024-01-21', 95.25, 21, 42, 3),
(82, '2024-01-22', 105.80, 22, 43, 4),
(83, '2024-01-23', 160.50, 23, 44, 5),
(84, '2024-01-24', 180.70, 24, 45, 6),
(85, '2024-01-25', 120.40, 25, 46, 1),
(86, '2024-01-26', 130.60, 26, 47, 2),
(87, '2024-01-27', 190.20, 27, 48, 3),
(88, '2024-01-28', 110.90, 28, 49, 4),
(89, '2024-01-29', 150.80, 29, 50, 5),
(90, '2024-01-30', 135.75, 30, 51, 6),
(91, '2024-02-01', 170.40, 1, 52, 1),
(92, '2024-02-02', 120.50, 2, 53, 2),
(93, '2024-02-03', 155.60, 3, 54, 3),
(94, '2024-02-04', 90.75, 4, 1, 4),
(95, '2024-02-05', 200.20, 5, 2, 5),
(96, '2024-02-06', 140.30, 6, 3, 6),
(97, '2024-02-07', 185.25, 7, 4, 1),
(98, '2024-02-08', 95.80, 8, 5, 2),
(99, '2024-02-09', 110.50, 9, 6, 3),
(100, '2024-02-10', 140.60, 10, 7, 4);

-- Insertar las evaluaciones de los supervisores sobre los vendedores
INSERT INTO Evaluaciones (supervisor_id, vendedor_id, fecha_evaluacion, puntaje, comentario) VALUES
(1, 1, '2023-12-01', 4, 'Buen desempeño en ventas.'),
(1, 2, '2023-12-01', 3, 'Necesita mejorar en atención al cliente.'),
(1, 3, '2024-01-15', 5, 'Excelente trabajo en equipo.'),
(1, 4, '2024-01-15', 4, 'Cumple con las metas establecidas.'),
(1, 5, '2024-02-28', 3, 'Puede mejorar en seguimiento de clientes.'),
(2, 6, '2023-12-01', 4, 'Buen desempeño en ventas.'),
(2, 7, '2023-12-01', 3, 'Necesita mejorar en atención al cliente.'),
(2, 8, '2024-01-15', 5, 'Excelente trabajo en equipo.'),
(2, 9, '2024-01-15', 4, 'Cumple con las metas establecidas.'),
(2, 10, '2024-02-28', 3, 'Puede mejorar en seguimiento de clientes.'),
(3, 11, '2023-12-01', 4, 'Buen desempeño en ventas.'),
(3, 12, '2023-12-01', 3, 'Necesita mejorar en atención al cliente.'),
(3, 13, '2024-01-15', 5, 'Excelente trabajo en equipo.'),
(3, 14, '2024-01-15', 4, 'Cumple con las metas establecidas.'),
(3, 15, '2024-02-28', 3, 'Puede mejorar en seguimiento de clientes.'),
(4, 16, '2023-12-01', 4, 'Buen desempeño en ventas.'),
(4, 17, '2023-12-01', 3, 'Necesita mejorar en atención al cliente.'),
(4, 18, '2024-01-15', 5, 'Excelente trabajo en equipo.'),
(4, 19, '2024-01-15', 4, 'Cumple con las metas establecidas.'),
(4, 20, '2024-02-28', 3, 'Puede mejorar en seguimiento de clientes.'),
(5, 21, '2023-12-01', 4, 'Buen desempeño en ventas.'),
(5, 22, '2023-12-01', 3, 'Necesita mejorar en atención al cliente.'),
(5, 23, '2024-01-15', 5, 'Excelente trabajo en equipo.'),
(5, 24, '2024-01-15', 4, 'Cumple con las metas establecidas.'),
(5, 25, '2024-02-28', 3, 'Puede mejorar en seguimiento de clientes.'),
(6, 26, '2023-12-01', 4, 'Buen desempeño en ventas.'),
(6, 27, '2023-12-01', 3, 'Necesita mejorar en atención al cliente.'),
(6, 28, '2024-01-15', 5, 'Excelente trabajo en equipo.'),
(6, 29, '2024-01-15', 4, 'Cumple con las metas establecidas.'),
(6, 30, '2024-02-28', 3, 'Puede mejorar en seguimiento de clientes.');

-- Insertar valoraciones de clientres 
INSERT INTO Valoraciones_sucursales (cliente_id, sucursal_id, variedad_productos, atencion_cliente, limpieza_orden, precios_ofertas, experiencia_compra)
VALUES
(1, 1, 4, 5, 5, 4, 4),
(2, 2, 5, 4, 5, 3, 4),
(3, 3, 3, 5, 4, 3, 4),
(4, 4, 4, 4, 4, 4, 3),
(5, 5, 5, 3, 5, 3, 4),
(6, 6, 4, 4, 4, 5, 4),
(7, 1, 5, 5, 5, 4, 5),
(8, 2, 4, 4, 4, 3, 4),
(9, 3, 4, 5, 4, 4, 4),
(10, 4, 5, 4, 5, 3, 5),
(11, 5, 3, 5, 4, 3, 4),
(12, 6, 4, 4, 4, 4, 4),
(13, 1, 5, 5, 5, 3, 5),
(14, 2, 4, 4, 4, 4, 4),
(15, 3, 4, 5, 4, 5, 4),
(16, 4, 5, 4, 5, 4, 5),
(17, 5, 4, 4, 4, 4, 4),
(18, 6, 5, 5, 5, 4, 5),
(19, 1, 3, 4, 3, 3, 4),
(20, 2, 4, 5, 4, 4, 4),
(21, 3, 5, 4, 5, 3, 5),
(22, 4, 4, 4, 4, 4, 4),
(23, 5, 4, 4, 4, 4, 4),
(24, 6, 5, 5, 5, 5, 5),
(25, 1, 3, 4, 3, 4, 4),
(26, 2, 4, 5, 4, 5, 4),
(27, 3, 5, 5, 5, 4, 5),
(28, 4, 4, 4, 4, 4, 4),
(29, 5, 4, 4, 4, 4, 4),
(30, 6, 5, 5, 5, 5, 5);




-- CREACION DE VISTAS 



-- Muestra los detalles de cada factura, incluyendo el nombre del cliente, nombre del vendedor y nombre de la sucursal
CREATE VIEW VW_facturas AS
SELECT f.factura_id, f.fecha, f.total, c.nombre AS nombre_cliente, v.nombre AS nombre_vendedor, s.nombre AS nombre_sucursal
FROM Facturas AS f
JOIN Clientes AS c ON f.cliente_id = c.cliente_id
JOIN Vendedores AS v ON f.vendedor_id = v.vendedor_id
JOIN Sucursales AS s ON f.sucursal_id = s.sucursal_id
ORDER BY f.fecha DESC;


-- Muestra los productos con menos de 20 unidades en stock
CREATE VIEW VW_bajo_stock AS
SELECT p.producto_id, p.nombre, p.precio, p.stock, pr.nombre AS nombre_proveedor
FROM Productos AS p
JOIN Proveedores AS pr ON p.proveedor_id = pr.proveedor_id
WHERE p.stock < 100;
 
 
 -- Muestra los vendedores con la puntuación promedio más alta en las evaluaciones
CREATE VIEW VW_top_vendedores AS
SELECT v.vendedor_id, v.nombre, AVG(ev.puntaje) AS promedio_puntaje
FROM Vendedores AS v
JOIN Evaluaciones AS ev ON v.vendedor_id = ev.vendedor_id
GROUP BY v.vendedor_id, v.nombre
ORDER BY promedio_puntaje DESC;


-- Muestra el total de ventas por mes
CREATE VIEW VW_ventas_mes AS
SELECT YEAR(fecha) AS anio, MONTH(fecha) AS mes, SUM(total) AS total_ventas
FROM Facturas
GROUP BY YEAR(fecha), MONTH(fecha)
ORDER BY anio, mes;


-- Muestra las valoraciones promedio de cada sucursal
CREATE VIEW vw_valoraciones_sucursales  AS
SELECT vs.sucursal_id, s.nombre AS nombre_sucursal,AVG(vs.variedad_productos) AS promedio_variedad_productos,
    AVG(vs.atencion_cliente) AS promedio_atencion_cliente,
    AVG(vs.limpieza_orden) AS promedio_limpieza_orden,
    AVG(vs.precios_ofertas) AS promedio_precios_ofertas,
    AVG(vs.experiencia_compra) AS promedio_experiencia_compra
FROM Valoraciones_sucursales AS vs
JOIN Sucursales AS s ON vs.sucursal_id = s.sucursal_id
GROUP BY vs.sucursal_id, s.nombre;


-- Esta vista mostrará los clientes que han gastado más en total.
CREATE VIEW vw_top_clientes AS
SELECT c.cliente_id, c.nombre, SUM(f.total) AS total_gastado
FROM Facturas AS f
JOIN Clientes AS c ON f.cliente_id = c.cliente_id
GROUP BY c.cliente_id, c.nombre
ORDER BY total_gastado DESC
LIMIT 10;


-- Esta vista mostrará el total de ingresos generados por cada sucursal.
CREATE VIEW vw_ventas_sucursal AS
SELECT s.sucursal_id, s.nombre AS nombre_sucursal, SUM(f.total) AS total_ingresos
FROM Facturas AS f
JOIN Sucursales AS s ON f.sucursal_id = s.sucursal_id
GROUP BY s.sucursal_id, s.nombre
ORDER BY total_ingresos DESC;

-- Esta vista mostrara el precio de los productos con el IVA (16%)
CREATE VIEW vw_precio_con_iva AS
SELECT producto_id, nombre, precio, ROUND((precio * 1.16), 2) AS precio_con_iva
FROM productos;


-- CREACION DE FUNCIONES


-- Funcion para calcular el monto total de ventas por sucursal en un periodo de tiempo
DROP FUNCTION IF EXISTS FN_monto_total_ventas_sucursal;
DELIMITER $$
CREATE FUNCTION FN_monto_total_ventas_sucursal(P_sucursalId INT, P_fechaInicio DATE, P_fechaFin DATE)
RETURNS DECIMAL(10, 2) DETERMINISTIC
BEGIN
  DECLARE total_ventas DECIMAL(10, 2);
  SET total_ventas = (
    SELECT SUM(total) FROM facturas
    WHERE sucursal_id = P_sucursalId
      AND fecha BETWEEN P_fechaInicio AND P_fechaFin
  );
  RETURN COALESCE(total_ventas, 0);
END$$
DELIMITER ;

-- Para usar N_monto_total_ventas_sucursal
SELECT FN_monto_total_ventas_sucursal(2, '2023-01-01', '2023-12-31') AS MontoTotalVentasSucursal;


-- Función para obtener el total de ventas de un vendedor en un periodo de tiempo
DROP FUNCTION IF EXISTS FN_total_ventas_vendedor;
delimiter $$
CREATE FUNCTION FN_total_ventas_vendedor(P_vendedor_id INT, P_fecha_inicio DATE, P_fecha_fin DATE)
RETURNS DECIMAL(10, 2) DETERMINISTIC
BEGIN
  DECLARE total_ventas DECIMAL(10, 2);

  SET total_ventas = (
    SELECT SUM(total)
    FROM Facturas
    WHERE vendedor_id = P_vendedor_id
    AND fecha BETWEEN P_fecha_inicio AND P_fecha_fin
  );

  IF total_ventas IS NULL THEN
    SET total_ventas = 0;
  END IF;

  RETURN total_ventas;
END$$
delimiter ;

-- Para usar FN_total_ventas_vendedor
SELECT FN_total_ventas_vendedor(1, '2023-01-01', '2023-12-31') AS TotalVentas;



-- CREACION DE STORED PROCEDURES

--  Para registrar las nuevas ventas 

DELIMITER $$
CREATE PROCEDURE SP_RegistrarVenta(
    IN P_fecha DATE,
    IN P_total DECIMAL(10, 2),
    IN P_cliente_id INT,
    IN P_vendedor_id INT,
    IN P_sucursal_id INT
)
BEGIN
    INSERT INTO Facturas (fecha, total, cliente_id, vendedor_id, sucursal_id)
    VALUES (P_fecha, P_total, P_cliente_id, P_vendedor_id, P_sucursal_id);
END$$
DELIMITER ;

-- Para utilizar SP_RegistrarVent

CALL SP_RegistrarVenta('2023-11-13', 150.00, 1, 101, 201);


-- Para actualizar el stock de los productos 

DELIMITER $$
CREATE PROCEDURE SP_ActualizarStock(
    IN P_producto_id INT,
    IN P_cantidad_vendida INT
)
BEGIN
    UPDATE Productos
    SET stock = stock - P_cantidad_vendida
    WHERE producto_id = P_producto_id;
END$$
DELIMITER ;


-- Para utilizar SP_ActualizarStock

CALL SP_ActualizarStock(101, 3);




-- CREACION DE TRIGGERS 

-- Triggers de la tabla Facturas

/* Este trigger se activará antes de que se realice una operación de inserción en la tabla Facturas.

Registra una nueva entrada en la tabla LOG_AUDITORIA indicando que se está realizando una operación de inserción (INSERT) en la tabla Facturas.
Registra el usuario que realiza la operación, la fecha y la hora actual.

*/

DELIMITER //
CREATE TRIGGER before_insert_facturas
BEFORE INSERT ON Facturas
FOR EACH ROW
BEGIN
    INSERT INTO LOG_AUDITORIA (NOMBRE_DE_ACCION, NOMBRE_TABLA, USUARIO, FECHA_UPD_INS_DEL)
    VALUES ('INSERT', 'Facturas', CURRENT_USER(), NOW());
END;
//
DELIMITER ;


/* Este trigger se activará después de que se haya realizado la operación de inserción en la tabla Facturas.

Acción:
Registra una nueva entrada en la tabla LOG_AUDITORIA_2 con información detallada sobre la factura recién insertada.
Incluye el ID de la factura (factura_id), la acción realizada (INSERT), la tabla afectada (Facturas), el usuario que realizó la operación, y la fecha y hora de la operación.

*/


DELIMITER //
CREATE TRIGGER after_insert_facturas
AFTER INSERT ON Facturas
FOR EACH ROW
BEGIN
    INSERT INTO LOG_AUDITORIA_2 (FACTURA_ID, NOMBRE_DE_ACCION, NOMBRE_TABLA, USUARIO, FECHA_UPD_INS_DEL)
    VALUES (NEW.factura_id, 'INSERT', 'Facturas', CURRENT_USER(), NOW());
END;
//
DELIMITER ;


-- Triggers de la tabla Evaluaciones

/* Este trigger se activará antes de que se realice una operación de actualización en la tabla Evaluaciones.

Acción:
Registra una nueva entrada en la tabla LOG_AUDITORIA indicando que se está realizando una operación de actualización (UPDATE) en la tabla Evaluaciones.
Registra el usuario que realiza la operación, la fecha y la hora actual.

*/

DELIMITER //
CREATE TRIGGER before_update_evaluaciones
BEFORE UPDATE ON Evaluaciones
FOR EACH ROW
BEGIN
    INSERT INTO LOG_AUDITORIA (NOMBRE_DE_ACCION, NOMBRE_TABLA, USUARIO, FECHA_UPD_INS_DEL)
    VALUES ('UPDATE', 'Evaluaciones', CURRENT_USER(), NOW());
END;
//
DELIMITER ;


/* Este trigger se activará después de que se haya realizado la operación de actualización en la tabla Evaluaciones.

Acción:
Registra una nueva entrada en la tabla LOG_AUDITORIA_2 con información detallada sobre la evaluación recién actualizada.
Incluye el ID de la evaluación (evaluacion_id), la acción realizada (UPDATE), la tabla afectada (Evaluaciones), el usuario que realizó la operación, y la fecha y hora de la operación.

*/

DELIMITER //
CREATE TRIGGER after_update_evaluaciones
AFTER UPDATE ON Evaluaciones
FOR EACH ROW
BEGIN
    INSERT INTO LOG_AUDITORIA_2 (EVALUACION_ID, NOMBRE_DE_ACCION, NOMBRE_TABLA, USUARIO, FECHA_UPD_INS_DEL)
    VALUES (NEW.evaluacion_id, 'UPDATE', 'Evaluaciones', CURRENT_USER(), NOW());
END;
//
DELIMITER ;

 
 
-- CREACION DE USUARIOS 

-- Usuario 1 

CREATE USER 'usuario123456'@'localhost' IDENTIFIED BY 'contrasena_inventada';

GRANT SELECT ON ventas_supermercado.* TO 'usuario123456'@'localhost';

REVOKE DELETE ON ventas_supermercado.* FROM 'usuario123456'@'localhost';



-- Usuario 2 

CREATE USER 'usuario654321'@'localhost' IDENTIFIED BY 'otra_contrasena_inventada';

GRANT SELECT, INSERT, UPDATE ON ventas_supermercado.* TO 'usuario654321'@'localhost';

REVOKE DELETE ON ventas_supermercado.* FROM 'usuario654321'@'localhost';





-- SENTENCIAS DEL SUBLENGUAJE TCL

-- Primera tabla

START TRANSACTION;

INSERT INTO productos (nombre, precio, stock, proveedor_id) VALUES
        ('Nuevo Producto 1', 10.00, 50, 1),
        ('Nuevo Producto 2', 15.00, 30, 2);
        

-- ROLLBACK; -- Descomenta esta línea si necesitas revertir la transacción


-- COMMIT; -- Descomenta esta línea para confirmar la transacción


-- Segunda  tabla 


START TRANSACTION;

INSERT INTO Facturas (fecha, total, cliente_id, vendedor_id, sucursal_id) VALUES
  ('2023-11-22', 100.00, 1, 101, 201),
  ('2023-11-22', 150.00, 2, 102, 202);


SAVEPOINT sp_after_record_4;


INSERT INTO Facturas (fecha, total, cliente_id, vendedor_id, sucursal_id) VALUES
  ('2023-11-22', 120.00, 3, 103, 203),
  ('2023-11-22', 80.00, 4, 104, 204);

SAVEPOINT sp_after_record_8;


-- ROLLBACK TO sp_after_record_4; -- Si descomnetas esta linea para evertir los primeros 4 registros


