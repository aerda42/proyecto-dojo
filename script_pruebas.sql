-- probar triggers
CALL insertarPersona("alumno1","trigger","correo@gmail.com",123456789); -- P8, A5
CALL insertarPersona("tutor1","trigger","correo@gmail.com",123456789); -- P9, T3
CALL insertarTutorLegal(NULL,"Padre de alumno1,alumno3",8);
CALL insertarPersona("alumno2","trigger","correo@gmail.com",123456789); -- P10, A6
CALL insertarPersona("alumno3","trigger","correo@gmail.com",123456789); -- P11, A7
CALL insertarPersona("alumno4","trigger","correo@gmail.com",123456789); -- P12, A8
CALL insertarPersona("tutor2,alumno6","trigger","correo@gmail.com",NULL); -- P13, T4, A9
CALL insertarTutorLegal(NULL,"Padre de alumno5",13);
CALL insertarPersona("alumno5","trigger",NULL,123456789); -- P14, A10
CALL insertarPersona("tutor3,alumno7","trigger","correo@gmail.com",NULL); -- P15, T5, A11
CALL insertarTutorLegal(NULL,"Padre de alumno7",15);

-- probar trigger informacion contacto (añadir respectivos personas, alumnos, tutores)
-- alumno menor de edad con tutor con teléfono y correo
CALL insertarAlumno(NULL,'2005-05-05',NULL,'12345678A',TRUE,7,1,3,NULL,NULL);
-- alumno mayor edad con teléfono y correo
CALL insertarAlumno(NULL,'2000-01-01',NULL,'22345678A',TRUE,9,1,NULL,NULL,NULL);
-- alumno mayor edad con tutor
CALL insertarAlumno(NULL,'2000-01-01',NULL,'32345678A',TRUE,10,1,3,NULL,NULL);
-- alumno mayor edad sin tutor
CALL insertarAlumno(NULL,'2000-01-01',NULL,'42345678A',TRUE,11,1,NULL,NULL,NULL);
-- FALLOS:
-- alumno menor de edad con tutor sin teléfono
CALL insertarAlumno(NULL,'2010-05-05',NULL,'724465478A',TRUE,15,1,4,NULL,NULL);
-- alumno menor de edad con tutor sin correo
CALL insertarAlumno(NULL,'2010-05-05',NULL,'44571912A',TRUE,14,1,5,NULL,NULL);
-- alumno menor de edad sin tutor
CALL insertarAlumno(NULL,'2010-05-05',NULL,'72645678A',TRUE,13,1,NULL,NULL,NULL);
-- alumno mayor de edad sin telefono
CALL insertarAlumno(NULL,'2005-05-05',NULL,'84899288A',TRUE,15,1,NULL,NULL,NULL);
-- alumno mayor de edad sin correo
CALL insertarAlumno(NULL,'2005-05-05',NULL,'94816211A',TRUE,14,1,NULL,NULL,NULL);


-- probar trigger solape sesiones (añadir respectivos grupos, sesiones)
-- dos sesiones con distinta fechaHora y ubicación
CALL insertarGrupo('Grupo C', 'Gines', 'Juvenil-Adulto', 15, 60); -- G3
CALL insertarSesion('2024-12-06 10:00:00', '2024/25', 1); -- G1, S4
CALL insertarSesion('2024-12-07 10:00:00', '2024/25', 3); -- G3, S5
-- dos sesiones con misma fechaHora y distinta ubicación
CALL insertarGrupo('Grupo D', 'Gines', 'Juvenil-Adulto', 15, 60); -- G4
CALL insertarSesion('2024-12-08 10:00:00', '2024/25', 1); -- G1, S6
CALL insertarSesion('2024-12-08 10:00:00', '2024/25', 4); -- G4, S7
-- dos sesiones con distinta fechaHora y misma ubicación
CALL insertarSesion('2024-07-20 10:00:00', '2024/25', 1); -- G1, S8
CALL insertarSesion('2024-08-20 10:00:00', '2024/25', 2); -- G2, S9
-- FALLOS:
-- dos sesiones con misma fechaHora y ubicación
CALL insertarSesion('2024-12-10 10:00:00', '2024/25', 3); -- G3, S10
CALL insertarSesion('2024-12-10 10:00:00', '2024/25', 4); -- G4, S10


