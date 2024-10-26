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

-- cuidado al momento de crear la tabla usuario, si es necesario cambiar el nombre
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

--Insert valores por default

INSERT INTO ROL (id_rol, nombre, fecha_creacion, fecha_modificacion, usuario_creo, usuario_modifico)
VALUES (1, 'Admin', TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_DATE('2024-10-23', 'YYYY-MM-DD'), 'admin', 'admin');
INSERT INTO ROL (id_rol, nombre, fecha_creacion, fecha_modificacion, usuario_creo, usuario_modifico)
VALUES (2, 'Cliente', TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_DATE('2024-10-23', 'YYYY-MM-DD'), 'admin', 'admin');
INSERT INTO ROL (id_rol, nombre, fecha_creacion, fecha_modificacion, usuario_creo, usuario_modifico)
VALUES (3, 'Gestor', TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_DATE('2024-10-23', 'YYYY-MM-DD'),  'admin', 'admin');

INSERT INTO TIPO_PAGO (id_tipo_pago, descripcion, fecha_creacion, fecha_modificacion, usuario_creo, usuario_modifico)
VALUES (1, 'Efectivo', TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_DATE('2024-10-23', 'YYYY-MM-DD'),  'admin', 'admin');
INSERT INTO TIPO_PAGO (id_tipo_pago, descripcion, fecha_creacion, fecha_modificacion, usuario_creo, usuario_modifico)
VALUES (2, 'Tarjeta', TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_DATE('2024-10-23', 'YYYY-MM-DD'),  'admin', 'admin');

INSERT INTO TIPO_ESTADO_MOTOCICLETA (id_tipo_estado_motocicleta, descripcion, fecha_creacion, fecha_modificacion, usuario_creo, usuario_modifico)
VALUES (1, 'Disponible', TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_DATE('2024-10-23', 'YYYY-MM-DD'),  'admin', 'admin');
INSERT INTO TIPO_ESTADO_MOTOCICLETA (id_tipo_estado_motocicleta, descripcion, fecha_creacion, fecha_modificacion, usuario_creo, usuario_modifico)
VALUES (2, 'No Disponible', TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_DATE('2024-10-23', 'YYYY-MM-DD'),  'admin', 'admin');
INSERT INTO TIPO_ESTADO_MOTOCICLETA (id_tipo_estado_motocicleta, descripcion, fecha_creacion, fecha_modificacion, usuario_creo, usuario_modifico)
VALUES (3, 'Mantenimiento', TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_DATE('2024-10-23', 'YYYY-MM-DD'),  'admin', 'admin');

INSERT INTO TIPO_ESTADO_RESERVACION (id_tipo_estado_reservacion, descripcion, fecha_creacion, fecha_modificacion, usuario_creo, usuario_modifico)
VALUES (1, 'Confirmada', TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_DATE('2024-10-23', 'YYYY-MM-DD'),  'admin', 'admin');
INSERT INTO TIPO_ESTADO_RESERVACION (id_tipo_estado_reservacion, descripcion, fecha_creacion, fecha_modificacion, usuario_creo, usuario_modifico)
VALUES (2, 'Cancelada', TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_DATE('2024-10-23', 'YYYY-MM-DD'),  'admin', 'admin');

INSERT INTO METODO_RENTA (id_metodo_renta, descripcion, fecha_creacion, fecha_modificacion, usuario_creo, usuario_modifico)
VALUES (1, 'Kilometraje', TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_DATE('2024-10-23', 'YYYY-MM-DD'),  'admin', 'admin');
INSERT INTO METODO_RENTA (id_metodo_renta, descripcion, fecha_creacion, fecha_modificacion, usuario_creo, usuario_modifico)
VALUES (2, 'Kilometraje libre', TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_DATE('2024-10-23', 'YYYY-MM-DD'),  'admin', 'admin');
INSERT INTO METODO_RENTA (id_metodo_renta, descripcion, fecha_creacion, fecha_modificacion, usuario_creo, usuario_modifico)
VALUES (3, 'Fecha', TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_DATE('2024-10-23', 'YYYY-MM-DD'),  'admin', 'admin');

