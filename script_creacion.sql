DROP DATABASE IF EXISTS ProyectoDojo;
CREATE DATABASE ProyectoDojo;
USE ProyectoDojo;


-- eliminación tablas
DROP TABLE IF EXISTS Pagos;
DROP TABLE IF EXISTS InfosSanitarias;
DROP TABLE IF EXISTS Anuncios;
DROP TABLE IF EXISTS Observaciones;
DROP TABLE IF EXISTS Asistencias;
DROP TABLE IF EXISTS Sesiones;
DROP TABLE IF EXISTS Senseis;
DROP TABLE IF EXISTS Grados;
DROP TABLE IF EXISTS AlumnosGrupos;
DROP TABLE IF EXISTS Alumnos;
DROP TABLE IF EXISTS Grupos;
DROP TABLE IF EXISTS Temporadas;
DROP TABLE IF EXISTS TutoresLegales;
DROP TABLE IF EXISTS Domicilios;
DROP TABLE IF EXISTS Personas;


-- creación tablas
CREATE TABLE Personas (
    personaId INT PRIMARY KEY AUTO_INCREMENT,
    telefono INT,
    correo VARCHAR(255),
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL
);

CREATE TABLE Domicilios (
    domicilioId INT PRIMARY KEY AUTO_INCREMENT,
    direccion VARCHAR(255) NOT NULL,
    municipio VARCHAR(100) NOT NULL,
    cp INT NOT NULL
);

CREATE TABLE TutoresLegales (
    tutorId INT PRIMARY KEY AUTO_INCREMENT,
    correoAlternativo VARCHAR(255),
    parentesco VARCHAR(50) NOT NULL,
    personaId INT NOT NULL,
    FOREIGN KEY (personaId) REFERENCES Personas(personaId) ON DELETE CASCADE
);

CREATE TABLE Temporadas (
    temporadaId INT PRIMARY KEY AUTO_INCREMENT,
    temporada VARCHAR(9) 
);

CREATE TABLE Grupos (
    grupoId INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    limiteAlumnos INT NOT NULL CHECK (limiteAlumnos >= 0),
    categoria VARCHAR(100) NOT NULL CHECK (categoria IN ("Alevín-Infantil", "Juvenil-Adulto")),
    ubicacion VARCHAR(100) NOT NULL,
    precioMes INT NOT NULL,
    UNIQUE (nombre,ubicacion)
);

CREATE TABLE Alumnos (
    alumnoId INT PRIMARY KEY AUTO_INCREMENT,
    razonInscripcion TEXT,
    fechaNacimiento DATE NOT NULL,
    codigoFederativo INT UNIQUE,
    dni VARCHAR(15) UNIQUE,
    clausulaPDD BOOLEAN NOT NULL,
    domicilioId INT NOT NULL,
    FOREIGN KEY (domicilioId) REFERENCES Domicilios(domicilioId),
    personaId INT NOT NULL,
    FOREIGN KEY (personaId) REFERENCES Personas(personaId) ON DELETE CASCADE,
    tutorId INT,
    FOREIGN KEY (tutorId) REFERENCES TutoresLegales(tutorId)
);

CREATE TABLE AlumnosGrupos (
    alumnosGruposId INT PRIMARY KEY AUTO_INCREMENT,
    alumnoId INT NOT NULL,
    FOREIGN KEY (alumnoId) REFERENCES Alumnos(alumnoId),
    grupoId INT NOT NULL,
    FOREIGN KEY (grupoId) REFERENCES Grupos(grupoId),
    esLista BOOLEAN NOT NULL,
    temporada INT NOT NULL,
    FOREIGN KEY (temporada) REFERENCES Temporadas(temporadaId)
);

CREATE TABLE Grados (
    gradoId INT PRIMARY KEY AUTO_INCREMENT,
    gradoCinturon VARCHAR(50) NOT NULL CHECK (gradoCinturon IN (
        "Blanco",
        "Blanco-Amarillo",
        "Amarillo",
        "Amarillo-Naranja",
        "Naranja",
        "Naranja-Verde",
        "Verde",
        "Verde-Azul",
        "Azul",
        "Marrón",
        "Negro",
        "Negro 1ºDan",
        "Negro 2ºDan",
        "Negro 3ºDan",
        "Negro 4ºDan",
        "Negro 5ºDan",
        "Negro 6ºDan",
        "Negro 7ºDan",
        "Negro 8ºDan",
        "Negro 9ºDan",
        "Negro 10ºDan"
    )),
    fechaInicio DATE NOT NULL DEFAULT CURDATE(),
    fechaFin DATE DEFAULT NULL,
    fechaLicencia DATE DEFAULT NULL,
    alumnoId INT NOT NULL,
    FOREIGN KEY (alumnoId) REFERENCES Alumnos(alumnoId) ON DELETE CASCADE,
);

CREATE TABLE Senseis (
    senseiId INT PRIMARY KEY AUTO_INCREMENT,
    personaId INT NOT NULL,
    FOREIGN KEY (personaId) REFERENCES Personas(personaId) ON DELETE CASCADE
);

CREATE TABLE Sesiones (
    sesionId INT PRIMARY KEY AUTO_INCREMENT,
    fechaHora DATETIME NOT NULL,
    duracionMin INT NOT NULL DEFAULT 60, 
    temporada INT NOT NULL,
    FOREIGN KEY (temporada) REFERENCES Temporadas(temporadaId),
    grupoId INT NOT NULL,
    FOREIGN KEY (grupoId) REFERENCES Grupos(grupoId) ON DELETE CASCADE
);

