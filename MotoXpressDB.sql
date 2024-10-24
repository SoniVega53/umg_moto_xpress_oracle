CREATE TABLE usuarios (
    id_usuario NUMBER PRIMARY KEY,
    nombre_usuario VARCHAR2(50) NOT NULL,
    contrasena VARCHAR2(255) NOT NULL,
    rol VARCHAR2(20) CHECK (rol IN ('admin', 'cliente','gestor')) NOT NULL,
    fecha_registro DATE DEFAULT SYSDATE NOT NULL
);

CREATE SEQUENCE seq_usuarios
MINVALUE 1
MAXVALUE 99999999999999999999999999999999
INCREMENT BY 1
START WITH 1
CACHE 1
NOORDER 
NOCYCLE;

CREATE OR REPLACE TRIGGER insert_user_trigger
BEFORE INSERT ON usuarios
FOR EACH ROW
DECLARE
    count_v NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count_v
    FROM usuarios
    WHERE nombre_usuario = :NEW.nombre_usuario;

    IF count_v = 0 THEN
        :NEW.fecha_registro := SYSDATE;
        :NEW.id_usuario := seq_usuarios.NEXTVAL;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'El usuario ya existe.');
    END IF;
END;



--NO se como implementar lo que hiciste arriba entonces voy a empzar desde cero para realizar lo basico del script
--Script para base de datos para proyecto final.

CREATE DATABASE BD_ProyectoFinal;
use BD_ProyectoFinal;


 /* 
 CREATE TABLE NOMBRE (

fecha_creacion DATE,
fecha_modificacion DATE,
usuario_creo VARCHAR2(50),
usuario_modifico VARCHAR2(50)
);

*/


create table ROL (
id_rol INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR2(50),

fecha_creacion DATE,
fecha_modificacion DATE,
usuario_creo VARCHAR2(50),
usuario_modifico VARCHAR2(50)
);

CREATE TABLE BITACORA (
id_bitacora INT AUTO_INCREMENT PRIMARY KEY,
tabla_afectada VARCHAR2(50),
tipo_operacion VARCHAR2(50),
detalle_de_accion VARCHAR2(50),
fecha_hora DATETIME,
datos_anteriores VARCHAR2(250),
datos_nuevos VARCHAR2(250),

fecha_creacion DATE,
fecha_modificacion DATE,
usuario_creo VARCHAR2(50),
usuario_modifico VARCHAR2(50)
);


CREATE TABLE PERSONA (
id_persona INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR2(100),
apellido VARCHAR2(100),
telefono VARCHAR2(100),
direccion VARCHAR2(250),

fecha_creacion DATE,
fecha_modificacion DATE,
usuario_creo VARCHAR2(50),
usuario_modifico VARCHAR2(50)
);

CREATE TABLE USUARIO (
id_usuario INT AUTO_INCREMENT PRIMARY KEY,
id_persona INT,
id_ rol INT,
usuario VARCHAR2(100),
correo VARCHAR2(100),
contrasena VARCHAR2(100),

fecha_creacion DATE,
fecha_modificacion DATE,
usuario_creo VARCHAR2(50),
usuario_modifico VARCHAR2(50)
FOREIGN KEY (id_rol) REFERENCES ROL(id_rol),
FOREIGN KEY (id_persona) REFERENCES PERSONA(id_persona)
 );


 CREATE TABLE MODELO (
id_modelo INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR2(100),
anio INT,

fecha_creacion DATE,
fecha_modificacion DATE,
usuario_creo VARCHAR2(50),
usuario_modifico VARCHAR2(50)
);


CREATE TABLE MARCA_MODELO (
id_marca INT AUTO_INCREMENT PRIMARY KEY,
id_modelo INT,
nombre VARCHAR2(100),

fecha_creacion DATE,
fecha_modificacion DATE,
usuario_creo VARCHAR2(50),
usuario_modifico VARCHAR2(50)
FOREIGN KEY (id_modelo) REFERENCES MODELO(id_modelo)
);

CREATE TABLE IMAGEN (
id_imagen INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR2(100),
url  VARCHAR2(4000),

fecha_creacion DATE,
fecha_modificacion DATE,
usuario_creo VARCHAR2(50),
usuario_modifico VARCHAR2(50)
);

 CREATE TABLE TIPO_ESTADO_MOTOCICLETA (
id_tipo_estado_motocicleta INT AUTO_INCREMENT PRIMARY KEY,
descripcion VARCHAR2(1000),

fecha_creacion DATE,
fecha_modificacion DATE,
usuario_creo VARCHAR2(50),
usuario_modifico VARCHAR2(50)
);


CREATE TABLE MOTOCICLETA (
id_motocicleta INT AUTO_INCREMENT PRIMARY KEY,
id_marca INT,
id_imagen INT,
id_tipo_estado_motocicleta INT,
kilometraje INT,
cilindraje INT,
capacidad INT,

fecha_creacion DATE,
fecha_modificacion DATE,
usuario_creo VARCHAR2(50),
usuario_modifico VARCHAR2(50)
FOREIGN KEY (id_marca) REFERENCES MARCA_MODELO(id_marca),
FOREIGN KEY (id_imagen) REFERENCES IMAGEN(id_imagen),
FOREIGN KEY (id_tipo_estado_motocicleta) REFERENCES TIPO_ESTADO_MOTOCICLETA(id_tipo_estado_motocicleta)
);

