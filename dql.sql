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


CALL mostrar_ventas_por_cliente_y_fechas(1, "2024-10-01","2024-10-02");


-- 4. CALCULAR EL TOTAL DE VENTAS REALIZADAS POR UN EMPLEADO EN UN MES DADO. TOTAL VENTAS O TOTAL ALGO = COUNT(*)
DELIMITER //
CREATE PROCEDURE VENTAS_POR_EMPLEADO(IN P_ID_EMPLEADO INT, IN MES INT, IN AÑO INT, OUT TOTAL_VENTAS INT)
BEGIN
	SELECT
		COUNT(*) INTO TOTAL_VENTAS
	FROM
		VENTAS
	WHERE
		ID_EMPLEADO = P_ID_EMPLEADO
        AND MONTH(FECHA_VENTA) = MES
        AND YEAR (FECHA_VENTA) = AÑO;
END //
DELIMITER ;

SET @TOTAL_VENDIDO = 0;
CALL VENTAS_POR_EMPLEADO(1, 10, 2024, @TOTAL_VENDIDO);
SELECT @TOTAL_VENDIDO AS TOTAL_VENTAS;

-- 5. LISTAR LOS PRODUCTOS MÁS VENDIDOS EN UN PERÍODO DETERMINADO.
DELIMITER //

CREATE PROCEDURE LISTAR_PRODUCTOS_POR_PERIODO(IN FECHA_INICIAL DATE, IN FECHA_FINAL DATE)
BEGIN
	SELECT 
		PRODUCTOS.ID_PRODUCTO,
        PRODUCTOS.NOMBRE,
        DETALLES_VENTA.CANTIDAD,
        VENTAS.FECHA_VENTA
	FROM 
		DETALLES_VENTA
	JOIN 
		PRODUCTOS ON DETALLES_VENTA.ID_PRODUCTO = PRODUCTOS.ID_PRODUCTO
	JOIN
		VENTAS ON VENTAS.ID_VENTA = DETALLES_VENTA.ID_VENTA
	WHERE
		VENTAS.FECHA_VENTA BETWEEN FECHA_INICIAL AND FECHA_FINAL;
END //
DELIMITER ;

CALL LISTAR_PRODUCTOS_POR_PERIODO("2024-10-01", "2024-10-02");

-- 6. CONSULTAR EL STOCK DISPONIBLE DE UN PRODUCTO POR SU NOMBRE O IDENTIFICADOR.

DELIMITER //
CREATE PROCEDURE STOCK_DE_PRODUCTO(IN ID_PRODUCTO INT)
	BEGIN
		SELECT 
			PRODUCTOS.ID_PRODUCTO,
            PRODUCTOS.NOMBRE,
            PRODUCTOS.STOCK
		FROM
			PRODUCTOS
		WHERE
			PRODUCTOS.ID_PRODUCTO = ID_PRODUCTO;
    END //
DELIMITER ;

CALL STOCK_DE_PRODUCTO(2);

-- 7. MOSTRAR LAS ÓRDENES DE COMPRA REALIZADAS A UN PROVEEDOR ESPECÍFICO EN EL ÚLTIMO AÑO.

DELIMITER //

DELIMITER //

CREATE PROCEDURE LISTAR_ORDENES_A_PROVEEDOR(IN ID_PROVEEDOR INT, IN AÑO INT)
BEGIN
    SELECT
        ORDENES_COMPRA.ID_ORDEN_COMPRA,
        PROVEEDORES.NOMBRE_EMPRESA,
        PRODUCTOS.NOMBRE AS NOMBRE_PRODUCTO,
        DETALLES_ORDEN_COMPRA.ID_PRODUCTO,
        ORDENES_COMPRA.FECHA_ORDEN
    FROM 
        ORDENES_COMPRA
    JOIN
        PROVEEDORES ON PROVEEDORES.ID_PROVEEDOR = ORDENES_COMPRA.ID_PROVEEDOR
    JOIN
        DETALLES_ORDEN_COMPRA ON DETALLES_ORDEN_COMPRA.ID_ORDEN_COMPRA = ORDENES_COMPRA.ID_ORDEN_COMPRA
    JOIN
        PRODUCTOS ON PRODUCTOS.ID_PRODUCTO = DETALLES_ORDEN_COMPRA.ID_PRODUCTO
    WHERE
        PROVEEDORES.ID_PROVEEDOR = ID_PROVEEDOR
    AND
        YEAR(ORDENES_COMPRA.FECHA_ORDEN) = AÑO;
END //

DELIMITER ;

CALL LISTAR_ORDENES_A_PROVEEDOR(1, 2024);

-- 8. LISTAR LOS EMPLEADOS QUE HAN TRABAJADO MÁS DE UN AÑO EN LA LIBRERÍA.

SELECT 
    ID_EMPLEADO,
    NOMBRES,
    APELLIDOS,
    PUESTO_TRABAJO,
    FECHA_CONTRATACION,
    DATEDIFF(CURDATE(), FECHA_CONTRATACION) AS DIAS_TRABAJADOS,
    FLOOR(DATEDIFF(CURDATE(), FECHA_CONTRATACION) / 365) AS AÑOS_TRABAJADOS
FROM 
    EMPLEADOS
WHERE 
    DATEDIFF(CURDATE(), FECHA_CONTRATACION) > 365;

-- 9. OBTENER LA CANTIDAD TOTAL DE PRODUCTOS VENDIDOS EN UN DÍA ESPECÍFICO.

DELIMITER //

CREATE PROCEDURE DIA_ESPECIFICO(IN DIA INT, OUT TOTAL_PRODUCTOS INT)

	BEGIN
		SELECT
			COUNT(*) INTO TOTAL_PRODUCTOS
		FROM
			VENTAS
		WHERE
			DAY(VENTAS.FECHA_VENTA) = DIA;
	END //
DELIMITER ;

SET @TOTAL = 0;
CALL DIA_ESPECIFICO(03, @TOTAL);
SELECT @TOTAL AS TOTAL_EN_DIA;

-- 10. CONSULTAR LAS VENTAS DE UN PRODUCTO ESPECÍFICO (POR NOMBRE O ID) Y CUÁNTAS UNIDADES SE VENDIERON.

DELIMITER //

CREATE PROCEDURE DETALLES_PRODUCTO(IN ID_PRODUCTO INT)
BEGIN
	SELECT
		PRODUCTOS.ID_PRODUCTO,
        PRODUCTOS.NOMBRE,
        VENTAS.CANTIDAD
	FROM
		PRODUCTOS
	JOIN 
		DETALLES_VENTA ON DETALLES_VENTA.ID_PRODUCTO = PRODUCTOS.ID_PRODUCTO
	JOIN
		VENTAS ON VENTAS.ID_VENTA = DETALLES_VENTA.ID_VENTA
	WHERE
		PRODUCTOS.ID_PRODUCTO = ID_PRODUCTO;
END //

DELIMITER ;

CALL DETALLES_PRODUCTO(1);