-- probar trigger dni alumno (añadir respectivos personas, alumnos)
-- alumno <14 con dni
CALL insertarPersona("alumno6","trigger","correo@gmail.com",123456789); -- P15, A12, T1
CALL insertarAlumno(NULL,'2011-05-05',NULL,'11345678A',TRUE,15,1,1,NULL,NULL);
CALL insertarTutorLegal(NULL, "Padre", 15);
-- alumno >=14 con dni
CALL insertarPersona("alumno7","trigger","correo@gmail.com",123456789); -- P9, A6
CALL insertarAlumno(NULL,'2005-05-05',NULL,'13345678A',TRUE,9,1,NULL,NULL,NULL);
-- FALLOS:
-- alumno >14 sin dni
CALL insertarPersona("alumno8","trigger","correo@gmail.com",123456789);
CALL insertarAlumno(NULL,'2000-05-05',NULL,NULL,TRUE,17,1,1,NULL,NULL);


-- probar trigger cpd (añadir respectivos personas, alumnos)
-- alumno con cpd a true
CALL insertarPersona("alumno9","trigger","correo@gmail.com",123456789); -- P8, A5
CALL insertarAlumno(NULL,'2005-05-05',NULL,'14345678A',TRUE,8,1,NULL,NULL,NULL);
-- FALLOS:
-- alumno con cpd a false
CALL insertarPersona("alumno10","trigger","correo@gmail.com",123456789);
CALL insertarAlumno(NULL,'2005-05-05',NULL,'14345678A',FALSE,9,1,NULL,NULL,NULL);


-- probar trigger dos grupos (añadir respectivos personas, grupos)
CALL insertarGrupo('Grupo E', 'Gines', 'Juvenil-Adulto', 15, 60);
-- alumno con grupoEntreno y sin grupoEspera
CALL insertarPersona("alumno11","trigger","correo@gmail.com",123456789); -- P8, A5
CALL insertarAlumno(NULL,'2005-05-05',NULL,'15345678A',TRUE,8,1,NULL,3,NULL);
-- alumno sin grupoEntreno y con grupoEspera
CALL insertarPersona("alumno12","trigger","correo@gmail.com",123456789); -- P9, A6
CALL insertarAlumno(NULL,'2005-05-05',NULL,'16345678A',TRUE,9,1,NULL,NULL,3);
-- alumno sin grupoEntreno y grupoEspera
CALL insertarPersona("alumno13","trigger","correo@gmail.com",123456789); -- P10, A7
CALL insertarAlumno(NULL,'2005-05-05',NULL,'17345678A',TRUE,10,1,NULL,NULL,NULL);
-- FALLOS:
-- alumno con grupoEntreno y grupoEspera
CALL insertarPersona("alumno14","trigger","correo@gmail.com",123456789);
CALL insertarAlumno(NULL,'2005-05-05',NULL,'18345678A',TRUE,11,1,NULL,3,3);


-- probar trigger grupo completo (añadir respectivos personas, alumnos, grupos)
CALL insertarGrupo('Grupo F', 'Gines', 'Juvenil-Adulto', 1, 60);
-- alumno a grupo con espacio
CALL insertarPersona("alumno15","trigger","correo@gmail.com",123456789); -- P8, A5
CALL insertarAlumno(NULL,'2005-05-05',NULL,'19345678A',TRUE,8,1,NULL,3,NULL);
-- FALLOS:
-- alumno a grupo completo
CALL insertarPersona("alumno16","trigger","correo@gmail.com",123456789);
CALL insertarAlumno(NULL,'2005-05-05',NULL,'11145678A',TRUE,9,1,NULL,3,NULL);


