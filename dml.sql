CREATE DATABASE IF NOT EXISTS libreria_quijote;

USE libreria_quijote;

CREATE TABLE IF NOT EXISTS categorias (
    
    id_categoria INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS generos_literarios (

    id_genero_literario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS productos (

    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

CREATE TABLE IF NOT EXISTS libros (
    id_libro INT PRIMARY KEY AUTO_INCREMENT,
    autor VARCHAR(50) NOT NULL,
    editorial VARCHAR(50) NOT NULL,
    año_publicacion YEAR NOT NULL,
    numero_paginas INT NOT NULL,
    id_producto INT,
    id_genero_literario INT,
    FOREIGN KEY (id_genero_literario) REFERENCES generos_literarios (id_genero_literario),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);

CREATE TABLE IF NOT EXISTS revistas (
    id_revista INT PRIMARY KEY AUTO_INCREMENT,
    periodicidad ENUM('mensual', 'semanal', 'diario') NOT NULL,
    numero_edicion VARCHAR(50) NOT NULL,
    fecha_publicacion DATE NOT NULL,
    id_producto INT,
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);

CREATE TABLE IF NOT EXISTS accesorios (
    id_accesorio INT PRIMARY KEY AUTO_INCREMENT,
    tipo ENUM('marcapaginas', 'lamparas de lectura', 'estantes', 'otro') NOT NULL,
    material VARCHAR(50) NOT NULL,
    id_producto INT,
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);

CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    correo VARCHAR(250) NOT NULL UNIQUE,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS empleados (
    id_empleado INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    puesto_trabajo VARCHAR(100) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    area_trabajo ENUM('venta', 'caja', 'administracion')
);

CREATE TABLE IF NOT EXISTS ventas (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    fecha_venta DATE NOT NULL,
    id_cliente INT,
    id_empleado INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado)
);

CREATE TABLE IF NOT EXISTS detalles_venta (
    id_detalle_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_venta INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas (id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);

CREATE TABLE IF NOT EXISTS proveedores (
    id_proveedor INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre_contacto VARCHAR(100) NOT NULL,
    nombre_empresa VARCHAR(100) NOT NULL,
    telefono VARCHAR(100) NOT NULL UNIQUE,
    direccion VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS ordenes_compra (
    id_orden_compra INT PRIMARY KEY AUTO_INCREMENT,
    id_proveedor INT,
    fecha_orden DATE NOT NULL,
    cantidad_recibida INT NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores (id_proveedor)
);

CREATE TABLE IF NOT EXISTS detalles_orden_compra (
    id_detalle_orden INT PRIMARY KEY AUTO_INCREMENT,
    id_orden_compra INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_orden_compra) REFERENCES ordenes_compra (id_orden_compra),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);