INSERT INTO PAGO_ESTADO (id_pago_estado, descripcion, fecha_creacion, fecha_modificacion, usuario_creo, usuario_modifico)
VALUES (1, 'Pagado', TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_DATE('2024-10-23', 'YYYY-MM-DD'),  'admin', 'admin');x
INSERT INTO PAGO_ESTADO (id_pago_estado, descripcion, fecha_creacion, fecha_modificacion, usuario_creo, usuario_modifico)
VALUES (2, 'Pendiente', TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_DATE('2024-10-23', 'YYYY-MM-DD'),  'admin', 'admin');



--- triggers Usuarios

CREATE OR REPLACE TRIGGER trg_persona_insert_update
BEFORE INSERT OR UPDATE ON PERSONA
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.id_persona  := persona_seq.NEXTVAL;
        IF :NEW.fecha_creacion IS NULL THEN
            :NEW.fecha_creacion := SYSDATE;
        END IF;
        IF :NEW.usuario_creo IS NULL THEN
            :NEW.usuario_creo := NVL(USER, USER);
        END IF;
    END IF;

    :NEW.fecha_modificacion := SYSDATE;

    IF :NEW.usuario_modifico IS NULL THEN
        :NEW.usuario_modifico := NVL(USER, USER);
    END IF;
    
END;

CREATE OR REPLACE TRIGGER trg_usuario_insert_update
BEFORE INSERT OR UPDATE ON USUARIO
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.id_usuario  := usuario_seq.NEXTVAL;
        IF :NEW.fecha_creacion IS NULL THEN
            :NEW.fecha_creacion := SYSDATE;
        END IF;
        IF :NEW.usuario_creo IS NULL THEN
            :NEW.usuario_creo := NVL(USER, USER);
        END IF;
    END IF;

    :NEW.fecha_modificacion := SYSDATE;

    IF :NEW.usuario_modifico IS NULL THEN
        :NEW.usuario_modifico := NVL(USER, USER);
    END IF;
END;


--TRIGGERS PARA BITACORA

CREATE OR REPLACE TRIGGER trg_rol
AFTER INSERT OR UPDATE OR DELETE ON ROL
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_nuevos, fecha_creacion, usuario_creo)
        VALUES (bitacora_seq.NEXTVAL, 'ROL', 'INSERT', 'Registro insertado en ROL', SYSTIMESTAMP,
                'ID: ' || :NEW.id_rol || ', Nombre: ' || :NEW.nombre,
                SYSDATE, :NEW.usuario_creo);

    ELSIF UPDATING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, datos_nuevos, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'ROL', 'UPDATE', 'Registro actualizado en ROL', SYSTIMESTAMP,
                'ID: ' || :OLD.id_rol || ', Nombre: ' || :OLD.nombre,
                'ID: ' || :NEW.id_rol || ', Nombre: ' || :NEW.nombre,
                SYSDATE, :NEW.usuario_modifico);

    ELSIF DELETING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'ROL', 'DELETE', 'Registro eliminado de ROL', SYSTIMESTAMP,
                'ID: ' || :OLD.id_rol || ', Nombre: ' || :OLD.nombre,
                SYSDATE, :OLD.usuario_modifico);
    END IF;
END;

CREATE OR REPLACE TRIGGER trg_persona
AFTER INSERT OR UPDATE OR DELETE ON PERSONA
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_nuevos, fecha_creacion, usuario_creo)
        VALUES (bitacora_seq.NEXTVAL, 'PERSONA', 'INSERT', 'Registro insertado en PERSONA', SYSTIMESTAMP,
                'ID: ' || :NEW.id_persona || ', Nombre: ' || :NEW.nombre || ', Apellido: ' || :NEW.apellido,
                SYSDATE, :NEW.usuario_creo);

    ELSIF UPDATING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, datos_nuevos, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'PERSONA', 'UPDATE', 'Registro actualizado en PERSONA', SYSTIMESTAMP,
                'ID: ' || :OLD.id_persona || ', Nombre: ' || :OLD.nombre || ', Apellido: ' || :OLD.apellido,
                'ID: ' || :NEW.id_persona || ', Nombre: ' || :NEW.nombre || ', Apellido: ' || :NEW.apellido,
                SYSDATE, :NEW.usuario_modifico);

    ELSIF DELETING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'PERSONA', 'DELETE', 'Registro eliminado de PERSONA', SYSTIMESTAMP,
                'ID: ' || :OLD.id_persona || ', Nombre: ' || :OLD.nombre || ', Apellido: ' || :OLD.apellido,
                SYSDATE, :OLD.usuario_modifico);
    END IF;