CREATE TABLE Asistencias (
    asistenciaId INT PRIMARY KEY AUTO_INCREMENT,
    alumnoPresente BOOLEAN NOT NULL,
    alumnoId INT NOT NULL,
    FOREIGN KEY (alumnoId) REFERENCES Alumnos(alumnoId) ON DELETE CASCADE,
    sesionId INT NOT NULL,
    FOREIGN KEY (sesionId) REFERENCES Sesiones(sesionId) ON DELETE CASCADE
);

CREATE TABLE Observaciones (
    observacionId INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    argumento VARCHAR(100),
    alumnoId INT NOT NULL,
    FOREIGN KEY (alumnoId) REFERENCES Alumnos(alumnoId) ON DELETE CASCADE,
    senseiId INT NOT NULL,    
    FOREIGN KEY (senseiId) REFERENCES Senseis(senseiId) ON DELETE CASCADE
);

CREATE TABLE Anuncios (
    anuncioId INT PRIMARY KEY AUTO_INCREMENT,
    asunto VARCHAR(255) NOT NULL,
    fechaHora DATE NOT NULL DEFAULT CURDATE(),
    descripcion TEXT NOT NULL,
    senseiId INT NOT NULL,
    FOREIGN KEY (senseiId) REFERENCES Senseis(senseiId) ON DELETE CASCADE
);

CREATE TABLE InfosSanitarias (
    infoSanitariaId INT PRIMARY KEY AUTO_INCREMENT,
    argumento TEXT NOT NULL,
    alumnoId INT NOT NULL,
    FOREIGN KEY (alumnoId) REFERENCES Alumnos(alumnoId) ON DELETE CASCADE
);

CREATE TABLE Pagos (
    pagoId INT PRIMARY KEY AUTO_INCREMENT,
    cantidad DECIMAL(5,2) NOT NULL,
    fecha DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    metodo VARCHAR(20) NOT NULL CHECK (metodo IN (
        "Efectivo",
        "Transferencia bancaria",
        "PayPal",
        "Bizum"
    )),
    financiamiento VARCHAR(30) NOT NULL CHECK (financiamiento IN (
        "Inicial",
        "Mensual",
        "Bimensual"
    )),
    alumnoId INT NOT NULL,
    FOREIGN KEY (alumnoId) REFERENCES Alumnos(alumnoId) ON DELETE CASCADE
);

DELIMITER //


-- función duracion grado
CREATE OR REPLACE FUNCTION getDuracion(
    IN a_fechaInicio DATE,
    IN a_fechaFin DATE
)
RETURNS INT
BEGIN
    DECLARE duracion INT;
    DECLARE fechaLimite DATE;

    IF a_fechaFin IS NULL THEN
        SET fechaLimite = CURDATE();
    ELSE
        SET fechaLimite = a_fechaFin;
    END IF;

    SET duracion = TIMESTAMPDIFF(MONTH, a_fechaInicio, fechaLimite);
    RETURN duracion;
END //


-- función cumple tiempo mínimo
CREATE OR REPLACE FUNCTION getTiempoMin(
    IN a_gradoCinturon VARCHAR(50),
    IN a_fechaInicio DATE,
    IN a_fechaFIn DATE
)
RETURNS BOOLEAN
BEGIN
    DECLARE cumpleTMin BOOLEAN;
    DECLARE fechaLimite DATE;

    IF(a_fechaFin IS NULL) THEN
        SET fechaLimite = CURDATE();
    ELSE
        SET fechaLimite = a_fechaFin;
    END IF;
    
    IF(a_gradoCinturon='Negro 1ºDan') THEN
        SET cumpleTMin = TIMESTAMPDIFF(YEAR,a_fechaInicio,fechaLimite)>=2;
    ELSEIF(a_gradoCinturon='Negro 2ºDan') THEN
        SET cumpleTMin = TIMESTAMPDIFF(YEAR,a_fechaInicio,fechaLimite)>=3;
    ELSEIF(a_gradoCinturon='Negro 3ºDan') THEN
        SET cumpleTMin = TIMESTAMPDIFF(YEAR,a_fechaInicio,fechaLimite)>=4;
    ELSEIF(a_gradoCinturon='Negro 4ºDan') THEN
        SET cumpleTMin = TIMESTAMPDIFF(YEAR,a_fechaInicio,fechaLimite)>=5;
    ELSEIF(a_gradoCinturon='Negro 5ºDan') THEN
        SET cumpleTMin = TIMESTAMPDIFF(YEAR,a_fechaInicio,fechaLimite)>=6;
    ELSEIF(a_gradoCinturon='Negro 6ºDan') THEN
        SET cumpleTMin = TIMESTAMPDIFF(YEAR,a_fechaInicio,fechaLimite)>=7;
    ELSEIF(a_gradoCinturon='Negro 7ºDan') THEN
        SET cumpleTMin = TIMESTAMPDIFF(YEAR,a_fechaInicio,fechaLimite)>=8;
    ELSEIF(a_gradoCinturon='Negro 8ºDan') THEN
        SET cumpleTMin = TIMESTAMPDIFF(YEAR,a_fechaInicio,fechaLimite)>=9;
    ELSEIF(a_gradoCinturon='Negro 9ºDan') THEN
        SET cumpleTMin = TIMESTAMPDIFF(YEAR,a_fechaInicio,fechaLimite)>=10;
    ELSEIF(a_gradoCinturon='Negro 10ºDan') THEN
        SET cumpleTMin = TRUE;
    ELSE
        SET cumpleTMin = TIMESTAMPDIFF(YEAR,a_fechaInicio,fechaLimite)>=1;
    END IF;

    RETURN cumpleTMin;
END //

