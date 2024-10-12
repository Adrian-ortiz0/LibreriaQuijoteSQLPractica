INSERT INTO categorias (id_categoria, nombre) VALUES
(1, 'Libros'),
(2, 'Revistas'),
(3, 'Accesorios');

INSERT INTO generos_literarios (id_genero_literario, nombre) VALUES
(1, 'Novela'),
(2, 'Cuento'),
(3, 'Poesía'),
(4, 'Ensayo'),
(5, 'Biografía');

INSERT INTO productos (nombre, descripcion, precio, stock, id_categoria) VALUES
('El Quijote', 'Novela clásica de Miguel de Cervantes', 19.99, 50, 1),
('Breves respuestas a las grandes preguntas', 'Libro de Stephen Hawking sobre cosmología', 15.00, 30, 1),
('Harry Potter y la piedra filosofal', 'Primera entrega de la famosa saga de Harry Potter', 10.99, 70, 1),
('National Geographic', 'Revista mensual sobre naturaleza y cultura', 5.00, 100, 2),
('Cuentos de la selva', 'Colección de cuentos de Horacio Quiroga', 8.50, 60, 1),
('El País', 'Diario español con edición diaria', 2.50, 200, 2),
('Marcapáginas de madera', 'Marcapáginas hecho de madera artesanal', 3.00, 150, 3),
('Lámpara de lectura LED', 'Lámpara de lectura con luz LED ajustable', 25.00, 80, 3);

INSERT INTO libros (autor, editorial, año_publicacion, numero_paginas, id_producto, id_genero_literario) VALUES
('Miguel de Cervantes', 'Editorial Clásicos', 1905, 1000, 1, 1),
('Stephen Hawking', 'Editorial Planeta', 2018, 256, 2, 4),
('J.K. Rowling', 'Editorial Salamandra', 1997, 223, 3, 1),
('Horacio Quiroga', 'Editorial Losada', 1918, 200, 5, 2);

INSERT INTO revistas (periodicidad, numero_edicion, fecha_publicacion, id_producto) VALUES
('mensual', 'Edición 1', '2024-01-01', 4),
('diario', 'Edición 250', '2024-10-12', 6);

INSERT INTO accesorios (tipo, material, id_producto) VALUES
('marcapaginas', 'madera', 7),
('lamparas de lectura', 'plástico', 8);

INSERT INTO clientes (nombres, apellidos, correo, direccion, telefono) VALUES
('Juan', 'Pérez', 'juan.perez@example.com', 'Calle 1', '123456789'),
('María', 'Gómez', 'maria.gomez@example.com', 'Calle 2', '987654321'),
('Luis', 'Martínez', 'luis.martinez@example.com', 'Calle 3', '654321987');

INSERT INTO empleados (nombres, apellidos, puesto_trabajo, fecha_contratacion, area_trabajo) VALUES
('Ana', 'López', 'Vendedora', '2022-01-15', 'venta'),
('Carlos', 'García', 'Administrador', '2021-06-20', 'administracion'),
('Sofía', 'Torres', 'Cajera', '2023-03-10', 'caja');

INSERT INTO proveedores (nombre_contacto, nombre_empresa, telefono, direccion) VALUES
('Carlos', 'Distribuidora ABC', '555123456', 'Avenida Siempre Viva'),
('Elena', 'Proveedores XYZ', '555987654', 'Boulevard de la Paz'),
('Juanita', 'Suministros LMN', '555222333', 'Calle Falsa 123');

INSERT INTO ordenes_compra (id_proveedor, fecha_orden, cantidad_recibida) VALUES
(1, '2024-09-15', 100),
(2, '2024-09-20', 50),
(3, '2024-09-25', 75);

INSERT INTO detalles_orden_compra (id_orden_compra, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 10, 15.00),
(1, 2, 5, 12.00),
(2, 4, 20, 5.00),
(3, 3, 15, 10.00);

INSERT INTO ventas (fecha_venta, id_cliente, id_empleado, cantidad, precio_unitario) VALUES
('2024-10-01', 1, 1, 1, 19.99),
('2024-10-02', 2, 2, 2, 15.00),
('2024-10-03', 3, 3, 1, 10.99);

INSERT INTO detalles_venta (id_venta, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 1, 19.99),
(2, 2, 1, 15.00),
(3, 3, 1, 10.99);