END;


CREATE OR REPLACE TRIGGER trg_usuario
AFTER INSERT OR UPDATE OR DELETE ON USUARIO
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_nuevos, fecha_creacion, usuario_creo)
        VALUES (bitacora_seq.NEXTVAL, 'USUARIO', 'INSERT', 'Registro insertado en USUARIO', SYSTIMESTAMP,
                'ID: ' || :NEW.id_usuario || ', Usuario: ' || :NEW.usuario || ', Correo: ' || :NEW.correo,
                SYSDATE, :NEW.usuario_creo);

    ELSIF UPDATING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, datos_nuevos, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'USUARIO', 'UPDATE', 'Registro actualizado en USUARIO', SYSTIMESTAMP,
                'ID: ' || :OLD.id_usuario || ', Usuario: ' || :OLD.usuario || ', Correo: ' || :OLD.correo,
                'ID: ' || :NEW.id_usuario || ', Usuario: ' || :NEW.usuario || ', Correo: ' || :NEW.correo,
                SYSDATE, :NEW.usuario_modifico);

    ELSIF DELETING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'USUARIO', 'DELETE', 'Registro eliminado de USUARIO', SYSTIMESTAMP,
                'ID: ' || :OLD.id_usuario || ', Usuario: ' || :OLD.usuario || ', Correo: ' || :OLD.correo,
                SYSDATE, :OLD.usuario_modifico);
    END IF;
END;

CREATE OR REPLACE TRIGGER trg_modelo
AFTER INSERT OR UPDATE OR DELETE ON MODELO
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_nuevos, fecha_creacion, usuario_creo)
        VALUES (bitacora_seq.NEXTVAL, 'MODELO', 'INSERT', 'Registro insertado en MODELO', SYSTIMESTAMP,
                'ID: ' || :NEW.id_modelo || ', Nombre: ' || :NEW.nombre || ', Año: ' || :NEW.anio,
                SYSDATE, :NEW.usuario_creo);

    ELSIF UPDATING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, datos_nuevos, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'MODELO', 'UPDATE', 'Registro actualizado en MODELO', SYSTIMESTAMP,
                'ID: ' || :OLD.id_modelo || ', Nombre: ' || :OLD.nombre || ', Año: ' || :OLD.anio,
                'ID: ' || :NEW.id_modelo || ', Nombre: ' || :NEW.nombre || ', Año: ' || :NEW.anio,
                SYSDATE, :NEW.usuario_modifico);

    ELSIF DELETING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'MODELO', 'DELETE', 'Registro eliminado de MODELO', SYSTIMESTAMP,
                'ID: ' || :OLD.id_modelo || ', Nombre: ' || :OLD.nombre || ', Año: ' || :OLD.anio,
                SYSDATE, :OLD.usuario_modifico);
    END IF;
END;


CREATE OR REPLACE TRIGGER trg_marca_modelo
AFTER INSERT OR UPDATE OR DELETE ON MARCA_MODELO
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_nuevos, fecha_creacion, usuario_creo)
        VALUES (bitacora_seq.NEXTVAL, 'MARCA_MODELO', 'INSERT', 'Registro insertado en MARCA_MODELO', SYSTIMESTAMP,
                'ID: ' || :NEW.id_marca || ', Nombre: ' || :NEW.nombre,
                SYSDATE, :NEW.usuario_creo);

    ELSIF UPDATING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, datos_nuevos, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'MARCA_MODELO', 'UPDATE', 'Registro actualizado en MARCA_MODELO', SYSTIMESTAMP,
                'ID: ' || :OLD.id_marca || ', Nombre: ' || :OLD.nombre,
                'ID: ' || :NEW.id_marca || ', Nombre: ' || :NEW.nombre,
                SYSDATE, :NEW.usuario_modifico);

    ELSIF DELETING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'MARCA_MODELO', 'DELETE', 'Registro eliminado de MARCA_MODELO', SYSTIMESTAMP,
                'ID: ' || :OLD.id_marca || ', Nombre: ' || :OLD.nombre,
                SYSDATE, :OLD.usuario_modifico);
    END IF;