-- estado anuncio 
-- si fechaHora anterior curdate(): estado=sin publicar
-- si fechaHora => curdate(): estado=publicado
CREATE OR REPLACE FUNCTION getEstadoAnuncio(
    IN a_fechaHora DATE
)
RETURNS VARCHAR(50)
BEGIN
    DECLARE estado VARCHAR(50);

    IF(a_fechaHora>=CURDATE()) THEN
        SET estado = 'Publicado';
    ELSE
        SET estado = 'Sin publicar';
    END IF;
    
    RETURN estado;
END //


-- función obtener temporada
CREATE FUNCTION getTemporada(
    IN fecha DATE
)
RETURNS VARCHAR(9)
DETERMINISTIC
BEGIN
  DECLARE inicio INT;
  DECLARE fin INT;

  IF MONTH(fecha) >= 9 THEN
    SET inicio = YEAR(fecha);
    SET fin = YEAR(fecha) + 1;
  ELSE
    SET inicio = YEAR(fecha) - 1;
    SET fin = YEAR(fecha);
  END IF;

  RETURN CONCAT(inicio,'-',fin);
END //


-- función estado alumno
-- activo: si grupoId en temporada actual
-- inactivo: si no grupoId en temporada actual
CREATE OR REPLACE FUNCTION getEstadoAlumno(
    IN a_id INT,
    IN g_id INT
)
RETURNS VARCHAR(50)
BEGIN
    DECLARE estado VARCHAR(50);
    DECLARE a_alumnoId INT;

    SELECT alumnoId
    INTO a_alumnoId
    FROM AlumnosGrupos
    WHERE alumnoId = a_id AND temporada = getTemporada(CURDATE())
    ORDER BY alumnoId
    LIMIT 1;

    IF(a_alumnoId = a_id) THEN
        SET estado = 'Activo';
    ELSE
        SET estado = 'Inactivo';
    END IF;

    RETURN estado;
END //


-- procedimiento crear personas
CREATE OR REPLACE PROCEDURE insertarPersona(
    IN p_id INT DEFAULT NULL,
    IN p_nombre VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_correo VARCHAR(255),
    IN p_telefono INT
)
BEGIN
    IF p_id IS NULL THEN
        INSERT INTO Personas (nombre, apellidos, telefono, correo)
        VALUES (p_nombre, p_apellidos, p_telefono, p_correo);
    ELSE
        INSERT INTO Personas (personaId, nombre, apellidos, telefono, correo)
        VALUES (p_id, p_nombre, p_apellidos, p_telefono, p_correo);
    END IF;
END //


-- prodecimiento crear domicilio
CREATE OR REPLACE PROCEDURE insertarDomicilio(
    IN d_id INT DEFAULT NULL,
    IN d_direccion VARCHAR(255),
    IN d_municipio VARCHAR(100),
    IN d_cp INT
)
BEGIN
    IF d_id IS NULL THEN
        INSERT INTO Domicilios (direccion, municipio, cp)
        VALUES (d_direccion, d_municipio, d_cp);
    ELSE
        INSERT INTO Domicilios (domicilioId, direccion, municipio, cp)
        VALUES (d_ip, d_direccion, d_municipio, d_cp);
    END IF;
END //


-- prodecimiento crear tutor legal
CREATE OR REPLACE PROCEDURE insertarTutorLegal(
    IN t_id INT DEFAULT NULL,
    IN t_correoAlternativo VARCHAR(255),
    IN t_parentesco VARCHAR(50),
    IN t_personaId INT
)
BEGIN
    IF t_id IS NULL THEN
        INSERT INTO TutoresLegales (correoAlternativo, parentesco, personaId)
        VALUES (t_correoAlternativo, t_parentesco, t_personaId);
    ELSE
        INSERT INTO TutoresLegales (tutorId, correoAlternativo, parentesco, personaId)
        VALUES (t_id, t_correoAlternativo, t_parentesco, t_personaId);
    END IF;
END //

CREATE OR REPLACE PROCEDURE insertarTutorLegalYPersona(
    IN p_id INT DEFAULT NULL,
    IN t_id INT DEFAULT NULL,
    IN p_nombre VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_telefono INT,
    IN p_correo VARCHAR(255),
    IN t_correoAlternativo VARCHAR(255),
    IN t_parentesco VARCHAR(50)
)
BEGIN
    CALL insertarPersona(
       p_id,
       p_nombre,
       p_apellidos,
       p_correo,
       p_telefono
    );
    CALL insertarTutorLegal(
        t_id,
        t_correoAlternativo,
        t_parentesco,
        LAST_INSERT_ID()
    );
END //


-- procedimiento crear temporada
CREATE OR REPLACE PROCEDURE insertarTemporada(
    IN t_id INT DEFAULT NULL,
    IN temp VARCHAR(9)
)
BEGIN
    IF t_id IS NULL THEN
        INSERT INTO Temporadas(temporada)
        VALUES(temp);
    ELSE
        INSERT INTO Temporadas(temporadaId, temporada)
        VALUES(t_id, temp);
    END IF;
END //


-- procedimiento crear grupo
CREATE OR REPLACE PROCEDURE insertarGrupo(
    IN g_id INT DEFAULT NULL,
    IN g_nombre VARCHAR(100),
    IN g_ubicacion VARCHAR(100),
    IN g_categoria VARCHAR(100),
    IN g_limiteAlumnos INT,
    IN g_precioMes INT
)
BEGIN
    IF g_Id is NULL THEN
        INSERT INTO Grupos(nombre, ubicacion, categoria, limiteAlumnos, precioMes)
        VALUES (g_nombre, g_ubicacion, g_categoria, g_limiteAlumnos, g_precioMes);
    ELSE
        INSERT INTO Grupos(grupoId, nombre, ubicacion, categoria, limiteAlumnos, precioMes)
        VALUES (g_id, g_nombre, g_ubicacion, g_categoria, g_limiteAlumnos, g_precioMes);
    end if;
