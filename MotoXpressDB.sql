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



-- Script para base de datos para proyecto final en Oracle

CREATE SEQUENCE rol_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE bitacora_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE persona_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE usuario_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE modelo_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE marca_modelo_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE imagen_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE tipo_estado_motocicleta_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE motocicleta_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE zona_geografica_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE inventario_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE tipo_pago_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE pago_estado_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE pago_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE metodo_renta_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE tipo_estado_reservacion_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE reservacion_seq START WITH 1 INCREMENT BY 1;


CREATE TABLE ROL (
    id_rol NUMBER PRIMARY KEY,
    nombre VARCHAR2(50),

    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_creo VARCHAR2(50),
    usuario_modifico VARCHAR2(50)
);

CREATE TABLE BITACORA (
    id_bitacora NUMBER PRIMARY KEY,
    tabla_afectada VARCHAR2(50),
    tipo_operacion VARCHAR2(50),
    detalle_de_accion VARCHAR2(50),
    fecha_hora TIMESTAMP,
    datos_anteriores VARCHAR2(250),
    datos_nuevos VARCHAR2(250),

    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_creo VARCHAR2(50),
    usuario_modifico VARCHAR2(50)
);

CREATE TABLE PERSONA (
    id_persona NUMBER PRIMARY KEY,
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
    id_usuario NUMBER PRIMARY KEY,
    id_persona NUMBER,
    id_rol NUMBER,
    usuario VARCHAR2(100),
    correo VARCHAR2(100),
    contrasena VARCHAR2(100),

    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_creo VARCHAR2(50),
    usuario_modifico VARCHAR2(50),
    CONSTRAINT fk_usuario_persona FOREIGN KEY (id_persona) REFERENCES PERSONA(id_persona),
    CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) REFERENCES ROL(id_rol)
);

CREATE TABLE MODELO (
    id_modelo NUMBER PRIMARY KEY,
    nombre VARCHAR2(100),
    anio NUMBER,

    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_creo VARCHAR2(50),
    usuario_modifico VARCHAR2(50)
);

CREATE TABLE MARCA_MODELO (
    id_marca NUMBER PRIMARY KEY,
    id_modelo NUMBER,
    nombre VARCHAR2(100),

    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_creo VARCHAR2(50),
    usuario_modifico VARCHAR2(50),
    CONSTRAINT fk_marca_modelo FOREIGN KEY (id_modelo) REFERENCES MODELO(id_modelo)
);

CREATE TABLE IMAGEN (
    id_imagen NUMBER PRIMARY KEY,
    nombre VARCHAR2(100),
    url VARCHAR2(4000),

    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_creo VARCHAR2(50),
    usuario_modifico VARCHAR2(50)
);

CREATE TABLE TIPO_ESTADO_MOTOCICLETA (
    id_tipo_estado_motocicleta NUMBER PRIMARY KEY,
    descripcion VARCHAR2(1000),

    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_creo VARCHAR2(50),
    usuario_modifico VARCHAR2(50)
);

CREATE TABLE MOTOCICLETA (
    id_motocicleta NUMBER PRIMARY KEY,
    id_marca NUMBER,
    id_imagen NUMBER,
    id_tipo_estado_motocicleta NUMBER,
    kilometraje NUMBER,
    cilindraje NUMBER,
    capacidad NUMBER,

    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_creo VARCHAR2(50),
    usuario_modifico VARCHAR2(50),
    CONSTRAINT fk_motocicleta_marca FOREIGN KEY (id_marca) REFERENCES MARCA_MODELO(id_marca),
    CONSTRAINT fk_motocicleta_imagen FOREIGN KEY (id_imagen) REFERENCES IMAGEN(id_imagen),
    CONSTRAINT fk_motocicleta_estado FOREIGN KEY (id_tipo_estado_motocicleta) REFERENCES TIPO_ESTADO_MOTOCICLETA(id_tipo_estado_motocicleta)
);

CREATE TABLE ZONA_GEOGRAFICA (
    id_zona_geografica NUMBER PRIMARY KEY,
    nombre_zona VARCHAR2(100),
    codigo_postal NUMBER,
    region VARCHAR2(100),
    ciudad VARCHAR2(100),
    direccion VARCHAR2(100),

    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_creo VARCHAR2(50),
    usuario_modifico VARCHAR2(50)
);

CREATE TABLE INVENTARIO (
    id_inventario NUMBER PRIMARY KEY,
    id_zona_geografica NUMBER,
    id_motocicleta NUMBER,
    kilometraje NUMBER,
    fecha_disponibilidad DATE,

    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_creo VARCHAR2(50),
    usuario_modifico VARCHAR2(50),
    CONSTRAINT fk_zona_geografica FOREIGN KEY (id_zona_geografica) REFERENCES ZONA_GEOGRAFICA(id_zona_geografica),
    CONSTRAINT fk_motocicleta FOREIGN KEY (id_motocicleta) REFERENCES MOTOCICLETA(id_motocicleta)
);

CREATE TABLE TIPO_PAGO (
    id_tipo_pago NUMBER PRIMARY KEY,
    descripcion VARCHAR2(250),

    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_creo VARCHAR2(50),
    usuario_modifico VARCHAR2(50)
);

CREATE TABLE PAGO_ESTADO (
    id_pago_estado NUMBER PRIMARY KEY,
    descripcion VARCHAR2(250),

    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_creo VARCHAR2(50),
    usuario_modifico VARCHAR2(50)
);

CREATE TABLE PAGO (
    id_pago NUMBER PRIMARY KEY,
    id_tipo_pago NUMBER,
    id_pago_estado NUMBER,
    monto NUMBER,
    fecha_pago DATE,

    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_creo VARCHAR2(50),
    usuario_modifico VARCHAR2(50),
    CONSTRAINT fk_tipo_pago FOREIGN KEY (id_tipo_pago) REFERENCES TIPO_PAGO(id_tipo_pago),
    CONSTRAINT fk_pago_estado FOREIGN KEY (id_pago_estado) REFERENCES PAGO_ESTADO(id_pago_estado)
);

CREATE TABLE METODO_RENTA (
    id_metodo_renta NUMBER PRIMARY KEY,
    descripcion VARCHAR2(250),

    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_creo VARCHAR2(50),
    usuario_modifico VARCHAR2(50)
);

CREATE TABLE TIPO_ESTADO_RESERVACION (
    id_tipo_estado_reservacion NUMBER PRIMARY KEY,
    descripcion VARCHAR2(250),

    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_creo VARCHAR2(50),
    usuario_modifico VARCHAR2(50)
);

CREATE TABLE RESERVACION (
    id_reservacion NUMBER PRIMARY KEY,
    id_usuario NUMBER,
    id_tipo_estado_reservacion NUMBER,
    id_metodo_renta NUMBER,
    id_pago NUMBER,
    id_inventario NUMBER,
    fecha_inicio DATE,
    fecha_fin DATE,
    fecha_reservacion DATE,

    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_creo VARCHAR2(50),
    usuario_modifico VARCHAR2(50),
    CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    CONSTRAINT fk_tipo_estado_reservacion FOREIGN KEY (id_tipo_estado_reservacion) REFERENCES TIPO_ESTADO_RESERVACION(id_tipo_estado_reservacion),
    CONSTRAINT fk_metodo_renta FOREIGN KEY (id_metodo_renta) REFERENCES METODO_RENTA(id_metodo_renta),
    CONSTRAINT fk_pago FOREIGN KEY (id_pago) REFERENCES PAGO(id_pago),
    CONSTRAINT fk_inventario FOREIGN KEY (id_inventario) REFERENCES INVENTARIO(id_inventario)
);