END;

CREATE OR REPLACE TRIGGER trg_imagen
AFTER INSERT OR UPDATE OR DELETE ON IMAGEN
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_nuevos, fecha_creacion, usuario_creo)
        VALUES (bitacora_seq.NEXTVAL, 'IMAGEN', 'INSERT', 'Registro insertado en IMAGEN', SYSTIMESTAMP,
                'ID: ' || :NEW.id_imagen || ', Nombre: ' || :NEW.nombre || ', URL: ' || :NEW.url,
                SYSDATE, :NEW.usuario_creo);

    ELSIF UPDATING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, datos_nuevos, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'IMAGEN', 'UPDATE', 'Registro actualizado en IMAGEN', SYSTIMESTAMP,
                'ID: ' || :OLD.id_imagen || ', Nombre: ' || :OLD.nombre || ', URL: ' || :OLD.url,
                'ID: ' || :NEW.id_imagen || ', Nombre: ' || :NEW.nombre || ', URL: ' || :NEW.url,
                SYSDATE, :NEW.usuario_modifico);

    ELSIF DELETING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'IMAGEN', 'DELETE', 'Registro eliminado de IMAGEN', SYSTIMESTAMP,
                'ID: ' || :OLD.id_imagen || ', Nombre: ' || :OLD.nombre || ', URL: ' || :OLD.url,
                SYSDATE, :OLD.usuario_modifico);
    END IF;
END;


CREATE OR REPLACE TRIGGER trg_tipo_estado_motocicleta
AFTER INSERT OR UPDATE OR DELETE ON TIPO_ESTADO_MOTOCICLETA
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_nuevos, fecha_creacion, usuario_creo)
        VALUES (bitacora_seq.NEXTVAL, 'TIPO_ESTADO_MOTOCICLETA', 'INSERT', 'Registro insertado en TIPO_ESTADO_MOTOCICLETA', SYSTIMESTAMP,
                'ID: ' || :NEW.id_tipo_estado_motocicleta || ', Descripción: ' || :NEW.descripcion,
                SYSDATE, :NEW.usuario_creo);

    ELSIF UPDATING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, datos_nuevos, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'TIPO_ESTADO_MOTOCICLETA', 'UPDATE', 'Registro actualizado en TIPO_ESTADO_MOTOCICLETA', SYSTIMESTAMP,
                'ID: ' || :OLD.id_tipo_estado_motocicleta || ', Descripción: ' || :OLD.descripcion,
                'ID: ' || :NEW.id_tipo_estado_motocicleta || ', Descripción: ' || :NEW.descripcion,
                SYSDATE, :NEW.usuario_modifico);

    ELSIF DELETING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'TIPO_ESTADO_MOTOCICLETA', 'DELETE', 'Registro eliminado de TIPO_ESTADO_MOTOCICLETA', SYSTIMESTAMP,
                'ID: ' || :OLD.id_tipo_estado_motocicleta || ', Descripción: ' || :OLD.descripcion,
                SYSDATE, :OLD.usuario_modifico);
    END IF;
END;


CREATE OR REPLACE TRIGGER trg_motocicleta
AFTER INSERT OR UPDATE OR DELETE ON MOTOCICLETA
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_nuevos, fecha_creacion, usuario_creo)
        VALUES (bitacora_seq.NEXTVAL, 'MOTOCICLETA', 'INSERT', 'Registro insertado en MOTOCICLETA', SYSTIMESTAMP,
                'ID: ' || :NEW.id_motocicleta || ', Kilometraje: ' || :NEW.kilometraje || ', Cilindraje: ' || :NEW.cilindraje,
                SYSDATE, :NEW.usuario_creo);

    ELSIF UPDATING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, datos_nuevos, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'MOTOCICLETA', 'UPDATE', 'Registro actualizado en MOTOCICLETA', SYSTIMESTAMP,
                'ID: ' || :OLD.id_motocicleta || ', Kilometraje: ' || :OLD.kilometraje || ', Cilindraje: ' || :OLD.cilindraje,
                'ID: ' || :NEW.id_motocicleta || ', Kilometraje: ' || :NEW.kilometraje || ', Cilindraje: ' || :NEW.cilindraje,
                SYSDATE, :NEW.usuario_modifico);

    ELSIF DELETING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'MOTOCICLETA', 'DELETE', 'Registro eliminado de MOTOCICLETA', SYSTIMESTAMP,
                'ID: ' || :OLD.id_motocicleta || ', Kilometraje: ' || :OLD.kilometraje || ', Cilindraje: ' || :OLD.cilindraje,
                SYSDATE, :OLD.usuario_modifico);
    END IF;