END //


-- procedimiento crear alumno
CREATE OR REPLACE PROCEDURE insertarAlumno(
    IN a_id INT DEFAULT NULL,
    IN a_razonInscripcion TEXT,
    IN a_fechaNacimiento DATE,
    IN a_codigoFederativo INT,
    IN a_dni VARCHAR(15),
    IN a_clausulaPDD BOOLEAN,
    IN a_personaId INT,
    IN a_domicilioId INT,
    IN a_tutorId INT
)
BEGIN
    IF a_id IS NULL THEN
        INSERT INTO Alumnos (razonInscripcion, fechaNacimiento, codigoFederativo, dni, clausulaPDD, personaId, domicilioId, tutorId)
        VALUES (a_razonInscripcion, a_fechaNacimiento, a_codigoFederativo, a_dni, a_clausulaPDD, a_personaId, a_domicilioId, a_tutorId);
    ELSE
        INSERT INTO Alumnos (alumnoId, razonInscripcion, fechaNacimiento, codigoFederativo, dni, clausulaPDD, personaId, domicilioId, tutorId)
        VALUES (a_id, a_razonInscripcion, a_fechaNacimiento, a_codigoFederativo, a_dni, a_clausulaPDD, a_personaId, a_domicilioId, a_tutorId);
    END IF;
END //

CREATE OR REPLACE PROCEDURE insertarAlumnoYPersona(
    IN p_id INT DEFAULT NULL,
    IN a_id INT DEFAULT NULL,
    IN p_nombre VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_telefono INT,
    IN p_correo VARCHAR(255),
    IN a_razonInscripcion TEXT,
    IN a_fechaNacimiento DATE,
    IN a_codigoFederativo INT,
    IN a_dni VARCHAR(15),
    IN a_clausulaPDD BOOLEAN,
    IN a_domicilioId INT,
    IN a_tutorId INT
)
BEGIN
    CALL insertarPersona(
       p_id,
       p_nombre,
       p_apellidos,
       p_correo,
       p_telefono
    );
    CALL insertarAlumno(
        a_id, 
        a_razonInscripcion, 
        a_fechaNacimiento, 
        a_codigoFederativo, 
        a_dni, 
        a_clausulaPDD, 
        LAST_INSERT_ID(), 
        a_domicilioId, 
        a_tutorId
    );
END //


-- procedimiento crear alumnosgrupos
CREATE OR REPLACE PROCEDURE insertarAlumnosGrupos(
    IN a_id INT DEFAULT NULL,
    IN a_alumnoId INT,
    IN a_grupoId INT,
    IN a_esLista BOOLEAN,
    IN a_temporada INT
)
BEGIN
    IF a_id IS NULL THEN
        INSERT INTO AlumnosGrupos(alumnoId, grupoId, esLista, temporada)
        VALUES (a_alumnoId, a_grupoId, a_esLista, a_temporada);
    ELSE
        INSERT INTO AlumnosGrupos(alumnosGruposId, alumnoId, grupoId, esLista, temporada)
        VALUES (a_id, a_alumnoId, a_grupoId, a_esLista, a_temporada);
    END IF;
END //


-- procedimiento crear grado
CREATE OR REPLACE PROCEDURE insertarGrado(
    IN g_id INT DEFAULT NULL,
    IN g_gradoCinturon VARCHAR(50),
    IN g_fechaInicio DATE,
    IN g_fechaLicencia DATE,
    IN g_fechaFin DATE,
    IN g_alumnoId INT
)
BEGIN
    IF g_id IS NULL THEN
        INSERT INTO Grados(gradoCinturon, fechaInicio, fechaFin, fechaLicencia, alumnoId)
        VALUES (g_gradoCinturon, g_fechaInicio, g_fechaFin, g_fechaLicencia, g_alumnoId);
    ELSE
        INSERT INTO Grados(gradoId, gradoCinturon, fechaInicio, fechaFin, fechaLicencia, alumnoId)
        VALUES (g_id, g_gradoCinturon, g_fechaInicio, g_fechaFin, g_fechaLicencia, g_alumnoId);
    END IF;
END //


-- procedimiento crear sensei
CREATE OR REPLACE PROCEDURE insertarSensei(
    IN s_id INT DEFAULT NULL,
    IN s_personaId INT
)
BEGIN
    IF s_id IS NULL THEN
        INSERT INTO Senseis(personaId)
        VALUES (s_personaId);
    ELSE
        INSERT INTO Senseis(senseiId, personaId)
        VALUES (s_id, s_personaId);
    END IF;
END //

CREATE OR REPLACE PROCEDURE insertarSenseiYPersona(
    IN p_id INT DEFAULT NULL,
    IN s_id INT DEFAULT NULL,
    IN p_nombre VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_telefono INT,
    IN p_correo VARCHAR(255)
)
BEGIN
    CALL insertarPersona(
       p_id,
       p_nombre,
       p_apellidos,
       p_correo,
       p_telefono
    );
    CALL insertarSensei(
        s_id,
        LAST_INSERT_ID()
    );
END //


-- procedimiento crear sesiones
CREATE OR REPLACE PROCEDURE insertarSesion(
    IN s_id INT DEFAULT NULL,
    IN s_fechaHora DATE,
    IN s_duracion INT,
    IN s_temporada INT,
    IN s_grupoId INT
)
BEGIN
    IF s_id IS NULL THEN
        INSERT INTO Sesiones(fechaHora, duracionMin, temporada, grupoId)
        VALUES (s_fechaHora, s_duracion, s_temporada, s_grupoId);
    ELSE
        INSERT INTO Sesiones(sesionId, fechaHora, duracionMin, temporada, grupoId)
        VALUES (s_id, s_fechaHora, s_duracion, s_temporada, s_grupoId);
    END IF;