-- probar trigger grupo adecuado (añadir respectivos personas, alumnos, grupos)
CALL insertarGrupo('Grupo G', 'Sevilla', 'Juvenil-Adulto', 30, 60);
CALL insertarGrupo('Grupo H', 'Gines', 'Alevín-Infantil', 30, 60);
-- alumno <13 en grupo entreno Alevín-Infantil
CALL insertarPersona("alumno17","trigger","correo@gmail.com",123456789); -- P8, A5
CALL insertarAlumno(NULL,'2012-05-05',NULL,'19345478B',TRUE,8,1,2,4,NULL);
-- alumno >=13 en grupo entreno Juvenil-Adulto
CALL insertarPersona("alumno18","trigger","correo@gmail.com",123456789); -- P9, A6
CALL insertarAlumno(NULL,'2005-05-05',NULL,'19345678Z',TRUE,9,1,NULL,3,NULL);
-- alumno <13 en grupo espera Alevín-Infantil
CALL insertarPersona("alumno19","trigger","correo@gmail.com",123456789); -- P10, A7
CALL insertarAlumno(NULL,'2012-05-05',NULL,'19345649F',TRUE,10,1,2,4,NULL);
-- alumno >=13 en grupo espera Juvenil-Adulto
CALL insertarPersona("alumno20","trigger","correo@gmail.com",123456789); -- P11, A8
CALL insertarAlumno(NULL,'2005-05-05',NULL,'19757219C',TRUE,11,1,NULL,3,NULL);
-- FALLOS:
-- alumno <13 en grupo entreno Juvenil-Adulto
CALL insertarPersona("alumno20","trigger","correo@gmail.com",123456789);
CALL insertarAlumno(NULL,'2012-05-05',NULL,'19345378A',TRUE,12,1,2,7,NULL);
-- alumno >=13 en grupo entreno Alevín-Infantil
CALL insertarPersona("alumno20","trigger","correo@gmail.com",123456789);
CALL insertarAlumno(NULL,'2005-05-05',NULL,'19345678A',TRUE,13,1,NULL,8,NULL);
-- alumno <13 en grupo espera Juvenil-Adulto
CALL insertarPersona("alumno20","trigger","correo@gmail.com",123456789);
CALL insertarAlumno(NULL,'2012-05-05',NULL,'19345778A',TRUE,14,1,2,NULL,7);
-- alumno >=13 en grupo espera Alevín-Infantil
CALL insertarPersona("alumno20","trigger","correo@gmail.com",123456789);
CALL insertarAlumno(NULL,'2005-05-05',NULL,'19344278A',TRUE,15,1,NULL,NULL,8);


-- probar trigger fecha grados (añadir respectivos grados, alumnos, personas)
-- grado con fecha inicio <= hoy
CALL insertarGrado('Verde', '2024-12-12', NULL, NULL, 1); -- G5, 1
-- grado con fecha licencia <= hoy
CALL insertarGrado('Verde', '2023-12-12', NULL, '2024-12-12', 1); -- G6, 1
-- grado con fecha fin <= hoy
CALL insertarGrado('Verde', '2023-12-12', '2024-12-12', NULL, 1); -- G7, 1
-- grado con fecha inicio < fecha licencia
CALL insertarGrado('Verde', '2023-12-12', NULL, '2024-12-12', 1); -- G8, 1
-- grado con fecha inicio < fecha fin
CALL insertarGrado('Verde', '2023-12-12', '2024-12-12', NULL, 1); -- G9, 1
-- grado con fecha licencia < fecha fin
CALL insertarGrado('Verde', '2022-12-12', '2023-12-12', '2024-12-12', 1); -- G10, 1
-- FALLOS:
-- grado con fecha inicio > hoy
CALL insertarGrado('Verde', '2025-12-12', NULL, NULL, 1);
-- grado con fecha licencia > hoy
CALL insertarGrado('Verde', '2024-12-12', NULL, '2025-12-12', 1);
-- grado con fecha fin > hoy
CALL insertarGrado('Verde', '2024-12-12', '2025-12-12', NULL, 1);
-- grado con fecha inicio > fecha fin
CALL insertarGrado('Verde', '2024-12-12', NULL, '2023-12-12', 1);
-- grado con fecha inicio > fecha licencia
CALL insertarGrado('Verde', '2024-12-12', '2023-12-12', NULL, 1);
-- grado con fecha licencia > fecha fin 
CALL insertarGrado('Verde', '2022-12-12', '2024-12-12', '2023-12-12', 1);