END;


CREATE OR REPLACE TRIGGER trg_zona_geografica
AFTER INSERT OR UPDATE OR DELETE ON ZONA_GEOGRAFICA
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_nuevos, fecha_creacion, usuario_creo)
        VALUES (bitacora_seq.NEXTVAL, 'ZONA_GEOGRAFICA', 'INSERT', 'Registro insertado en ZONA_GEOGRAFICA', SYSTIMESTAMP,
                'ID: ' || :NEW.id_zona_geografica || ', Nombre Zona: ' || :NEW.nombre_zona || ', Ciudad: ' || :NEW.ciudad,
                SYSDATE, :NEW.usuario_creo);

    ELSIF UPDATING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, datos_nuevos, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'ZONA_GEOGRAFICA', 'UPDATE', 'Registro actualizado en ZONA_GEOGRAFICA', SYSTIMESTAMP,
                'ID: ' || :OLD.id_zona_geografica || ', Nombre Zona: ' || :OLD.nombre_zona || ', Ciudad: ' || :OLD.ciudad,
                'ID: ' || :NEW.id_zona_geografica || ', Nombre Zona: ' || :NEW.nombre_zona || ', Ciudad: ' || :NEW.ciudad,
                SYSDATE, :NEW.usuario_modifico);

    ELSIF DELETING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'ZONA_GEOGRAFICA', 'DELETE', 'Registro eliminado de ZONA_GEOGRAFICA', SYSTIMESTAMP,
                'ID: ' || :OLD.id_zona_geografica || ', Nombre Zona: ' || :OLD.nombre_zona || ', Ciudad: ' || :OLD.ciudad,
                SYSDATE, :OLD.usuario_modifico);
    END IF;
END;


CREATE OR REPLACE TRIGGER trg_inventario
AFTER INSERT OR UPDATE OR DELETE ON INVENTARIO
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_nuevos, fecha_creacion, usuario_creo)
        VALUES (bitacora_seq.NEXTVAL, 'INVENTARIO', 'INSERT', 'Registro insertado en INVENTARIO', SYSTIMESTAMP,
                'ID: ' || :NEW.id_inventario || ', Zona Geográfica: ' || :NEW.id_zona_geografica || ', Kilometraje: ' || :NEW.kilometraje,
                SYSDATE, :NEW.usuario_creo);

    ELSIF UPDATING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, datos_nuevos, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'INVENTARIO', 'UPDATE', 'Registro actualizado en INVENTARIO', SYSTIMESTAMP,
                'ID: ' || :OLD.id_inventario || ', Zona Geográfica: ' || :OLD.id_zona_geografica || ', Kilometraje: ' || :OLD.kilometraje,
                'ID: ' || :NEW.id_inventario || ', Zona Geográfica: ' || :NEW.id_zona_geografica || ', Kilometraje: ' || :NEW.kilometraje,
                SYSDATE, :NEW.usuario_modifico);

    ELSIF DELETING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'INVENTARIO', 'DELETE', 'Registro eliminado de INVENTARIO', SYSTIMESTAMP,
                'ID: ' || :OLD.id_inventario || ', Zona Geográfica: ' || :OLD.id_zona_geografica || ', Kilometraje: ' || :OLD.kilometraje,
                SYSDATE, :OLD.usuario_modifico);
    END IF;
END;