END //


-- procedimiento crear asistencias
CREATE OR REPLACE PROCEDURE insertarAsistencia(
    IN a_id INT DEFAULT NULL,
    IN a_alumnoPresente BOOLEAN,
    IN a_alumnoId INT,
    IN a_sesionId INT
)
BEGIN
    IF a_id IS NULL THEN
        INSERT INTO Asistencias(alumnoPresente, alumnoId, sesionId)
        VALUES (a_alumnoPresente, a_alumnoId, a_sesionId);
    ELSE
        INSERT INTO Asistencias(asistenciaId, alumnoPresente, alumnoId, sesionId)
        VALUES (a_id, a_alumnoPresente, a_alumnoId, a_sesionId);
    END IF;
END //


-- procedimiento crear observaciones
CREATE OR REPLACE PROCEDURE insertarObservacion(
    IN o_id INT DEFAULT NULL,
    IN o_fecha DATE,
    IN o_argumento VARCHAR(100),
    IN o_alumnoId INT,
    IN o_senseiId INT
)
BEGIN
    IF o_id IS NULL THEN
        INSERT INTO Observaciones(fecha, argumento, alumnoId, senseiId)
        VALUES (o_fecha, o_argumento, o_alumnoId, o_senseiId);
    ELSE
        INSERT INTO Observaciones(observacionId, fecha, argumento, alumnoId, senseiId)
        VALUES (o_id, o_fecha, o_argumento, o_alumnoId, o_senseiId);
    END IF;
END //


-- procedimiento crear anuncios
CREATE OR REPLACE PROCEDURE insertarAnuncio(
    IN a_id INT DEFAULT NULL,
    IN a_asunto VARCHAR(255),
    IN a_fechaHora DATE,
    IN a_descripcion TEXT,
    IN a_senseiId INT
)
BEGIN
    IF a_id IS NULL THEN
        INSERT INTO Anuncios(asunto, fechaHora, descripcion, senseiId)
        VALUES (a_asunto, a_fechaHora, a_descripcion, a_senseiId);
    ELSE
        INSERT INTO Anuncios(anuncioId, asunto, fechaHora, descripcion, senseiId)
        VALUES (a_id, a_asunto, a_fechaHora, a_descripcion, a_senseiId);
    END IF;
END //


-- procedimiento crear info sanitarias
CREATE OR REPLACE PROCEDURE insertarInfoSanitaria(
    IN i_id INT DEFAULT NULL,
    IN i_argumento TEXT,
    IN i_alumnoId INT
)
BEGIN
    IF i_id IS NULL THEN
        INSERT INTO InfosSanitarias(argumento, alumnoId)
        VALUES (i_argumento, i_alumnoId);
    ELSE 
        INSERT INTO InfosSanitarias(infoSanitariaId, argumento, alumnoId)
        VALUES (i_id, i_argumento, i_alumnoId);
    END IF;
END //


-- procedimiento crear pagos
CREATE OR REPLACE PROCEDURE insertarPago(
    IN p_id INT DEFAULT NULL,
    IN p_cantidad DECIMAL(5,2),
    IN p_fecha DATE,
    IN p_metodo VARCHAR(20),
    IN p_financiamiento VARCHAR(30),
    in p_alumnoId INT
)
BEGIN
    IF p_id IS NULL THEN
        INSERT INTO Pagos(cantidad, fecha, metodo, financiamiento, alumnoId)
        VALUES (p_cantidad, p_fecha, p_metodo, p_financiamiento, p_alumnoId);
    ELSE
        INSERT INTO Pagos(pagoId,cantidad, fecha, metodo, financiamiento, alumnoId)
        VALUES (p_id, p_cantidad, p_fecha, p_metodo, p_financiamiento, p_alumnoId);
    END IF;
END //


-- trigger información contacto
-- telefono y correo obligatorio según edad
-- si alumno menor edad, debe tener tutor
-- si alumno menor edad, tutor debe tener telefono y correo
-- si alumno mayor edad, tutorId a null
-- si alumno mayor edad, alumno debe tener telefono y correo
CREATE OR REPLACE PROCEDURE informacionContacto(
    IN a_fechaNacimiento DATE,
    IN a_personaId INT,
    IN a_tutorId INT
)
BEGIN
    DECLARE edad INT;
    DECLARE telefonoAlumno INT DEFAULT NULL;
    DECLARE correoAlumno VARCHAR(255) DEFAULT NULL;
    DECLARE telefonoTutor INT DEFAULT NULL;
    DECLARE correoTutor VARCHAR(255) DEFAULT NULL;

    SET edad = TIMESTAMPDIFF(YEAR, a_fechaNacimiento, CURDATE());

    SELECT telefono, correo
    INTO telefonoAlumno, correoAlumno
    FROM Personas
    WHERE personaId = a_personaId;

    IF edad < 18 THEN -- menor de edad
        IF a_tutorId IS NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Un alumno menor de edad debe tener un tutor legal asignado.';
        END IF;

        IF a_tutorId IS NOT NULL THEN
            SELECT telefono, correo
        		INTO telefonoTutor, correoTutor
        		FROM Personas
        			JOIN TutoresLegales ON Personas.personaId = TutoresLegales.personaId
        		WHERE TutoresLegales.tutorId = a_tutorId;

            IF telefonoTutor IS NULL THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Un tutor legal debe tener teléfono de contacto.';
            END IF;

            IF correoTutor IS NULL THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Un tutor legal debe tener correo de contacto.';
            END IF;
        END IF;

        UPDATE Personas
        SET correo = NULL, telefono = NULL
        WHERE personaId = a_personaId;
    ELSE -- mayor de edad
        IF telefonoAlumno IS NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Un alumno mayor de edad debe tener teléfono de contacto.';
        END IF;

        IF correoAlumno IS NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Un alumno mayor de edad debe tener correo de contacto.';
        END IF;
    END IF;