-- probar vistas
INSERT INTO Personas (nombre, apellidos, telefono, correo) VALUES
    ("AlumnoP1", "probar vistas", 233423764, "correo"), -- P8
    ("AlumnoP2", "probar vistas", 876985643, "correo"), -- P9
    ("SenseiP", "probar vistas", 987408432, "correo"); -- P10
INSERT INTO Senseis (personaId) VALUES 
    (10); -- S2
INSERT INTO Anuncios (asunto, descripcion, senseiId) VALUES 
    ('PruebaVista', 'Esto es una prueba de la vista', 2);
INSERT INTO Domicilios (direccion, municipio, cp) VALUES 
    ('Calle Falsa 123', 'Sevilla', 41000); -- D4
INSERT INTO Grupos (nombre, limiteAlumnos, categoria, ubicacion, precioMes) VALUES 
	 ('Grupo Prueba Vistas', 20, 'Juvenil-Adulto', 'Sevilla', 50); -- G3
INSERT INTO Alumnos (fechaNacimiento, dni, clausulaPDD, domicilioId, personaId, grupoIdEntreno) VALUES 
     ('2000-01-01', '46827638F', TRUE, 4, 8, 3), -- A5
	 ('2005-01-01', '45127324G', TRUE, 4, 9, 3); -- A6
INSERT INTO Grados (gradoCinturon, fechaInicio, alumnoId) VALUES 
    ('Blanco', '2023-01-01', 5),
    ('Blanco-Amarillo', '2024-09-03', 5);
INSERT INTO Sesiones (fechaHora, grupoId, temporada) VALUES 
    ('2024-01-01 10:00:00', 3, "2024/25"), -- S4
    ('2024-02-02 10:00:00', 3, "2024/25"), -- S5
    ('2024-03-03 10:00:00', 3, "2024/25"); -- S6
INSERT INTO Asistencias (alumnoPresente, alumnoId, sesionId) VALUES 
    (TRUE, 5, 4),
    (FALSE, 5, 5),
    (FALSE, 5, 6),
    (TRUE, 6, 4),
    (TRUE, 6, 5),
    (FALSE, 6, 6);
INSERT INTO Observaciones (fecha, argumento, alumnoId, senseiId) VALUES 
    ('2024-05-05', 'Presenta gran mejoría de actitud', 5, 2);

-- probar vista grados (añadir respectivos alumnos, grados)
-- del mismo alumno:
    -- Blanco, 1/1/2023
    -- Blanco-Amarillo, 3/9/2024
SELECT *
FROM VistaGrados;


-- probar vista anuncios (añadir respectivos senseis, anuncios)
-- anuncio: PruebaVista, esto es una prueba de la vista, 1/1/2024
SELECT *
FROM VistaAnuncios;


-- probar vista alumnos (añadir respectivos personas, alumnos)
-- alumno sin grupo entreno ni grupo espera
SELECT *
FROM VistaAlumnos;


-- probar vista historial grados (añadir respectivos personas, alumnos, grados)
-- alumno con:
    -- Blanco, 1/1/2023
    -- Blanco-Amarillo, 3/9/2024
SELECT *
FROM historialAscensos;


-- probar vista informe grupo (añadir respectivos, personas, alumnos, grados, sesiones, asistencias)
-- grupo con:
    -- temporada 2024-2025
    -- 3 sesiones
    -- 1 alumno va a 2/3 sesiones
    -- otro va a 1/3 sesiones
SELECT *
FROM informeGrupo;


-- probar vista informe individual (añadir respectivos personas, sesiones, grupos)
-- alumno con:
    -- asistencias:
        -- 1 de 3 (33%) <- sesion temporada 2024-2025
    -- cinturones: 
        -- Blanco, 1/1/2023
        -- Blanco-Amarillo, 3/9/2024
    -- observaciones:
        -- presenta gran mejoría de actitud, 5/5/2024
-- esta vista se parametriza con ID
SELECT *
FROM informes
WHERE informes.alumnoId = 5;
