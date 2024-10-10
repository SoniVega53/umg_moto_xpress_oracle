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