END;

CREATE OR REPLACE TRIGGER contactoCrearAlumnos
BEFORE INSERT ON Alumnos
FOR EACH ROW
BEGIN
    CALL informacionContacto(
        NEW.fechaNacimiento,
        NEW.personaId,
        NEW.tutorId
    );
END //

CREATE OR REPLACE TRIGGER contactoActualizarAlumnos
BEFORE UPDATE ON Alumnos
FOR EACH ROW
BEGIN
    CALL informacionContacto(
        NEW.fechaNacimiento,
        NEW.personaId,
        NEW.tutorId
    );
END //


-- trigger dni
-- dni a null si alumno <14
CREATE OR REPLACE PROCEDURE dniObligatorio(
    IN a_fechaNacimiento DATE,
    INOUT a_dni VARCHAR(15)
)
BEGIN
    DECLARE edad INT;
    SET edad = TIMESTAMPDIFF(YEAR, a_fechaNacimiento, CURDATE());

    IF edad < 14 THEN
        SET a_dni = NULL;
    ELSEIF a_dni IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Un alumno mayor de 13 debe tener DNI.';
    END IF;
END;

CREATE OR REPLACE TRIGGER dniCrearAlumno
BEFORE INSERT ON Alumnos
FOR EACH ROW
BEGIN
    CALL dniObligatorio(
        NEW.fechaNacimiento,
        NEW.dni
    );
END //

CREATE OR REPLACE TRIGGER dniActualizarAlumno
BEFORE UPDATE ON Alumnos
FOR EACH ROW
BEGIN
    CALL dniObligatorio(
        NEW.fechaNacimiento,
        NEW.dni
    );
END //


-- trigger cláusula de protección de datos
CREATE OR REPLACE TRIGGER proteccionDatos
BEFORE INSERT ON Alumnos
FOR EACH ROW
BEGIN
    IF(NEW.clausulaPDD=FALSE) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'un alumno debe aceptar la cláusula de proteccion de datos';
    END IF;
END //


-- trigger añadir alumno a grupo completo
CREATE OR REPLACE PROCEDURE grupoCompleto(
    IN g_id INT,
    IN temp INT
)
BEGIN
    DECLARE alumnosEnGrupo INT;
    DECLARE capacidadMax INT;

    IF g_id IS NOT NULL THEN
        SELECT COUNT(*)
        INTO alumnosEnGrupo
        FROM AlumnosGrupos
        WHERE grupoId = g_id AND esLista IS FALSE AND temporada = temp;

        SELECT limiteAlumnos
        INTO capacidadMax
        FROM Grupos
        WHERE grupoId = g_id;

        IF alumnosEnGrupo >= capacidadMax THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El grupo está completo.';
        END IF;
    END IF;
END;

CREATE OR REPLACE TRIGGER validarCapacidadGrupoCreacion
BEFORE INSERT ON AlumnosGrupos
FOR EACH ROW
BEGIN
    CALL grupoCompleto(NEW.grupoId, NEW.temporada);
END //

CREATE OR REPLACE TRIGGER validarCapacidadGrupoActualizacion
BEFORE UPDATE ON AlumnosGrupos
FOR EACH ROW
BEGIN
    CALL grupoCompleto(NEW.grupoId, NEW.temporada);
END //


-- trigger alumno en grupo adecuado
-- alevín infantil <=13 años< juvenil adulto
CREATE OR REPLACE PROCEDURE grupoAdecuado(
    IN alumno INT,
    IN g_Id INT
)
BEGIN
    DECLARE nacimiento DATE;
    DECLARE edad INT;
    DECLARE cat VARCHAR(100);

    SELECT fechaNacimiento
    INTO nacimiento
    FROM Personas
    JOIN Alumnos ON Personas.personaId = Alumnos.personaId
    WHERE Alumnos.alumnoId = alumno;

    SET edad = TIMESTAMPDIFF(YEAR, nacimiento, CURDATE());

    IF g_Id IS NOT NULL THEN
        SELECT categoria
        INTO cat
        FROM Grupos
        WHERE grupoId = g_Id;

        IF (cat = 'Alevín-Infantil' AND edad > 14) OR (cat = 'Juvenil-Adulto' AND edad <= 12) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El grupo escogido no es para su edad.';
        END IF;
    END IF;
END;

CREATE OR REPLACE TRIGGER grupoAdecuadoCreacion
BEFORE INSERT ON AlumnosGrupos
FOR EACH ROW
BEGIN
    CALL grupoAdecuado(NEW.alumnoId, NEW.grupoId);
END //

CREATE OR REPLACE TRIGGER grupoAdecuadoActualizacion
BEFORE UPDATE ON AlumnosGrupos
FOR EACH ROW
BEGIN
    CALL grupoAdecuado(NEW.alumnoId, NEW.grupoId);
END //


