-- trigger información contacto
-- alumno menor de edad con tutor con teléfono y correo
CALL insertarAlumnoYPersona(
    8,                          -- p8
    5,                          -- a5
    'Alumno5', 
    'trigger', 
    123456789,
    'correo@gmail.com',
    NULL,
    '2010-05-05',
    NULL,
    '00000005A',
    TRUE,
    1,                          -- d1
    2                           -- t2
);
-- alumno mayor edad con teléfono y correo
-- alumno mayor edad sin tutor
CALL insertarAlumnoYPersona(
    9,                          -- p9
    6,                          -- a6
    'Alumno6', 
    'trigger', 
    123456789,
    'correo@gmail.com',
    NULL,
    '2005-05-05',
    NULL,
    '00000006A',
    TRUE,
    1,                          -- d1
    NULL
);
-- alumno mayor edad con tutor
CALL insertarAlumnoYPersona(
    10,                         -- p10
    7,                          -- a7
    'Alumno7', 
    'trigger', 
    123456789,
    'correo@gmail.com',
    NULL,
    '2010-05-05',
    NULL,
    '00000007A',
    TRUE,
    1,                          -- d1
    2                           -- t2
);

-- FALLOS:

-- alumno menor de edad con tutor sin teléfono
CALL insertarAlumnoYPersona(
    11,                         -- p11
    8,                          -- a8
    'Alumno8', 
    'triggerF', 
    123456789,
    'correo@gmail.com',
    NULL,
    '2010-05-05',
    NULL,
    '00000008A',
    TRUE,
    1,                          -- d1
    1                           -- t1
);
-- alumno menor de edad con tutor sin correo
CALL insertarTutorLegalYPersona(
    12,                         -- p12
    3,                          -- t3
    'Tutor legal3', 
    'trigger',
    123456789, 
    NULL,
    NULL,
    'Padre'
);
CALL insertarAlumnoYPersona(
    13,                         -- p13
    9,                          -- a9
    'Alumno9', 
    'triggerF', 
    123456789,
    'correo@gmail.com',
    NULL,
    '2010-05-05',
    NULL,
    '00000009A',
    TRUE,
    1,                          -- d1
    3                           -- t3
);
-- alumno menor de edad sin tutor
CALL insertarAlumnoYPersona(
    14,                         -- p14
    10,                         -- a10
    'Alumno7', 
    'triggerF', 
    123456789,
    'correo@gmail.com',
    NULL,
    '2010-05-05',
    NULL,
    '00000010A',
    TRUE,
    1,                          -- d1
    NULL
);
-- alumno mayor de edad sin telefono
CALL insertarAlumnoYPersona(
    15,                         -- p15
    11,                         -- a11
    'Alumno11', 
    'triggerF', 
    NULL,
    'correo@gmail.com',
    NULL,
    '2005-05-05',
    NULL,
    '00000011A',
    TRUE,
    1,                          -- d1
    2                           -- t2
);
-- alumno mayor de edad sin correo
CALL insertarAlumnoYPersona(
    16,                         -- p16
    12,                         -- a12
    'Alumno12', 
    'triggerF', 
    123456789,
    NULL,
    NULL,
    '2005-05-05',
    NULL,
    '00000012A',
    TRUE,
    1,                          -- d1
    NULL
);


-- trigger dni
-- alumno <14 con dni
CALL insertarAlumnoYPersona(
    16,                         -- p16
    13,                         -- a13
    'Alumno13', 
    'trigger', 
    123456789,
    'correo@gmail.com',
    NULL,
    '2016-05-05',
    NULL,
    '00000013A',
    TRUE,
    1,                          -- d1
    2                           -- t2
);
-- alumno >=14 con dni
CALL insertarAlumnoYPersona(
    17,                         -- p17
    14,                         -- a14
    'Alumno14', 
    'trigger', 
    123456789,
    'correo@gmail.com',
    NULL,
    '2005-05-05',
    NULL,
    '00000014A',
    TRUE,
    1,                          -- d1
    2                           -- t2
);

-- FALLOS:

-- alumno >14 sin dni
CALL insertarAlumnoYPersona(
    18,                         -- p18
    15,                         -- a15
    'Alumno15', 
    'triggerF', 
    123456789,
    'correo@gmail.com',
    NULL,
    '2005-05-05',
    NULL,
    NULL,
    TRUE,
    1,                          -- d1
    NULL
);


-- trigger cláusula de protección de datos
-- alumno con cpd a true
CALL insertarAlumnoYPersona(
    19,                         -- p19
    16,                         -- a16
    'Alumno16', 
    'trigger', 
    123456789,
    'correo@gmail.com',
    NULL,
    '2005-05-05',
    NULL,
    '00000016A',
    TRUE,
    1,                          -- d1
    NULL
);

-- FALLOS:

-- alumno con cpd a false
CALL insertarAlumnoYPersona(
    20,                         -- p20
    17,                         -- a17
    'Alumno17', 
    'trigger', 
    123456789,
    'correo@gmail.com',
    NULL,
    '2005-05-05',
    NULL,
    '00000017A',
    TRUE,
    1,                          -- d1
    NULL
);


-- trigger grupo completo
-- alumno a grupo con espacio
CALL insertarAlumnosGrupos(
    NULL,
    3,                          -- a3
    1,                          -- g1
    FALSE,
    1                           -- temp 1 (24-25)
);

-- FALLOS:

-- alumno a grupo completo
CALL insertarAlumnosGrupos(
    NULL,
    1,                          -- a1
    2,                          -- g2
    FALSE,
    1                           -- temp 1 (24-25)
);


-- trigger grupo adecuado
CALL insertarGrupo(
    3,                          -- g3
    'Grupo Juvenil-Adulto',
    'Sevilla',
    'Juvenil-Adulto',
    30,
    60
);
CALL insertarGrupo(
    4,                          -- g4
    'Grupo Alevín-Infantil',
    'Sevilla',
    'Alevín-Infantil',
    30,
    60
);
-- alumno <13 en grupo entreno Alevín-Infantil
-- alumno >=13 en grupo entreno Juvenil-Adulto
-- alumno <13 en grupo espera Alevín-Infantil
-- alumno >=13 en grupo espera Juvenil-Adulto

-- FALLOS:

-- alumno <13 en grupo entreno Juvenil-Adulto
-- alumno >=13 en grupo entreno Alevín-Infantil
-- alumno <13 en grupo espera Juvenil-Adulto
-- alumno >=13 en grupo espera Alevín-Infantil


-------------------------

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
