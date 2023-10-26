/*
Base de datos utilizada para gestionar las ventas de 
un supermercado a traves del registro de facturas 
*/


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
    cliente_id INT,
    vendedor_id INT,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
    FOREIGN KEY (vendedor_id) REFERENCES Vendedores(vendedor_id)
);

-- Detalles de facturas (tabla donde se registrarán los detalles de cada  una de las transacciones)
CREATE TABLE Detalle_Factura (
    detalle_id INT PRIMARY KEY,
    factura_id INT,
    producto_id INT,
    cantidad INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (factura_id) REFERENCES Facturas(factura_id),
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id)
);

-- Evaluaciones (tabla donde se registrarán las evaluaciones de desempeño que realizan los supervisores sobre los vendedores)
CREATE TABLE Evaluaciones (
    evaluacion_id INT PRIMARY KEY,
    supervisor_id INT,
    vendedor_id INT,
    fecha DATE,
    calificacion INT,
    FOREIGN KEY (supervisor_id) REFERENCES Supervisores(supervisor_id),
    FOREIGN KEY (vendedor_id) REFERENCES Vendedores(vendedor_id)
);






