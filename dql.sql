DELIMITER //

CREATE PROCEDURE listar_libros_por_genero(IN genero VARCHAR(100))
BEGIN
    SELECT -- select sirve para traer la información que queremos presentar de las tablas que necesitamos
        productos.id_producto,
        productos.nombre AS titulo,        
        libros.autor,                   
        productos.precio,
        productos.stock
    FROM 
        libros
    JOIN 
        productos ON libros.id_producto = productos.id_producto
    JOIN 
        generos_literarios ON libros.id_genero_literario = generos_literarios.id_genero_literario
    WHERE 
        generos_literarios.nombre = genero;
END //

DELIMITER ;

CALL listar_libros_por_genero("Novela");

-- 2. Obtener todos los productos de una categoría (libros, revistas, accesorios) cuyo stock sea inferior a un valor dado

DELIMITER //

CREATE PROCEDURE obtener_productos_por_categoria_y_stock(IN categoria VARCHAR(100), IN stock INT)
BEGIN
    SELECT 
        productos.id_producto,
        productos.nombre AS titulo,        
        categorias.nombre AS categoria,    
        productos.precio,
        productos.stock
    FROM 
        productos
    JOIN 
        categorias ON productos.id_categoria = categorias.id_categoria
    WHERE 
        categorias.nombre = categoria AND
        productos.stock <= stock;
END //

DELIMITER ;

CALL obtener_productos_por_categoria_y_stock("libros", 50);

-- 3. Mostrar todas las ventas realizadas por un cliente específico en un rango de fechas.

DELIMITER //

CREATE PROCEDURE mostrar_ventas_por_cliente_y_fechas(
    IN p_id_cliente INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT 
        v.id_venta,
        v.fecha_venta,
        c.nombres AS nombre_cliente,
        c.apellidos AS apellido_cliente,
        dv.cantidad,
        dv.precio_unitario,
        (dv.cantidad * dv.precio_unitario) AS total_venta, -- Total por producto
        p.nombre AS nombre_producto
    FROM 
        ventas v
    JOIN 
        clientes c ON v.id_cliente = c.id_cliente
    JOIN 
        detalles_venta dv ON v.id_venta = dv.id_venta
    JOIN 
        productos p ON dv.id_producto = p.id_producto
    WHERE 
        v.id_cliente = p_id_cliente -- Filtrar por el cliente específico
        AND v.fecha_venta BETWEEN p_fecha_inicio AND p_fecha_fin; -- Filtrar por el rango de fechas
END //

DELIMITER ;


call mostrar_ventas_por_cliente_y_fechas(1, "2024-10-01","2024-10-02");