CREATE OR REPLACE TRIGGER trg_tipo_pago
AFTER INSERT OR UPDATE OR DELETE ON TIPO_PAGO
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_nuevos, fecha_creacion, usuario_creo)
        VALUES (bitacora_seq.NEXTVAL, 'TIPO_PAGO', 'INSERT', 'Registro insertado en TIPO_PAGO', SYSTIMESTAMP,
                'ID: ' || :NEW.id_tipo_pago || ', Descripción: ' || :NEW.descripcion,
                SYSDATE, :NEW.usuario_creo);

    ELSIF UPDATING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, datos_nuevos, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'TIPO_PAGO', 'UPDATE', 'Registro actualizado en TIPO_PAGO', SYSTIMESTAMP,
                'ID: ' || :OLD.id_tipo_pago || ', Descripción: ' || :OLD.descripcion,
                'ID: ' || :NEW.id_tipo_pago || ', Descripción: ' || :NEW.descripcion,
                SYSDATE, :NEW.usuario_modifico);

    ELSIF DELETING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'TIPO_PAGO', 'DELETE', 'Registro eliminado de TIPO_PAGO', SYSTIMESTAMP,
                'ID: ' || :OLD.id_tipo_pago || ', Descripción: ' || :OLD.descripcion,
                SYSDATE, :OLD.usuario_modifico);
    END IF;
END;


CREATE OR REPLACE TRIGGER trg_pago_estado
AFTER INSERT OR UPDATE OR DELETE ON PAGO_ESTADO
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_nuevos, fecha_creacion, usuario_creo)
        VALUES (bitacora_seq.NEXTVAL, 'PAGO_ESTADO', 'INSERT', 'Registro insertado en PAGO_ESTADO', SYSTIMESTAMP,
                'ID: ' || :NEW.id_pago_estado || ', Descripción: ' || :NEW.descripcion,
                SYSDATE, :NEW.usuario_creo);

    ELSIF UPDATING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, datos_nuevos, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'PAGO_ESTADO', 'UPDATE', 'Registro actualizado en PAGO_ESTADO', SYSTIMESTAMP,
                'ID: ' || :OLD.id_pago_estado || ', Descripción: ' || :OLD.descripcion,
                'ID: ' || :NEW.id_pago_estado || ', Descripción: ' || :NEW.descripcion,
                SYSDATE, :NEW.usuario_modifico);

    ELSIF DELETING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'PAGO_ESTADO', 'DELETE', 'Registro eliminado de PAGO_ESTADO', SYSTIMESTAMP,
                'ID: ' || :OLD.id_pago_estado || ', Descripción: ' || :OLD.descripcion,
                SYSDATE, :OLD.usuario_modifico);
    END IF;
END;


CREATE OR REPLACE TRIGGER trg_pago
AFTER INSERT OR UPDATE OR DELETE ON PAGO
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_nuevos, fecha_creacion, usuario_creo)
        VALUES (bitacora_seq.NEXTVAL, 'PAGO', 'INSERT', 'Registro insertado en PAGO', SYSTIMESTAMP,
                'ID: ' || :NEW.id_pago || ', Monto: ' || :NEW.monto || ', Fecha Pago: ' || :NEW.fecha_pago,
                SYSDATE, :NEW.usuario_creo);

    ELSIF UPDATING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, datos_nuevos, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'PAGO', 'UPDATE', 'Registro actualizado en PAGO', SYSTIMESTAMP,
                'ID: ' || :OLD.id_pago || ', Monto: ' || :OLD.monto || ', Fecha Pago: ' || :OLD.fecha_pago,
                'ID: ' || :NEW.id_pago || ', Monto: ' || :NEW.monto || ', Fecha Pago: ' || :NEW.fecha_pago,
                SYSDATE, :NEW.usuario_modifico);

    ELSIF DELETING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'PAGO', 'DELETE', 'Registro eliminado de PAGO', SYSTIMESTAMP,
                'ID: ' || :OLD.id_pago || ', Monto: ' || :OLD.monto || ', Fecha Pago: ' || :OLD.fecha_pago,
                SYSDATE, :OLD.usuario_modifico);
    END IF;
END;


