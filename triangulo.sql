/******************************************************************
  EJERCICIO COMPLETO: ESQUEMAS CLIENTES Y VENTAS
******************************************************************/

/******************************************************************
  1. CREAR ESQUEMAS (CONECTADO COMO SYSTEM)
******************************************************************/

-- Crear esquemas
CREATE USER C##CLIENTES IDENTIFIED BY "123";
CREATE USER C##VENTAS IDENTIFIED BY "123";

-- Permisos básicos
GRANT CREATE SESSION TO C##CLIENTES;
GRANT CREATE SESSION TO C##VENTAS;

GRANT CREATE TABLE TO C##CLIENTES;
GRANT CREATE TABLE TO C##VENTAS;

-- Espacio en tablespace
ALTER USER C##CLIENTES QUOTA UNLIMITED ON USERS;
ALTER USER C##VENTAS QUOTA UNLIMITED ON USERS;

------------------------------------------------------------------

/******************************************************************
  2. ESQUEMA CLIENTES
  (CONECTARSE COMO C##CLIENTES)
******************************************************************/

-- Crear tabla CLIENTES
CREATE TABLE CLIENTES (
    ID_CLIENTE NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(50),
    APELLIDOS VARCHAR2(80),
    DIRECCION VARCHAR2(100)
);

-- Insertar 2 clientes
INSERT INTO CLIENTES VALUES (1, 'JUAN', 'PEREZ LOPEZ', 'AV. LIMA 123');
INSERT INTO CLIENTES VALUES (2, 'MARIA', 'GOMEZ DIAZ', 'JR. PERU 456');

COMMIT;

------------------------------------------------------------------

/******************************************************************
  3. ESQUEMA VENTAS
  (CONECTARSE COMO C##VENTAS)
******************************************************************/

-- Crear tabla PRODUCTOS
CREATE TABLE PRODUCTOS (
    ID_PRODUCTO NUMBER PRIMARY KEY,
    NOMBRE_PRODUCTO VARCHAR2(100)
);

-- Crear tabla VENTAS
CREATE TABLE VENTAS (
    ID_VENTA NUMBER PRIMARY KEY,
    ID_CLIENTE NUMBER,
    ID_PRODUCTO NUMBER,
    MONTO NUMBER(8,2)
);

-- Insertar productos
INSERT INTO PRODUCTOS VALUES (1, 'LAPTOP');
INSERT INTO PRODUCTOS VALUES (2, 'MOUSE');

-- Insertar 4 ventas
INSERT INTO VENTAS VALUES (1, 1, 1, 2500);
INSERT INTO VENTAS VALUES (2, 1, 2, 80);
INSERT INTO VENTAS VALUES (3, 2, 1, 2400);
INSERT INTO VENTAS VALUES (4, 2, 2, 75);

COMMIT;

------------------------------------------------------------------

/******************************************************************
  4. OTORGAR PERMISOS ENTRE ESQUEMAS
  (CONECTARSE COMO SYSTEM)
******************************************************************/

-- Permitir que VENTAS consulte CLIENTES
GRANT SELECT ON C##CLIENTES.CLIENTES TO C##VENTAS;

------------------------------------------------------------------

/******************************************************************
  5. CONSULTA ENTRE ESQUEMAS
  (CONECTARSE COMO C##VENTAS)
******************************************************************/

-- Mostrar cliente y monto de ventas
SELECT 
    c.NOMBRE,
    c.APELLIDOS,
    v.MONTO
FROM VENTAS v
JOIN C##CLIENTES.CLIENTES c
    ON v.ID_CLIENTE = c.ID_CLIENTE;

------------------------------------------------------------------

/******************************************************************
  6. UNION (PRÁCTICA)
******************************************************************/

-- Unir nombres de productos y clientes
SELECT NOMBRE_PRODUCTO AS DESCRIPCION FROM PRODUCTOS
UNION
SELECT NOMBRE FROM C##CLIENTES.CLIENTES;

------------------------------------------------------------------

/******************************************************************
  7. USO DE DUAL
******************************************************************/

-- Mostrar fecha actual
SELECT SYSDATE AS FECHA_ACTUAL FROM DUAL;

-- Mostrar mensaje
SELECT 'PRACTICA ORACLE' AS MENSAJE FROM DUAL;

------------------------------------------------------------------

/******************************************************************
  8. OBJETO CON MÉTODO (PL/SQL)
******************************************************************/

-- Crear tipo objeto
CREATE OR REPLACE TYPE PERSONA_OBJ AS OBJECT (
    NOMBRE VARCHAR2(50),
    PROCEDURE IMPRIMIR
);
/

-- Cuerpo del objeto
CREATE OR REPLACE TYPE BODY PERSONA_OBJ AS
    PROCEDURE IMPRIMIR IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || NOMBRE);
    END;
END;
/

-- Usar el objeto
DECLARE
    p PERSONA_OBJ := PERSONA_OBJ('JUAN');
BEGIN
    p.IMPRIMIR;
END;
/

------------------------------------------------------------------

/******************************************************************
  9. CÁLCULO DEL ÁREA DE UN TRIÁNGULO
******************************************************************/

DECLARE
    base NUMBER := 10;
    altura NUMBER := 5;
    area NUMBER;
BEGIN
    area := (base * altura) / 2;
    DBMS_OUTPUT.PUT_LINE('Área del triángulo: ' || area);
END;
/