-- trigger fecha grados
CREATE OR REPLACE PROCEDURE fechaGrados(
    IN g_fechaInicio DATE,
    IN g_fechaLicencia DATE,
    IN g_fechaFin DATE
)
BEGIN
    IF g_fechaInicio > CURDATE() 
        OR (g_fechaLicencia IS NOT NULL AND g_fechaLicencia > CURDATE())
        OR (g_fechaFin IS NOT NULL AND g_fechaFin > CURDATE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Fecha posterior a hoy no válida.';
    END IF;

    IF g_fechaLicencia IS NULL AND g_fechaFin IS NOT NULL AND NOT (g_fechaInicio < g_fechaFin) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Fecha de fin de grado inválida.';
    END IF;

    IF g_fechaLicencia IS NOT NULL AND g_fechaFin IS NULL AND NOT (g_fechaInicio < g_fechaLicencia) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Fecha de licencia de grado inválida.';
    END IF;

    IF g_fechaLicencia IS NOT NULL AND g_fechaFin IS NOT NULL THEN
        IF (g_fechaInicio > g_fechaLicencia OR g_fechaLicencia > g_fechaFin) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Secuencia de fechas inválida.';
        END IF;
    END IF;
END;

CREATE OR REPLACE TRIGGER fechaCreacionGrados
BEFORE INSERT ON Grados
FOR EACH ROW
BEGIN
    CALL fechaGrados(
        NEW.fechaInicio,
        NEW.fechaLicencia,
        NEW.fechaFin
    );
END //

CREATE OR REPLACE TRIGGER fechaActualizacionGrados
BEFORE UPDATE ON Grados
FOR EACH ROW
BEGIN
    CALL fechaGrados(
        NEW.fechaInicio,
        NEW.fechaLicencia,
        NEW.fechaFin
    );
END //

DELIMITER ;


-- vista grados con duracion y cumpleTMin
CREATE OR REPLACE VIEW VistaGrados AS
SELECT 
    gradoId, 
    gradoCinturon,
    fechaInicio,
    fechaLicencia,
    alumnoId,
    getDuracion(fechaInicio, fechaFin) AS duracion,
    getTiempoMin(gradoCinturon, fechaInicio, fechaFin) AS cumpleTMin
FROM Grados;


-- vista anuncios con estado
CREATE OR REPLACE VIEW VistaAnuncios AS
SELECT
    anuncioId,
    senseiId,
    asunto,
    descripcion,
    fechaHora,
    getEstadoAnuncio(fechaHora) AS estadoAnuncio
FROM Anuncios;


-- vista alumnos con estado
CREATE OR REPLACE VIEW VistaAlumnos AS
SELECT
    alumnoId,
    codigoFederativo,
    getEstadoAlumno(grupoIdEntreno, grupoIdEspera) AS estadoAlumno,
    personaId,
    tutorId,
    fechaNacimiento,
    dni,
    domicilioId,
    razonInscripcion,
    clausulaPDD
FROM Alumnos;


-- vista historial ascensos
-- de cada alumno, los grados que ha tenido
CREATE OR REPLACE VIEW historialAscensos AS
SELECT Personas.personaId, Personas.nombre, Personas.apellidos, VistaGrados.gradoCinturon, VistaGrados.fechaInicio, VistaGrados.duracion
FROM VistaGrados
    JOIN Alumnos ON VistaGrados.alumnoId = Alumnos.alumnoId
    JOIN Personas ON Alumnos.personaId = Personas.personaId
ORDER BY Personas.personaId, VistaGrados.fechaInicio ASC;


-- OPCION VIEJA

-- vista informe grupo
-- asistencia media de la última temporada
-- alumnos con valor de asistencia mayor
CREATE OR REPLACE VIEW asistenciasAlumnos AS
SELECT AlumnosGrupos.grupoId, AlumnosGrupos.temporada, AlumnosGrupos.alumnoId, COUNT(Asistencias.alumnoPresente) as totalAsistencias
FROM Asistencias
    JOIN AlumnosGrupos ON AlumnosGrupos.alumnoId = Asistencias.alumnoId
WHERE Asistencias.alumnoPresente = TRUE 
GROUP BY AlumnosGrupos.temporada, AlumnosGrupos.grupoId, AlumnosGrupos.alumnoId;

CREATE OR REPLACE VIEW informeGrupo AS
SELECT 
    asistenciasAlumnos.grupoId,
    asistenciasAlumnos.temporada,
    asistenciaMediaPorGrupo.asistenciaMedia AS asistenciaMedia, 
    asistenciasMaximaGrupo.mayorAsistencia AS asistenciaMaxima,
    asistenciasAlumnos.alumnoId AS alumnoMayorAsistencia
FROM asistenciasAlumnos
    JOIN (
        SELECT grupoId, temporada, MAX(totalAsistencias) AS mayorAsistencia
        FROM asistenciasAlumnos
        GROUP BY grupoId, temporada
    ) AS asistenciasMaximaGrupo -- máximo
        ON asistenciasAlumnos.grupoId = asistenciasMaximaGrupo.grupoId
            AND asistenciasAlumnos.temporada = asistenciasMaximaGrupo.temporada
            AND asistenciasAlumnos.totalAsistencias = asistenciasMaximaGrupo.mayorAsistencia
    JOIN (
        SELECT grupoId, temporada, AVG(totalAsistencias) AS asistenciaMedia
        FROM asistenciasAlumnos
        GROUP BY grupoId, temporada
    ) AS asistenciaMediaPorGrupo -- media
        ON asistenciasAlumnos.grupoId = asistenciaMediaPorGrupo.grupoId
            AND asistenciasAlumnos.temporada = asistenciaMediaPorGrupo.temporada
WHERE asistenciasAlumnos.temporada = getTemporada(CURDATE())
GROUP BY asistenciasAlumnos.grupoId, asistenciasAlumnos.temporada, asistenciasAlumnos.alumnoId;


-- vista informe individual de alumno
-- de todas las temporadas en las que estaba activo
-- porcentaje asistencia por temporada: sesiones asistidas / sesiones totales
-- grados que ha tenido
-- observaciones
CREATE OR REPLACE VIEW informes AS
SELECT 
    Alumnos.alumnoId,
    sesionesTotales.temporada,
    (sesionesAsistidas.totalAsistido * 100 / sesionesTotales.total) AS porcentajeAsistencia, 
    historialAscensos.gradoCinturon, 
    historialAscensos.fechaInicio, 
    historialAscensos.duracion, 
    Observaciones.fecha,
    Observaciones.argumento
FROM Alumnos
    JOIN historialAscensos ON historialAscensos.personaId = Alumnos.personaId
    JOIN Observaciones ON Observaciones.alumnoId = Alumnos.alumnoId
    JOIN (
        SELECT Asistencias.alumnoId, COUNT(Asistencias.alumnoId) as totalAsistido, Sesiones.temporada
        FROM Asistencias
            JOIN Sesiones ON Sesiones.sesionId = Asistencias.sesionId
        WHERE Asistencias.alumnoPresente = TRUE
        GROUP BY Asistencias.alumnoId, Sesiones.temporada
    ) AS sesionesAsistidas -- sesiones asistidas 
        ON Alumnos.alumnoId = sesionesAsistidas.alumnoId
    JOIN (
        SELECT Asistencias.alumnoId, COUNT(Asistencias.alumnoId) as total, Sesiones.temporada
        FROM Asistencias
            JOIN Sesiones ON Sesiones.sesionId = Asistencias.sesionId
        GROUP BY Asistencias.alumnoId, Sesiones.temporada
    ) AS sesionesTotales -- sesiones totales
        ON Alumnos.alumnoId = sesionesTotales.alumnoId 
            AND sesionesAsistidas.temporada = sesionesTotales.temporada;
-- mostrar sólo de un alumno con un select


-- OPCION NUEVA

-- sesiones totales
CREATE OR REPLACE VIEW sesionesTotales AS
SELECT 
    Sesiones.grupoId, 
    Temporadas.temporada, 
    COUNT(Sesiones.sesionId) AS sesiones
FROM Sesiones
    JOIN Temporadas ON Temporadas.temporadaId = Sesiones.temporada
GROUP BY Sesiones.grupoId, Temporadas.temporada;

-- sesiones asistidas
CREATE OR REPLACE VIEW sesionesAsistidas AS
SELECT 
    Asistencias.alumnoId, 
    Sesiones.grupoId, 
    Temporadas.temporada, 
    COUNT(Asistencias.sesionId) AS sesiones
FROM Asistencias
    JOIN Sesiones ON Sesiones.sesionId = Asistencias.sesionId
    JOIN Temporadas ON Temporadas.temporadaId = Sesiones.temporada
WHERE Asistencias.alumnoPresente IS TRUE
GROUP BY Sesiones.grupoId, Temporadas.temporada;

-- informe individual por grupo
CREATE OR REPLACE VIEW informesAlumnos AS
SELECT 
    AlumnosGrupos.alumnoId, 
    AlumnosGrupos.grupoId, 
    Temporadas.temporada, 
    CASE 
        WHEN COALESCE(sesionesTotales.sesiones, 0) = 0 THEN 0
        ELSE sesionesAsistidas.sesiones*100/COALESCE(sesionesTotales.sesiones, 1)
    END AS porcentajeAsistencia, 
    GROUP_CONCAT(DISTINCT Grados.gradoCinturon ORDER BY Grados.fechaInicio DESC) AS cinturones, 
    GROUP_CONCAT(DISTINCT Observaciones.argumento ORDER BY Observaciones.fecha DESC) AS observaciones
FROM AlumnosGrupos
    JOIN Temporadas ON Temporadas.temporadaId = AlumnosGrupos.temporadaId
    JOIN sesionesAsistidas ON sesionesAsistidas.alumnoId = AlumnosGrupos.alumnoId
    JOIN sesionesTotales ON sesionesTotales.grupoId = AlumnosGrupos.grupoId
    LEFT JOIN Observaciones ON 
        Observaciones.alumnoId = AlumnosGrupos.alumnoId
        AND
        Temporadas.temporada = getTemporada(Observaciones.fecha)
    LEFT JOIN Grados ON 
        Grados.alumnoId = AlumnosGrupos.alumnoId
        AND
        (
            Temporadas.temporada = getTemporada(Grados.fechaInicio)
            OR
            (
                Temporadas.temporada > getTemporada(Grados.fechaInicio)
                AND
                Grados.fechaFin IS NULL
            )
        )
WHERE sesionesAsistidas.grupoId = sesionesTotales.grupoId
GROUP BY AlumnosGrupos.alumnoId, AlumnosGrupos.grupoId, Temporadas.temporada;

-- informe grupo
CREATE OR REPLACE VIEW informesGrupos AS
SELECT
    informesAlumnos.grupoId, 
    informesAlumnos.temporada, 
    AVG(informesAlumnos.porcentajeAsistencia) AS asistenciaMedia, 
    MAX(informesAlumnos.porcentajeAsistencia) AS asistenciaMáxima,
    GROUP_CONCAT(DISTINCT maximos.alumnoId SEPARATOR ', ') AS alumnosMaximos
FROM informesAlumnos
    LEFT JOIN (
    SELECT 
        ia1.grupoId,
        ia1.temporada,
        ia1.alumnoId,
        ia1.porcentajeAsistencia
    FROM informesAlumnos ia1
    WHERE ia1.porcentajeAsistencia = (
        SELECT MAX(ia2.porcentajeAsistencia)
        FROM informesAlumnos ia2
        WHERE ia2.grupoId = ia1.grupoId
          AND ia2.temporada = ia1.temporada
        )
    ) AS maximos ON 
        maximos.grupoId = informesAlumnos.grupoId
        AND 
        maximos.temporada = informesAlumnos.temporada
GROUP BY informesAlumnos.grupoId, informesAlumnos.temporada;