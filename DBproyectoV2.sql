--------------------------------------------------------
-- Archivo creado  - jueves-julio-27-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence SEQ_VENTAS
--------------------------------------------------------

   CREATE SEQUENCE  "G9_USUARIO"."SEQ_VENTAS"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Table AUDITORIAS
--------------------------------------------------------

  CREATE TABLE "G9_USUARIO"."AUDITORIAS" 
   (	"ID_AUDITORIA" NUMBER, 
	"ID_MOVIMIENTO" NUMBER, 
	"FECHA" DATE, 
	"RESULTADO" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "TBL_PROYECTO_G9" ;
  GRANT SELECT ON "G9_USUARIO"."AUDITORIAS" TO "ROL_LENGUAJESP";
--------------------------------------------------------
--  DDL for Table CLIENTES
--------------------------------------------------------

  CREATE TABLE "G9_USUARIO"."CLIENTES" 
   (	"ID_CLIENTE" NUMBER, 
	"NOMBRE" VARCHAR2(100 BYTE), 
	"DIRECCION" VARCHAR2(200 BYTE), 
	"TELEFONO" VARCHAR2(20 BYTE), 
	"CORREO_ELECTRONICO" VARCHAR2(100 BYTE), 
	"ESTADO_CLIENTE" VARCHAR2(10 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "TBL_PROYECTO_G9" ;
  GRANT SELECT ON "G9_USUARIO"."CLIENTES" TO "ROL_LENGUAJESP";
--------------------------------------------------------
--  DDL for Table INVENTARIO
--------------------------------------------------------

  CREATE TABLE "G9_USUARIO"."INVENTARIO" 
   (	"ID_INVENTARIO" NUMBER, 
	"ID_PRODUCTO" NUMBER, 
	"CANTIDAD_ACTUAL" NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "TBL_PROYECTO_G9" ;
  GRANT SELECT ON "G9_USUARIO"."INVENTARIO" TO "ROL_LENGUAJESP";
--------------------------------------------------------
--  DDL for Table MOVIMIENTOS
--------------------------------------------------------

  CREATE TABLE "G9_USUARIO"."MOVIMIENTOS" 
   (	"ID_MOVIMIENTO" NUMBER, 
	"ID_PRODUCTO" NUMBER, 
	"TIPO_MOVIMIENTO" VARCHAR2(50 BYTE), 
	"CANTIDAD" NUMBER, 
	"FECHA" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "TBL_PROYECTO_G9" ;
  GRANT SELECT ON "G9_USUARIO"."MOVIMIENTOS" TO "ROL_LENGUAJESP";
--------------------------------------------------------
--  DDL for Table PRECIOS
--------------------------------------------------------

  CREATE TABLE "G9_USUARIO"."PRECIOS" 
   (	"ID_PRECIO" NUMBER, 
	"ID_PRODUCTO" NUMBER, 
	"PRECIO_COMPRA" NUMBER, 
	"PRECIO_VENTA" NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "TBL_PROYECTO_G9" ;
  GRANT SELECT ON "G9_USUARIO"."PRECIOS" TO "ROL_LENGUAJESP";
--------------------------------------------------------
--  DDL for Table PRODUCTOS
--------------------------------------------------------

  CREATE TABLE "G9_USUARIO"."PRODUCTOS" 
   (	"ID_PRODUCTO" NUMBER, 
	"NOMBRE" VARCHAR2(100 BYTE), 
	"DESCRIPCION" VARCHAR2(200 BYTE), 
	"CODIGO" VARCHAR2(50 BYTE), 
	"UNIDAD_MEDIDA" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "TBL_PROYECTO_G9" ;
  GRANT SELECT ON "G9_USUARIO"."PRODUCTOS" TO "ROL_LENGUAJESP";
--------------------------------------------------------
--  DDL for Table VENTAS
--------------------------------------------------------

  CREATE TABLE "G9_USUARIO"."VENTAS" 
   (	"ID_VENTA" NUMBER(*,0), 
	"CANTIDAD" NUMBER(*,0), 
	"ID_PRODUCTO" NUMBER(*,0), 
	"ID_CLIENTE" NUMBER(*,0), 
	"FECHA_VENTA" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "TBL_PROYECTO_G9" ;
--------------------------------------------------------
--  DDL for View VISTA_AUDITORIAS_RESULTADO
--------------------------------------------------------

  CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "G9_USUARIO"."VISTA_AUDITORIAS_RESULTADO" ("EXITOSAS", "FALLIDAS") AS 
  SELECT COUNT(CASE WHEN A.Resultado = 'éxito' THEN 1 END) AS Exitosas,
       COUNT(CASE WHEN A.Resultado = 'fallos' THEN 1 END) AS Fallidas
FROM Auditorias A
;
--------------------------------------------------------
--  DDL for View VISTA_MOVIMIENTOS_INVENTARIO
--------------------------------------------------------

  CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "G9_USUARIO"."VISTA_MOVIMIENTOS_INVENTARIO" ("ID_MOVIMIENTO", "TIPO_MOVIMIENTO", "CANTIDAD", "FECHA", "NOMBRE_PRODUCTO", "CANTIDAD_ACTUAL") AS 
  SELECT M.ID_movimiento, M.Tipo_movimiento, M.Cantidad, M.Fecha, P.Nombre AS Nombre_Producto, I.Cantidad_actual
FROM Movimientos M
JOIN Productos P ON M.ID_producto = P.ID_producto
JOIN Inventario I ON M.ID_producto = I.ID_producto
;
--------------------------------------------------------
--  DDL for View VISTA_PRODUCTOS_PRECIOS
--------------------------------------------------------

  CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "G9_USUARIO"."VISTA_PRODUCTOS_PRECIOS" ("ID_PRODUCTO", "NOMBRE_PRODUCTO", "DESCRIPCION", "CODIGO", "UNIDAD_MEDIDA", "PRECIO_COMPRA", "PRECIO_VENTA") AS 
  SELECT P.ID_producto, P.Nombre AS Nombre_Producto, P.Descripcion, P.Codigo, P.Unidad_medida, PR.Precio_compra, PR.Precio_venta
FROM Productos P
JOIN Precios PR ON P.ID_producto = PR.ID_producto
;
--------------------------------------------------------
--  DDL for View VISTA_PRODUCTOS_PRECIOS_BAJOS
--------------------------------------------------------

  CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "G9_USUARIO"."VISTA_PRODUCTOS_PRECIOS_BAJOS" ("NOMBRE_PRODUCTO", "DESCRIPCION", "PRECIO_COMPRA", "PRECIO_VENTA") AS 
  SELECT P.Nombre AS Nombre_Producto, P.Descripcion, PR.Precio_compra, PR.Precio_venta
FROM Productos P
JOIN Precios PR ON P.ID_producto = PR.ID_producto
WHERE PR.Precio_venta < 50000
;
--------------------------------------------------------
--  DDL for View VISTA_VENTAS_CLIENTES
--------------------------------------------------------

  CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "G9_USUARIO"."VISTA_VENTAS_CLIENTES" ("ID_CLIENTE", "NOMBRE_CLIENTE", "DIRECCION", "TELEFONO", "CORREO_ELECTRONICO", "ID_VENTA", "CANTIDAD", "NOMBRE_PRODUCTO") AS 
  SELECT C.ID_cliente, C.Nombre Nombre_Cliente, C.Direccion, C.Telefono, C.Correo_electronico, V.ID_venta, V.cantidad, P.Nombre  Nombre_Producto
FROM Clientes C
JOIN Ventas V ON C.ID_cliente = V.id_cliente
JOIN Productos P ON V.id_producto = P.ID_producto
;
REM INSERTING into G9_USUARIO.AUDITORIAS
SET DEFINE OFF;
REM INSERTING into G9_USUARIO.CLIENTES
SET DEFINE OFF;
REM INSERTING into G9_USUARIO.INVENTARIO
SET DEFINE OFF;
REM INSERTING into G9_USUARIO.MOVIMIENTOS
SET DEFINE OFF;
REM INSERTING into G9_USUARIO.PRECIOS
SET DEFINE OFF;
REM INSERTING into G9_USUARIO.PRODUCTOS
SET DEFINE OFF;
REM INSERTING into G9_USUARIO.VENTAS
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index SYS_C007649
--------------------------------------------------------

  CREATE UNIQUE INDEX "G9_USUARIO"."SYS_C007649" ON "G9_USUARIO"."PRODUCTOS" ("ID_PRODUCTO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9" ;
--------------------------------------------------------
--  DDL for Index SYS_C007650
--------------------------------------------------------

  CREATE UNIQUE INDEX "G9_USUARIO"."SYS_C007650" ON "G9_USUARIO"."INVENTARIO" ("ID_INVENTARIO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9" ;
--------------------------------------------------------
--  DDL for Index SYS_C007652
--------------------------------------------------------

  CREATE UNIQUE INDEX "G9_USUARIO"."SYS_C007652" ON "G9_USUARIO"."PRECIOS" ("ID_PRECIO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9" ;
--------------------------------------------------------
--  DDL for Index SYS_C007654
--------------------------------------------------------

  CREATE UNIQUE INDEX "G9_USUARIO"."SYS_C007654" ON "G9_USUARIO"."MOVIMIENTOS" ("ID_MOVIMIENTO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9" ;
--------------------------------------------------------
--  DDL for Index SYS_C007656
--------------------------------------------------------

  CREATE UNIQUE INDEX "G9_USUARIO"."SYS_C007656" ON "G9_USUARIO"."CLIENTES" ("ID_CLIENTE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9" ;
--------------------------------------------------------
--  DDL for Index SYS_C007657
--------------------------------------------------------

  CREATE UNIQUE INDEX "G9_USUARIO"."SYS_C007657" ON "G9_USUARIO"."AUDITORIAS" ("ID_AUDITORIA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9" ;
--------------------------------------------------------
--  DDL for Index SYS_C007662
--------------------------------------------------------

  CREATE UNIQUE INDEX "G9_USUARIO"."SYS_C007662" ON "G9_USUARIO"."VENTAS" ("ID_VENTA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9" ;
--------------------------------------------------------
--  DDL for Index SYS_C007657
--------------------------------------------------------

  CREATE UNIQUE INDEX "G9_USUARIO"."SYS_C007657" ON "G9_USUARIO"."AUDITORIAS" ("ID_AUDITORIA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9" ;
--------------------------------------------------------
--  DDL for Index SYS_C007656
--------------------------------------------------------

  CREATE UNIQUE INDEX "G9_USUARIO"."SYS_C007656" ON "G9_USUARIO"."CLIENTES" ("ID_CLIENTE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9" ;
--------------------------------------------------------
--  DDL for Index SYS_C007650
--------------------------------------------------------

  CREATE UNIQUE INDEX "G9_USUARIO"."SYS_C007650" ON "G9_USUARIO"."INVENTARIO" ("ID_INVENTARIO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9" ;
--------------------------------------------------------
--  DDL for Index SYS_C007654
--------------------------------------------------------

  CREATE UNIQUE INDEX "G9_USUARIO"."SYS_C007654" ON "G9_USUARIO"."MOVIMIENTOS" ("ID_MOVIMIENTO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9" ;
--------------------------------------------------------
--  DDL for Index SYS_C007652
--------------------------------------------------------

  CREATE UNIQUE INDEX "G9_USUARIO"."SYS_C007652" ON "G9_USUARIO"."PRECIOS" ("ID_PRECIO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9" ;
--------------------------------------------------------
--  DDL for Index SYS_C007649
--------------------------------------------------------

  CREATE UNIQUE INDEX "G9_USUARIO"."SYS_C007649" ON "G9_USUARIO"."PRODUCTOS" ("ID_PRODUCTO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9" ;
--------------------------------------------------------
--  DDL for Index SYS_C007662
--------------------------------------------------------

  CREATE UNIQUE INDEX "G9_USUARIO"."SYS_C007662" ON "G9_USUARIO"."VENTAS" ("ID_VENTA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9" ;
--------------------------------------------------------
--  DDL for Procedure ACTIVAR_INACTIVAR_CLIENTE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."ACTIVAR_INACTIVAR_CLIENTE" (
    p_id_cliente NUMBER,
    p_estado VARCHAR2
)
AS
BEGIN
    IF p_estado = 'ACTIVO' THEN
        UPDATE Clientes
        SET Estado_cliente = 'ACTIVO'
        WHERE ID_cliente = p_id_cliente;
    ELSIF p_estado = 'INACTIVO' THEN
        UPDATE Clientes
        SET Estado_cliente = 'INACTIVO'
        WHERE ID_cliente = p_id_cliente;
    ELSE
        -- Manejar una opción inválida, si lo deseas
        RAISE_APPLICATION_ERROR(-20001, 'Estado inválido. Utilizar "ACTIVO" o "INACTIVO".');
    END IF;

    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure ACTUALIZAR_AUDITORIA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."ACTUALIZAR_AUDITORIA" (
    p_id_auditoria NUMBER,
    p_id_movimiento NUMBER,
    p_fecha DATE,
    p_resultado VARCHAR2
)
AS
BEGIN
    UPDATE Auditorias
    SET ID_movimiento = p_id_movimiento,
        Fecha = p_fecha,
        Resultado = p_resultado
    WHERE ID_auditoria = p_id_auditoria;
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure ACTUALIZAR_CLIENTE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."ACTUALIZAR_CLIENTE" (
    p_id_cliente NUMBER,
    p_nombre VARCHAR2,
    p_direccion VARCHAR2,
    p_telefono VARCHAR2,
    p_correo_electronico VARCHAR2
)
AS
BEGIN
    UPDATE Clientes
    SET Nombre = p_nombre,
        Direccion = p_direccion,
        Telefono = p_telefono,
        Correo_electronico = p_correo_electronico
    WHERE ID_cliente = p_id_cliente;
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure ACTUALIZAR_INVENTARIO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."ACTUALIZAR_INVENTARIO" (
    p_id_inventario NUMBER,
    p_id_producto NUMBER,
    p_cantidad_actual NUMBER
)
AS
BEGIN
    UPDATE Inventario
    SET ID_producto = p_id_producto,
        Cantidad_actual = p_cantidad_actual
    WHERE ID_inventario = p_id_inventario;
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure ACTUALIZAR_MOVIMIENTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."ACTUALIZAR_MOVIMIENTO" (
    p_id_movimiento NUMBER,
    p_id_producto NUMBER,
    p_tipo_movimiento VARCHAR2,
    p_cantidad NUMBER,
    p_fecha DATE
)
AS
BEGIN
    UPDATE Movimientos
    SET ID_producto = p_id_producto,
        Tipo_movimiento = p_tipo_movimiento,
        Cantidad = p_cantidad,
        Fecha = p_fecha
    WHERE ID_movimiento = p_id_movimiento;
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure ACTUALIZAR_PRECIO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."ACTUALIZAR_PRECIO" (
    p_id_precio NUMBER,
    p_id_producto NUMBER,
    p_precio_compra NUMBER,
    p_precio_venta NUMBER
)
AS
BEGIN
    UPDATE Precios
    SET ID_producto = p_id_producto,
        Precio_compra = p_precio_compra,
        Precio_venta = p_precio_venta
    WHERE ID_precio = p_id_precio;
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure ACTUALIZAR_PRODUCTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."ACTUALIZAR_PRODUCTO" (
    p_id_producto NUMBER,
    p_nombre VARCHAR2,
    p_descripcion VARCHAR2,
    p_codigo VARCHAR2,
    p_unidad_medida VARCHAR2
)
AS
BEGIN
    UPDATE Productos
    SET Nombre = p_nombre,
        Descripcion = p_descripcion,
        Codigo = p_codigo,
        Unidad_medida = p_unidad_medida
    WHERE ID_producto = p_id_producto;
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure ACTUALIZAR_VENTA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."ACTUALIZAR_VENTA" (
    p_id_venta IN NUMBER,
    p_cantidad IN NUMBER,
    p_id_producto IN NUMBER,
    p_id_cliente IN NUMBER,
    p_fecha_venta IN DATE
) AS
BEGIN
    UPDATE VENTAS
    SET CANTIDAD = p_cantidad,
        ID_PRODUCTO = p_id_producto,
        ID_CLIENTE = p_id_cliente,
        FECHA_VENTA = p_fecha_venta
    WHERE ID_VENTA = p_id_venta;
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure ELIMINAR_AUDITORIA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."ELIMINAR_AUDITORIA" (
    p_id_auditoria NUMBER
)
AS
BEGIN
    DELETE FROM Auditorias
    WHERE ID_auditoria = p_id_auditoria;
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure ELIMINAR_INVENTARIO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."ELIMINAR_INVENTARIO" (
    p_id_inventario NUMBER
)
AS
BEGIN
    DELETE FROM Inventario
    WHERE ID_inventario = p_id_inventario;
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure ELIMINAR_MOVIMIENTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."ELIMINAR_MOVIMIENTO" (
    p_id_movimiento NUMBER
)
AS
BEGIN
    DELETE FROM Movimientos
    WHERE ID_movimiento = p_id_movimiento;
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure ELIMINAR_PRECIO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."ELIMINAR_PRECIO" (
    p_id_precio NUMBER
)
AS
BEGIN
    DELETE FROM Precios
    WHERE ID_precio = p_id_precio;
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure ELIMINAR_PRODUCTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."ELIMINAR_PRODUCTO" (
    p_id_producto NUMBER
)
AS
BEGIN
    DELETE FROM Productos
    WHERE ID_producto = p_id_producto;
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure ELIMINAR_VENTA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."ELIMINAR_VENTA" (
    p_id_venta IN NUMBER
) AS
BEGIN
    DELETE FROM VENTAS
    WHERE ID_VENTA = p_id_venta;
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure INSERTAR_AUDITORIA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."INSERTAR_AUDITORIA" (
    p_id_auditoria NUMBER,
    p_id_movimiento NUMBER,
    p_fecha DATE,
    p_resultado VARCHAR2
)
AS
BEGIN
    INSERT INTO Auditorias (ID_auditoria, ID_movimiento, Fecha, Resultado)
    VALUES (p_id_auditoria, p_id_movimiento, p_fecha, p_resultado);
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure INSERTAR_CLIENTE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."INSERTAR_CLIENTE" (
    p_id_cliente NUMBER,
    p_nombre VARCHAR2,
    p_direccion VARCHAR2,
    p_telefono VARCHAR2,
    p_correo_electronico VARCHAR2
)
AS
BEGIN
    INSERT INTO Clientes (ID_cliente, Nombre, Direccion, Telefono, Correo_electronico)
    VALUES (p_id_cliente, p_nombre, p_direccion, p_telefono, p_correo_electronico);
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure INSERTAR_INVENTARIO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."INSERTAR_INVENTARIO" (
    p_id_inventario NUMBER,
    p_id_producto NUMBER,
    p_cantidad_actual NUMBER
)
AS
BEGIN
    INSERT INTO Inventario (ID_inventario, ID_producto, Cantidad_actual)
    VALUES (p_id_inventario, p_id_producto, p_cantidad_actual);
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure INSERTAR_MOVIMIENTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."INSERTAR_MOVIMIENTO" (
    p_id_movimiento NUMBER,
    p_id_producto NUMBER,
    p_tipo_movimiento VARCHAR2,
    p_cantidad NUMBER,
    p_fecha DATE
)
AS
BEGIN
    INSERT INTO Movimientos (ID_movimiento, ID_producto, Tipo_movimiento, Cantidad, Fecha)
    VALUES (p_id_movimiento, p_id_producto, p_tipo_movimiento, p_cantidad, p_fecha);
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure INSERTAR_PRECIO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."INSERTAR_PRECIO" (
    p_id_precio NUMBER,
    p_id_producto NUMBER,
    p_precio_compra NUMBER,
    p_precio_venta NUMBER
)
AS
BEGIN
    INSERT INTO Precios (ID_precio, ID_producto, Precio_compra, Precio_venta)
    VALUES (p_id_precio, p_id_producto, p_precio_compra, p_precio_venta);
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure INSERTAR_PRODUCTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."INSERTAR_PRODUCTO" (
    p_id_producto NUMBER,
    p_nombre VARCHAR2,
    p_descripcion VARCHAR2,
    p_codigo VARCHAR2,
    p_unidad_medida VARCHAR2
)
AS
BEGIN
    INSERT INTO Productos (ID_producto, Nombre, Descripcion, Codigo, Unidad_medida)
    VALUES (p_id_producto, p_nombre, p_descripcion, p_codigo, p_unidad_medida);
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure INSERTAR_VENTA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."INSERTAR_VENTA" (
    p_cantidad IN NUMBER,
    p_id_producto IN NUMBER,
    p_id_cliente IN NUMBER,
    p_fecha_venta IN DATE
) AS
BEGIN
    INSERT INTO VENTAS (ID_VENTA, CANTIDAD, ID_PRODUCTO, ID_CLIENTE, FECHA_VENTA)
    VALUES (SEQ_VENTAS.NEXTVAL, p_cantidad, p_id_producto, p_id_cliente, p_fecha_venta);
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure OBTENER_AUDITORIA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."OBTENER_AUDITORIA" (
    p_id_auditoria NUMBER,
    p_id_movimiento OUT NUMBER,
    p_fecha OUT DATE,
    p_resultado OUT VARCHAR2
)
AS
BEGIN
    SELECT ID_movimiento, Fecha, Resultado
    INTO p_id_movimiento, p_fecha, p_resultado
    FROM Auditorias
    WHERE ID_auditoria = p_id_auditoria;
END;

/
--------------------------------------------------------
--  DDL for Procedure OBTENER_CLIENTE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."OBTENER_CLIENTE" (
    p_id_cliente NUMBER,
    p_nombre OUT VARCHAR2,
    p_direccion OUT VARCHAR2,
    p_telefono OUT VARCHAR2,
    p_correo_electronico OUT VARCHAR2
)
AS
BEGIN
    SELECT Nombre, Direccion, Telefono, Correo_electronico
    INTO p_nombre, p_direccion, p_telefono, p_correo_electronico
    FROM Clientes
    WHERE ID_cliente = p_id_cliente;
END;

/
--------------------------------------------------------
--  DDL for Procedure OBTENER_INVENTARIO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."OBTENER_INVENTARIO" (
    p_id_inventario NUMBER,
    p_id_producto OUT NUMBER,
    p_cantidad_actual OUT NUMBER
)
AS
BEGIN
    SELECT ID_producto, Cantidad_actual
    INTO p_id_producto, p_cantidad_actual
    FROM Inventario
    WHERE ID_inventario = p_id_inventario;
END;

/
--------------------------------------------------------
--  DDL for Procedure OBTENER_MOVIMIENTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."OBTENER_MOVIMIENTO" (
    p_id_movimiento NUMBER,
    p_id_producto OUT NUMBER,
    p_tipo_movimiento OUT VARCHAR2,
    p_cantidad OUT NUMBER,
    p_fecha OUT DATE
)
AS
BEGIN
    SELECT ID_producto, Tipo_movimiento, Cantidad, Fecha
    INTO p_id_producto, p_tipo_movimiento, p_cantidad, p_fecha
    FROM Movimientos
    WHERE ID_movimiento = p_id_movimiento;
END;

/
--------------------------------------------------------
--  DDL for Procedure OBTENER_PRECIO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."OBTENER_PRECIO" (
    p_id_precio NUMBER,
    p_id_producto OUT NUMBER,
    p_precio_compra OUT NUMBER,
    p_precio_venta OUT NUMBER
)
AS
BEGIN
    SELECT ID_producto, Precio_compra, Precio_venta
    INTO p_id_producto, p_precio_compra, p_precio_venta
    FROM Precios
    WHERE ID_precio = p_id_precio;
END;

/
--------------------------------------------------------
--  DDL for Procedure OBTENER_PRODUCTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."OBTENER_PRODUCTO" (
    p_id_producto NUMBER,
    p_nombre OUT VARCHAR2,
    p_descripcion OUT VARCHAR2,
    p_codigo OUT VARCHAR2,
    p_unidad_medida OUT VARCHAR2
)
AS
BEGIN
    SELECT Nombre, Descripcion, Codigo, Unidad_medida
    INTO p_nombre, p_descripcion, p_codigo, p_unidad_medida
    FROM Productos
    WHERE ID_producto = p_id_producto;
END;

/
--------------------------------------------------------
--  DDL for Procedure OBTENER_VENTA_POR_ID
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "G9_USUARIO"."OBTENER_VENTA_POR_ID" (
    p_id_venta IN NUMBER,
    p_cantidad OUT NUMBER,
    p_id_producto OUT NUMBER,
    p_id_cliente OUT NUMBER,
    p_fecha_venta OUT DATE
) AS
BEGIN
    SELECT CANTIDAD, ID_PRODUCTO, ID_CLIENTE, FECHA_VENTA
    INTO p_cantidad, p_id_producto, p_id_cliente, p_fecha_venta
    FROM VENTAS
    WHERE ID_VENTA = p_id_venta;
END;

/
--------------------------------------------------------
--  DDL for Function BUSCAR_PRODUCTO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "G9_USUARIO"."BUSCAR_PRODUCTO" (
    p_nombre_o_codigo VARCHAR2
) RETURN SYS_REFCURSOR
AS
    v_resultados SYS_REFCURSOR;
BEGIN
    OPEN v_resultados FOR
        SELECT *
        FROM Productos
        WHERE Nombre LIKE '%' || p_nombre_o_codigo || '%'
           OR Codigo LIKE '%' || p_nombre_o_codigo || '%';

    RETURN v_resultados;
END;

/
--------------------------------------------------------
--  DDL for Function CALCULAR_MARGEN_BENEFICIO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "G9_USUARIO"."CALCULAR_MARGEN_BENEFICIO" (
    p_id_producto NUMBER
) RETURN NUMBER
AS
    v_margen NUMBER;
BEGIN
    SELECT (Precio_venta - Precio_compra) / Precio_compra * 100
    INTO v_margen
    FROM Precios
    WHERE ID_producto = p_id_producto;

    RETURN v_margen;
END;

/
--------------------------------------------------------
--  DDL for Function CALCULAR_TOTAL_INVENTARIO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "G9_USUARIO"."CALCULAR_TOTAL_INVENTARIO" (
    p_id_producto NUMBER
) RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT SUM(Cantidad_actual)
    INTO v_total
    FROM Inventario
    WHERE ID_producto = p_id_producto;

    RETURN v_total;
END;

/
--------------------------------------------------------
--  DDL for Function CALCULAR_VALOR_TOTAL_INVENTARIO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "G9_USUARIO"."CALCULAR_VALOR_TOTAL_INVENTARIO" RETURN NUMBER
AS
    v_valor_total NUMBER := 0;
    v_precio_compra NUMBER;
    v_cantidad_actual NUMBER;
BEGIN
    FOR item IN (SELECT i.Cantidad_actual, pr.Precio_compra
                 FROM Inventario i
                 JOIN Productos pr ON i.ID_producto = pr.ID_producto)
    LOOP
        v_cantidad_actual := item.Cantidad_actual;
        v_precio_compra := item.Precio_compra;
        v_valor_total := v_valor_total + (v_cantidad_actual * v_precio_compra);
    END LOOP;

    RETURN v_valor_total;
END;

/
--------------------------------------------------------
--  DDL for Function GENERAR_INFORME_VENTAS
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "G9_USUARIO"."GENERAR_INFORME_VENTAS" (
    p_fecha_inicio DATE,
    p_fecha_fin DATE
) RETURN SYS_REFCURSOR
AS
    v_resultados SYS_REFCURSOR;
BEGIN
    OPEN v_resultados FOR
        SELECT m.ID_movimiento, m.Fecha, p.Nombre AS Producto, m.Cantidad, pr.Precio_venta, m.Cantidad * pr.Precio_venta AS Total
        FROM Movimientos m
        JOIN Productos p ON m.ID_producto = p.ID_producto
        JOIN Precios pr ON m.ID_producto = pr.ID_producto
        WHERE m.Tipo_movimiento = 'Venta'
          AND m.Fecha BETWEEN p_fecha_inicio AND p_fecha_fin;

    RETURN v_resultados;
END;

/
--------------------------------------------------------
--  DDL for Function OBTENER_CLIENTES_FRECUENTES
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "G9_USUARIO"."OBTENER_CLIENTES_FRECUENTES" (
    p_fecha_inicio DATE,
    p_fecha_fin DATE
) RETURN SYS_REFCURSOR
AS
    v_resultados SYS_REFCURSOR;
BEGIN
    OPEN v_resultados FOR
        SELECT c.*
        FROM Clientes c
        WHERE c.ID_cliente IN (
            SELECT ID_cliente
            FROM Movimientos
            WHERE Tipo_movimiento = 'Venta'
              AND Fecha BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY ID_cliente
            HAVING COUNT(*) > 1
        )
        ORDER BY c.ID_cliente;

    RETURN v_resultados;
END;

/
--------------------------------------------------------
--  DDL for Function OBTENER_INFORMACION_PRODUCTO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "G9_USUARIO"."OBTENER_INFORMACION_PRODUCTO" (
    p_id_producto NUMBER
) RETURN Productos%ROWTYPE
AS
    v_producto Productos%ROWTYPE;
BEGIN
    SELECT *
    INTO v_producto
    FROM Productos
    WHERE ID_producto = p_id_producto;

    RETURN v_producto;
END;

/
--------------------------------------------------------
--  DDL for Function OBTENER_PRODUCTOS_BAJO_STOCK
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "G9_USUARIO"."OBTENER_PRODUCTOS_BAJO_STOCK" (
    p_limite_stock NUMBER
) RETURN SYS_REFCURSOR
AS
    v_resultados SYS_REFCURSOR;
BEGIN
    OPEN v_resultados FOR
        SELECT *
        FROM Productos p
        INNER JOIN Inventario i ON p.ID_producto = i.ID_producto
        WHERE i.Cantidad_actual < p_limite_stock;

    RETURN v_resultados;
END;

/
--------------------------------------------------------
--  DDL for Function OBTENER_VENTAS_POR_PERIODO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "G9_USUARIO"."OBTENER_VENTAS_POR_PERIODO" (
    p_fecha_inicio DATE,
    p_fecha_fin DATE
) RETURN SYS_REFCURSOR
AS
    v_resultados SYS_REFCURSOR;
BEGIN
    OPEN v_resultados FOR
        SELECT *
        FROM Movimientos
        WHERE Tipo_movimiento = 'Venta'
          AND Fecha BETWEEN p_fecha_inicio AND p_fecha_fin;

    RETURN v_resultados;
END;

/
--------------------------------------------------------
--  Constraints for Table AUDITORIAS
--------------------------------------------------------

  ALTER TABLE "G9_USUARIO"."AUDITORIAS" ADD PRIMARY KEY ("ID_AUDITORIA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9"  ENABLE;
--------------------------------------------------------
--  Constraints for Table CLIENTES
--------------------------------------------------------

  ALTER TABLE "G9_USUARIO"."CLIENTES" ADD PRIMARY KEY ("ID_CLIENTE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9"  ENABLE;
--------------------------------------------------------
--  Constraints for Table INVENTARIO
--------------------------------------------------------

  ALTER TABLE "G9_USUARIO"."INVENTARIO" ADD PRIMARY KEY ("ID_INVENTARIO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9"  ENABLE;
--------------------------------------------------------
--  Constraints for Table MOVIMIENTOS
--------------------------------------------------------

  ALTER TABLE "G9_USUARIO"."MOVIMIENTOS" ADD PRIMARY KEY ("ID_MOVIMIENTO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9"  ENABLE;
--------------------------------------------------------
--  Constraints for Table PRECIOS
--------------------------------------------------------

  ALTER TABLE "G9_USUARIO"."PRECIOS" ADD PRIMARY KEY ("ID_PRECIO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9"  ENABLE;
--------------------------------------------------------
--  Constraints for Table PRODUCTOS
--------------------------------------------------------

  ALTER TABLE "G9_USUARIO"."PRODUCTOS" ADD PRIMARY KEY ("ID_PRODUCTO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9"  ENABLE;
--------------------------------------------------------
--  Constraints for Table VENTAS
--------------------------------------------------------

  ALTER TABLE "G9_USUARIO"."VENTAS" MODIFY ("CANTIDAD" NOT NULL ENABLE);
  ALTER TABLE "G9_USUARIO"."VENTAS" MODIFY ("ID_PRODUCTO" NOT NULL ENABLE);
  ALTER TABLE "G9_USUARIO"."VENTAS" MODIFY ("ID_CLIENTE" NOT NULL ENABLE);
  ALTER TABLE "G9_USUARIO"."VENTAS" ADD PRIMARY KEY ("ID_VENTA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TBL_PROYECTO_G9"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table AUDITORIAS
--------------------------------------------------------

  ALTER TABLE "G9_USUARIO"."AUDITORIAS" ADD FOREIGN KEY ("ID_MOVIMIENTO")
	  REFERENCES "G9_USUARIO"."MOVIMIENTOS" ("ID_MOVIMIENTO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table INVENTARIO
--------------------------------------------------------

  ALTER TABLE "G9_USUARIO"."INVENTARIO" ADD FOREIGN KEY ("ID_PRODUCTO")
	  REFERENCES "G9_USUARIO"."PRODUCTOS" ("ID_PRODUCTO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table MOVIMIENTOS
--------------------------------------------------------

  ALTER TABLE "G9_USUARIO"."MOVIMIENTOS" ADD FOREIGN KEY ("ID_PRODUCTO")
	  REFERENCES "G9_USUARIO"."PRODUCTOS" ("ID_PRODUCTO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PRECIOS
--------------------------------------------------------

  ALTER TABLE "G9_USUARIO"."PRECIOS" ADD FOREIGN KEY ("ID_PRODUCTO")
	  REFERENCES "G9_USUARIO"."PRODUCTOS" ("ID_PRODUCTO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table VENTAS
--------------------------------------------------------

  ALTER TABLE "G9_USUARIO"."VENTAS" ADD FOREIGN KEY ("ID_PRODUCTO")
	  REFERENCES "G9_USUARIO"."PRODUCTOS" ("ID_PRODUCTO") ENABLE;
  ALTER TABLE "G9_USUARIO"."VENTAS" ADD FOREIGN KEY ("ID_CLIENTE")
	  REFERENCES "G9_USUARIO"."CLIENTES" ("ID_CLIENTE") ENABLE;
