DROP DATABASE IF EXISTS ProyectoDojo;
CREATE DATABASE ProyectoDojo;
USE ProyectoDojo;


-- eliminación tablas

DROP TABLE IF EXISTS Pagos;
DROP TABLE IF EXISTS InfosSanitarias;
DROP TABLE IF EXISTS Anuncios;
DROP TABLE IF EXISTS Observaciones;
DROP TABLE IF EXISTS Senseis;
DROP TABLE IF EXISTS Grupos;
DROP TABLE IF EXISTS Asistencias;
DROP TABLE IF EXISTS Sesiones;
DROP TABLE IF EXISTS Grados;
DROP TABLE IF EXISTS TutoresLegales;
DROP TABLE IF EXISTS Alumnos;
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

CREATE TABLE Grupos (
    grupoId INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    limiteAlumnos INT NOT NULL CHECK (limiteAlumnos >= 0),
    categoria VARCHAR(100) NOT NULL CHECK (categoria IN ("Alevín-Infantil", "Juvenil-Adulto")),
    ubicacion VARCHAR(100) NOT NULL,
    precioMes INT NOT NULL,
    CONSTRAINT grupos_repetidos UNIQUE (nombre,ubicacion)
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
    FOREIGN KEY (tutorId) REFERENCES TutoresLegales(tutorId),
    grupoIdEntreno INT,
    FOREIGN KEY (grupoIdEntreno) REFERENCES Grupos(grupoId),
    grupoIdEspera INT,
    FOREIGN KEY (grupoIdEspera) REFERENCES Grupos(grupoId)
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
    temporada VARCHAR(50),
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

-- función estado alumno
-- activo: si grupoIdEntreno o grupoIdEspera
-- inactivo: si no grupoIdEntreno y no grupoIdEspera
CREATE OR REPLACE FUNCTION getEstadoAlumno(
    IN a_grupoIdEntreno INT,
    IN a_grupoIdEspera INT
)
RETURNS VARCHAR(50)
BEGIN
    DECLARE estado VARCHAR(50);

    IF(a_grupoIdEntreno IS NULL AND a_grupoIdEspera IS NULL) THEN
        SET estado = 'Inactivo';
    ELSE
        SET estado = 'Activo';
    END IF;

    RETURN estado;
END //


-- procedimiento crear personas
CREATE OR REPLACE PROCEDURE insertarPersona(
    IN p_nombre VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_correo VARCHAR(255),
    IN p_telefono INT
)
BEGIN
    INSERT INTO Personas (nombre, apellidos, telefono, correo)
    VALUES (p_nombre, p_apellidos, p_telefono, p_correo);
END //


-- prodecimiento crear domicilio
CREATE OR REPLACE PROCEDURE insertarDomicilio(
    IN d_direccion VARCHAR(255),
    IN d_municipio VARCHAR(100),
    IN d_cp INT
)
BEGIN
    INSERT INTO Domicilios (direccion, municipio, cp)
    VALUES (d_direccion, d_municipio, d_cp);
END //


-- prodecimiento crear tutor legal
CREATE OR REPLACE PROCEDURE insertarTutorLegal(
    IN t_correoAlternativo VARCHAR(255),
    IN t_parentesco VARCHAR(50),
    IN t_personaId INT
)
BEGIN
    INSERT INTO TutoresLegales (correoAlternativo, parentesco, personaId)
    VALUES (t_correoAlternativo, t_parentesco, t_personaId);
END //


-- procedimiento crear grupo
CREATE OR REPLACE PROCEDURE insertarGrupo(
    IN g_nombre VARCHAR(100),
    IN g_ubicacion VARCHAR(100),
    IN g_categoria VARCHAR(100),
    IN g_limiteAlumnos INT,
    IN g_precioMes INT
)
BEGIN
    INSERT INTO Grupos(nombre, ubicacion, categoria, limiteAlumnos, precioMes)
    VALUES (g_nombre, g_ubicacion, g_categoria, g_limiteAlumnos, g_precioMes);
END //


-- procedimiento crear alumno
CREATE OR REPLACE PROCEDURE insertarAlumno(
    IN a_razonInscripcion TEXT,
    IN a_fechaNacimiento DATE,
    IN a_codigoFederativo INT,
    IN a_dni VARCHAR(15),
    IN a_clausulaPDD BOOLEAN,
    IN a_personaId INT,
    IN a_domicilioId INT,
    IN a_tutorId INT,
    IN a_grupoIdEntreno INT,
    IN a_grupoIdEspera INT
)
BEGIN
    INSERT INTO Alumnos (razonInscripcion, fechaNacimiento, codigoFederativo, dni, clausulaPDD, personaId, domicilioId, tutorId, grupoIdEntreno, grupoIdEspera)
    VALUES (a_razonInscripcion, a_fechaNacimiento, a_codigoFederativo, a_dni, a_clausulaPDD, a_personaId, a_domicilioId, a_tutorId, a_grupoIdEntreno, a_grupoIdEspera);
END //


-- procedimiento crear grado
CREATE OR REPLACE PROCEDURE insertarGrado(
    IN g_gradoCinturon VARCHAR(50),
    IN g_fechaInicio DATE,
    IN g_fechaLicencia DATE,
    IN g_fechaFin DATE,
    IN g_alumnoId INT
)
BEGIN
    INSERT INTO Grados(gradoCinturon, fechaInicio, fechaFin, fechaLicencia, alumnoId)
    VALUES (g_gradoCinturon, g_fechaInicio, g_fechaFin, g_fechaLicencia, g_alumnoId);
END //


-- procedimiento crear sensei
CREATE OR REPLACE PROCEDURE insertarSensei(
    IN s_personaId INT
)
BEGIN
    INSERT INTO Senseis(personaId)
    VALUES (s_personaId);
END //


-- procedimiento crear sesiones
CREATE OR REPLACE PROCEDURE insertarSesion(
    IN s_fechaHora DATE,
    IN s_temporada VARCHAR(50),
    IN s_grupoId INT
)
BEGIN
    INSERT INTO Sesiones(fechaHora, temporada, grupoId)
    VALUES (s_fechaHora, s_temporada, s_grupoId);
END //


-- procedimiento crear asistencias
CREATE OR REPLACE PROCEDURE insertarAsistencia(
    IN a_alumnoPresente BOOLEAN,
    IN a_alumnoId INT,
    IN a_sesionId INT
)
BEGIN
    INSERT INTO Asistencias(alumnoPresente, alumnoId, sesionId)
    VALUES (a_alumnoPresente, a_alumnoId, a_sesionId);
END //


-- procedimiento crear observaciones
CREATE OR REPLACE PROCEDURE insertarObservacion(
    IN o_fecha DATE,
    IN o_argumento VARCHAR(100),
    IN o_alumnoId INT,
    IN o_senseiId INT
)
BEGIN
    INSERT INTO Observaciones(fecha, argumento, alumnoId, senseiId)
    VALUES (o_fecha, o_argumento, o_alumnoId, o_senseiId);
END //


-- procedimiento crear anuncios
CREATE OR REPLACE PROCEDURE insertarAnuncio(
    IN a_asunto VARCHAR(255),
    IN a_fechaHora DATE,
    IN a_descripcion TEXT,
    IN a_senseiId INT
)
BEGIN
    INSERT INTO Anuncios(asunto, fechaHora, descripcion, senseiId)
    VALUES (a_asunto, a_fechaHora, a_descripcion, a_senseiId);
END //


-- procedimiento crear info sanitarias
CREATE OR REPLACE PROCEDURE insertarInfoSanitaria(
    IN i_argumento TEXT,
    IN i_alumnoId INT
)
BEGIN
    INSERT INTO InfosSanitarias(argumento, alumnoId)
    VALUES (i_argumento, i_alumnoId);
END //


-- procedimiento crear pagos
CREATE OR REPLACE PROCEDURE insertarPago(
    IN p_cantidad DECIMAL(5,2),
    IN p_fecha DATE,
    IN p_metodo VARCHAR(20),
    IN p_financiamiento VARCHAR(30),
    in p_alumnoId INT
)
BEGIN
    INSERT INTO Pagos(cantidad, fecha, metodo, financiamiento, alumnoId)
    VALUES (p_cantidad, p_fecha, p_metodo, p_financiamiento, p_alumnoId);
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


-- trigger solape sesiones
-- fechaHora y ubicacion
CREATE OR REPLACE PROCEDURE sesionesSolapadas(
    IN s_fechaHora DATETIME,
    IN s_grupoId INT
)
BEGIN
    DECLARE sesionesCoincidentes INT DEFAULT 0;
    DECLARE s_ubicacion VARCHAR(100);

    SELECT Grupos.ubicacion
    INTO s_ubicacion
    FROM Grupos
    WHERE Grupos.grupoId = s_grupoId;

    SELECT COUNT(*)
    INTO sesionesCoincidentes
    FROM Sesiones
    JOIN Grupos ON Grupos.grupoId = Sesiones.grupoId
    WHERE Grupos.ubicacion = s_ubicacion
      AND Sesiones.fechaHora = s_fechaHora;

    IF sesionesCoincidentes > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ya existe una sesión programada en esta ubicación y hora.';
    END IF;
END;

CREATE OR REPLACE TRIGGER solapeCreacionSesiones
BEFORE INSERT ON Sesiones
FOR EACH ROW
BEGIN
    CALL sesionesSolapadas(
        NEW.fechaHora,
        NEW.grupoId
    );
END //

CREATE OR REPLACE TRIGGER solapeActualizacionSesiones
BEFORE UPDATE ON Sesiones
FOR EACH ROW
BEGIN
    CALL sesionesSolapadas(
        NEW.fechaHora,
        NEW.grupoId
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


-- trigger alumnos dos grupos
CREATE OR REPLACE PROCEDURE alumnoDosGrupos(
    IN a_grupoIdEntreno INT,
    IN a_grupoIdEspera INT
)
BEGIN
    IF a_grupoIdEntreno IS NOT NULL AND a_grupoIdEspera IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Un alumno no puede pertenecer a dos grupos.';
    END IF;
END;

CREATE OR REPLACE TRIGGER creacionAlumnoDosGrupos
BEFORE INSERT ON Alumnos
FOR EACH ROW
BEGIN
    CALL alumnoDosGrupos(
        NEW.grupoIdEntreno,
        NEW.grupoIdEspera
    );
END //

CREATE OR REPLACE TRIGGER actualizacionAlumnoDosGrupos
BEFORE UPDATE ON Alumnos
FOR EACH ROW
BEGIN
    CALL alumnoDosGrupos(
        NEW.grupoIdEntreno,
        NEW.grupoIdEspera
    );
END //


-- trigger añadir alumno a grupo completo
CREATE OR REPLACE PROCEDURE grupoCompleto(
    IN g_idEntreno INT
)
BEGIN
    DECLARE alumnosEnGrupo INT;
    DECLARE capacidadMax INT;

    IF g_idEntreno IS NOT NULL THEN
        SELECT COUNT(*)
        INTO alumnosEnGrupo
        FROM Alumnos
        WHERE grupoIdEntreno = g_idEntreno;

        SELECT limiteAlumnos
        INTO capacidadMax
        FROM Grupos
        WHERE grupoId = g_idEntreno;

        IF alumnosEnGrupo >= capacidadMax THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El grupo está completo.';
        END IF;
    END IF;
END;

CREATE OR REPLACE TRIGGER validarCapacidadGrupoCreacion
BEFORE INSERT ON Alumnos
FOR EACH ROW
BEGIN
    CALL grupoCompleto(NEW.grupoIdEntreno);
END //

CREATE OR REPLACE TRIGGER validarCapacidadGrupoActualizacion
BEFORE UPDATE ON Alumnos
FOR EACH ROW
BEGIN
    CALL grupoCompleto(NEW.grupoIdEntreno);
END //


-- trigger alumno en grupo adecuado
-- alevín infantil <=13 años< juvenil adulto
CREATE OR REPLACE PROCEDURE grupoAdecuado(
    IN alumno INT,
    IN grupoIdEntreno INT,
    IN grupoIdEspera INT
)
BEGIN
    DECLARE nacimiento DATE;
    DECLARE edad INT;
    DECLARE categoriaEntreno VARCHAR(100);
    DECLARE categoriaEspera VARCHAR(100);

    SELECT fechaNacimiento
    INTO nacimiento
    FROM Personas
    JOIN Alumnos ON Personas.personaId = Alumnos.personaId
    WHERE Alumnos.alumnoId = alumno;

    SET edad = TIMESTAMPDIFF(YEAR, nacimiento, CURDATE());

    IF grupoIdEntreno IS NOT NULL THEN
        SELECT categoria
        INTO categoriaEntreno
        FROM Grupos
        WHERE grupoId = grupoIdEntreno;

        IF (categoriaEntreno = 'Alevín-Infantil' AND edad > 13) OR (categoriaEntreno = 'Juvenil-Adulto' AND edad <= 13) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El grupo escogido no es para su edad.';
        END IF;
    END IF;

    IF grupoIdEspera IS NOT NULL THEN
        SELECT categoria
        INTO categoriaEspera
        FROM Grupos
        WHERE grupoId = grupoIdEspera;

        IF (categoriaEspera = 'Alevín-Infantil' AND edad > 13) OR (categoriaEspera = 'Juvenil-Adulto' AND edad <= 13) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El grupo escogido no es para su edad.';
        END IF;
    END IF;
END;

CREATE OR REPLACE TRIGGER grupoAdecuadoCreacion
BEFORE INSERT ON Alumnos
FOR EACH ROW
BEGIN
    CALL grupoAdecuado(NEW.alumnoId,NEW.grupoIdEntreno,NEW.grupoIdEspera);
END //

CREATE OR REPLACE TRIGGER grupoAdecuadoActualizacion
BEFORE UPDATE ON Alumnos
FOR EACH ROW
BEGIN
    CALL grupoAdecuado(NEW.alumnoId,NEW.grupoIdEntreno,NEW.grupoIdEspera);
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
    grupoIdEntreno,
    grupoIdEspera,
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


-- vista informe grupo
-- asistencia media de la última temporada
-- alumnos con valor de asistencia mayor
CREATE OR REPLACE VIEW asistenciasAlumnos AS
SELECT Grupos.grupoId, Sesiones.temporada, Alumnos.alumnoId, COUNT(Asistencias.alumnoPresente) as totalAsistencias
FROM Asistencias
    JOIN Alumnos ON Asistencias.alumnoId = Alumnos.alumnoId
    JOIN Sesiones ON Asistencias.sesionId = Sesiones.sesionId
    JOIN Grupos ON Grupos.grupoId = Sesiones.grupoId
WHERE Asistencias.alumnoPresente = TRUE 
GROUP BY Sesiones.temporada, Grupos.grupoId, Alumnos.alumnoId;

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
    ) AS asistenciasMaximaGrupo
        ON asistenciasAlumnos.grupoId = asistenciasMaximaGrupo.grupoId
            AND asistenciasAlumnos.temporada = asistenciasMaximaGrupo.temporada
            AND asistenciasAlumnos.totalAsistencias = asistenciasMaximaGrupo.mayorAsistencia
    JOIN (
        SELECT grupoId, temporada, AVG(totalAsistencias) AS asistenciaMedia
        FROM asistenciasAlumnos
        GROUP BY grupoId, temporada
    ) AS asistenciaMediaPorGrupo
        ON asistenciasAlumnos.grupoId = asistenciaMediaPorGrupo.grupoId
            AND asistenciasAlumnos.temporada = asistenciaMediaPorGrupo.temporada
WHERE asistenciasAlumnos.temporada = ( 
    SELECT MAX(Sesiones.temporada) 
    FROM Sesiones
)
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
    JOIN ( -- sesiones asistidas
        SELECT Asistencias.alumnoId, COUNT(Asistencias.alumnoId) as totalAsistido, Sesiones.temporada
        FROM Asistencias
            JOIN Sesiones ON Sesiones.sesionId = Asistencias.sesionId
        WHERE Asistencias.alumnoPresente = TRUE
        GROUP BY Asistencias.alumnoId, Sesiones.temporada
    ) AS sesionesAsistidas 
        ON Alumnos.alumnoId = sesionesAsistidas.alumnoId
    JOIN ( -- sesiones totales
        SELECT Asistencias.alumnoId, COUNT(Asistencias.alumnoId) as total, Sesiones.temporada
        FROM Asistencias
            JOIN Sesiones ON Sesiones.sesionId = Asistencias.sesionId
        GROUP BY Asistencias.alumnoId, Sesiones.temporada
    ) AS sesionesTotales 
        ON Alumnos.alumnoId = sesionesTotales.alumnoId 
            AND sesionesAsistidas.temporada = sesionesTotales.temporada;