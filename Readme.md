# LIBRERIA QUIJOTE

Este es un sistema de base de datos relacional para la libreria quijote (Practica de bases de datos en SQL).

## Tabla de contenido 

| Indice | Titulo          |
| ------ | --------------- |
| 1      | Intalacion      |
| 2      | Tecnologias     |
| 3      | Requerimientos  |
| 4      | Entidades Prin  |
| 5      | Explicaciones   |
| 6      | Diagrama UML    |
| 7      | FAQs            |
| 8      | Licencia        |
| 9      | Grupo           |
| 10      | Consultas      |

## 1 Instalación 

```bash
git clone https://github.com/Adrian-ortiz0/Libreria_Quijote_SQLPractica
cd Libreria_Quijote_SQLPractica
code .
```

## 2 Tecnologias 

Lista de tecnologías utilizadas en el proyecto:

- [MySQL](<[https://developer.mozilla.org/en-US/docs/Web/MYSQL](https://developer.mozilla.org/en-US/docs/Web/MYSQL)>): Utilizado para la gestión de la base de datos relacional.

## 3. Requerimientos del sistema

### **Productos**

1. Cada producto tendrá un identificador único, nombre, descripción, categoría (libros, revistas, accesorios), precio y stock disponible.
2. Los libros incluirán campos adicionales como autor, género literario, editorial, año de publicación y número de páginas.
3. Las revistas tendrán campos para la periodicidad (mensual, semanal, etc.), número de edición y fecha de publicación.
4. Los accesorios tendrán campos como tipo (marcapáginas, lámparas de lectura, estantes, etc.) y material.

### **Clientes**
1. Cada cliente debe ser registrado con un identificador único, nombre completo, correo electrónico, dirección y número de teléfono.

### **Ventas**

1. Cada venta realizada debe ser registrada con un número único, la fecha de la venta, el cliente que realizó la compra, los productos adquiridos y la cantidad de cada uno.
2. Se debe registrar el empleado que atendió la venta.

### **Empleados**
1. Los empleados tendrán un identificador único, nombre completo, puesto de trabajo, fecha de contratación, y pueden estar asignados a diferentes áreas (venta, caja, administración).

### **Proveedores**
1. Cada proveedor debe tener un identificador único, nombre de la empresa, nombre del contacto, teléfono y dirección.
2. Se debe llevar un registro de las órdenes de compra realizadas a los proveedores, con los productos solicitados, la fecha de la orden, y la cantidad de productos recibidos.

## 4. Entidades principales

## 5. Explicaciones

1. Libros, accesorios y revistas deben heredar todos la foreign key de producto, ya que:

* Relación de generalización/especialización:

  PRODUCTO es la entidad general (padre).
  LIBRO, REVISTA y ACCESORIO son entidades especializadas (hijas).

* Cardinalidad de la relación:

  Un PRODUCTO puede ser un LIBRO, una REVISTA o un ACCESORIO (relación 1:1).
  Pero un LIBRO, REVISTA o ACCESORIO siempre es un PRODUCTO.

* Integridad referencial:

  Al tener la clave foránea en las tablas hijas, aseguramos que cada libro, revista o accesorio esté asociado a un producto existente.
  Esto previene la creación de libros, revistas o accesorios sin un producto correspondiente.

2. La tabla de detalles_ventas

   creamos esta tabla como conexión de ventas con el fin de múltiples Productos por venta, ya que, en muchas transacciones, un cliente puede comprar múltiples productos. Si la tabla de ventas solo almacena un registro por venta, no podrás almacenar diferentes productos que se vendieron en la misma transacción.

3. La tabla detalles_ordenes_compra

  Permite registrar múltiples productos en una sola orden de compra. Si un proveedor envía varios productos en una sola orden, cada uno puede ser registrado con su propia cantidad y precio.