CREATE OR REPLACE TRIGGER trg_metodo_renta
AFTER INSERT OR UPDATE OR DELETE ON METODO_RENTA
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_nuevos, fecha_creacion, usuario_creo)
        VALUES (bitacora_seq.NEXTVAL, 'METODO_RENTA', 'INSERT', 'Registro insertado en METODO_RENTA', SYSTIMESTAMP,
                'ID: ' || :NEW.id_metodo_renta || ', Descripción: ' || :NEW.descripcion,
                SYSDATE, :NEW.usuario_creo);

    ELSIF UPDATING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, datos_nuevos, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'METODO_RENTA', 'UPDATE', 'Registro actualizado en METODO_RENTA', SYSTIMESTAMP,
                'ID: ' || :OLD.id_metodo_renta || ', Descripción: ' || :OLD.descripcion,
                'ID: ' || :NEW.id_metodo_renta || ', Descripción: ' || :NEW.descripcion,
                SYSDATE, :NEW.usuario_modifico);

    ELSIF DELETING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'METODO_RENTA', 'DELETE', 'Registro eliminado de METODO_RENTA', SYSTIMESTAMP,
                'ID: ' || :OLD.id_metodo_renta || ', Descripción: ' || :OLD.descripcion,
                SYSDATE, :OLD.usuario_modifico);
    END IF;
END;


CREATE OR REPLACE TRIGGER trg_tipo_estado_reservacion
AFTER INSERT OR UPDATE OR DELETE ON TIPO_ESTADO_RESERVACION
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_nuevos, fecha_creacion, usuario_creo)
        VALUES (bitacora_seq.NEXTVAL, 'TIPO_ESTADO_RESERVACION', 'INSERT', 'Registro insertado en TIPO_ESTADO_RESERVACION', SYSTIMESTAMP,
                'ID: ' || :NEW.id_tipo_estado_reservacion || ', Descripción: ' || :NEW.descripcion,
                SYSDATE, :NEW.usuario_creo);

    ELSIF UPDATING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, datos_nuevos, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'TIPO_ESTADO_RESERVACION', 'UPDATE', 'Registro actualizado en TIPO_ESTADO_RESERVACION', SYSTIMESTAMP,
                'ID: ' || :OLD.id_tipo_estado_reservacion || ', Descripción: ' || :OLD.descripcion,
                'ID: ' || :NEW.id_tipo_estado_reservacion || ', Descripción: ' || :NEW.descripcion,
                SYSDATE, :NEW.usuario_modifico);

    ELSIF DELETING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'TIPO_ESTADO_RESERVACION', 'DELETE', 'Registro eliminado de TIPO_ESTADO_RESERVACION', SYSTIMESTAMP,
                'ID: ' || :OLD.id_tipo_estado_reservacion || ', Descripción: ' || :OLD.descripcion,
                SYSDATE, :OLD.usuario_modifico);
    END IF;
END;


CREATE OR REPLACE TRIGGER trg_reservacion
AFTER INSERT OR UPDATE OR DELETE ON RESERVACION
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_nuevos, fecha_creacion, usuario_creo)
        VALUES (bitacora_seq.NEXTVAL, 'RESERVACION', 'INSERT', 'Registro insertado en RESERVACION', SYSTIMESTAMP,
                'ID: ' || :NEW.id_reservacion || ', Usuario: ' || :NEW.id_usuario || ', Fecha Inicio: ' || :NEW.fecha_inicio,
                SYSDATE, :NEW.usuario_creo);

    ELSIF UPDATING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, datos_nuevos, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'RESERVACION', 'UPDATE', 'Registro actualizado en RESERVACION', SYSTIMESTAMP,
                'ID: ' || :OLD.id_reservacion || ', Usuario: ' || :OLD.id_usuario || ', Fecha Inicio: ' || :OLD.fecha_inicio,
                'ID: ' || :NEW.id_reservacion || ', Usuario: ' || :NEW.id_usuario || ', Fecha Inicio: ' || :NEW.fecha_inicio,
                SYSDATE, :NEW.usuario_modifico);

    ELSIF DELETING THEN
        INSERT INTO BITACORA (id_bitacora, tabla_afectada, tipo_operacion, detalle_de_accion, fecha_hora, datos_anteriores, fecha_modificacion, usuario_modifico)
        VALUES (bitacora_seq.NEXTVAL, 'RESERVACION', 'DELETE', 'Registro eliminado de RESERVACION', SYSTIMESTAMP,
                'ID: ' || :OLD.id_reservacion || ', Usuario: ' || :OLD.id_usuario || ', Fecha Inicio: ' || :OLD.fecha_inicio,
                SYSDATE, :OLD.usuario_modifico);
    END IF;
END;


--Vistas

--Muestra las motocicletas que estan actualmente reservadas mostrando las activas
CREATE VIEW Vista_Motocicletas_Disponibles AS
SELECT m.id_motocicleta, m.id_marca, m.cilindraje, m.capacidad, e.descripcion AS estado
FROM MOTOCICLETA m
JOIN TIPO_ESTADO_MOTOCICLETA e ON m.id_tipo_estado_motocicleta = e.id_tipo_estado_motocicleta
WHERE e.descripcion = 'Disponible';


--Muestra las reservaciones activas

CREATE VIEW Vista_Reservaciones_Activas AS
SELECT r.id_reservacion, p.nombre AS cliente, m.nombre AS modelo, r.fecha_inicio, r.fecha_fin
FROM RESERVACION r
JOIN USUARIO u ON r.id_usuario = u.id_usuario
JOIN PERSONA p ON u.id_persona = p.id_persona
JOIN INVENTARIO i ON r.id_inventario = i.id_inventario
JOIN MOTOCICLETA m ON i.id_motocicleta = m.id_motocicleta
WHERE r.id_tipo_estado_reservacion = 1;


--Funciones

--Esta Funcion permite hacer el calculo de la penalizacion 
CREATE OR REPLACE FUNCTION calcular_penalizacion(fecha_cancelacion DATE, fecha_inicio DATE) 
RETURN NUMBER IS
    penalizacion NUMBER;
BEGIN
    IF fecha_cancelacion >= (fecha_inicio - INTERVAL '36' HOUR) THEN
        penalizacion := 0;
    ELSE
        penalizacion := 0.1; --La penalizacion esta basada en un 10%
    END IF;
    RETURN penalizacion;
END;


--ROLES

CREATE ROLE ADMINISTRADOR;
CREATE ROLE CLIENTE; 
CREATE ROLE GESTOR;


--PERMISOS PARA ADMINISTRADOR
GRANT SELECT, INSERT, UPDATE, DELETE ON ROL TO ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON BITACORA TO ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON PERSONA TO ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON USUARIO TO ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON MODELO TO ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON MARCA_MODELO TO ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON IMAGEN TO ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON TIPO_ESTADO_MOTOCICLETA TO ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON MOTOCICLETA TO ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON ZONA_GEOGRAFICA TO ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON INVENTARIO TO ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON TIPO_PAGO TO ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON PAGO_ESTADO TO ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON PAGO TO ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON METODO_RENTA TO ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON TIPO_ESTADO_RESERVACION TO ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON RESERVACION TO ADMINISTRADOR;
GRANT EXECUTE ON calcular_penalizacion TO ADMINISTRADOR;
GRANT SELECT ON Vista_Motocicletas_Disponibles TO ADMINISTRADOR;
GRANT SELECT ON Vista_Reservaciones_Activas TO ADMINISTRADOR;


--PERMISOS PARA CLIENTE 
GRANT SELECT ON Vista_Motocicletas_Disponibles TO CLIENTE;
GRANT SELECT ON MARCA_MODELO TO CLIENTE;
GRANT SELECT, INSERT ON RESERVACION TO CLIENTE;  
GRANT SELECT, INSERT ON PAGO TO CLIENTE;          
GRANT SELECT ON TIPO_PAGO TO CLIENTE;
GRANT SELECT ON METODO_RENTA TO CLIENTE;


--PERMISOS PARA GESTOR
GRANT SELECT, INSERT, UPDATE ON MOTOCICLETA TO GESTOR;         
GRANT SELECT, INSERT, UPDATE ON INVENTARIO TO GESTOR;             
GRANT SELECT, INSERT, UPDATE ON ZONA_GEOGRAFICA TO GESTOR;        
GRANT SELECT, INSERT, UPDATE ON MARCA_MODELO TO GESTOR;           
GRANT SELECT ON TIPO_ESTADO_MOTOCICLETA TO GESTOR;               
GRANT SELECT ON Vista_Motocicletas_Disponibles TO GESTOR;
GRANT SELECT ON Vista_Reservaciones_Activas TO GESTOR;
GRANT SELECT ON PAGO TO GESTOR;                                   
GRANT SELECT ON METODO_RENTA TO GESTOR;
GRANT SELECT ON TIPO_PAGO TO GESTOR;
