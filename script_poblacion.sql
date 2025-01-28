CALL insertarDomicilio( -- d1
    1,
    'Direccion alumno 1', 
    'Olivares', 
    41804
);

CALL insertarTutorLegalYPersona(
    6,                          -- p6
    1,                          -- t1
    'Tutor legal1', 
    'Sin telefono',
    NULL, 
    'correo@gmail.com',
    'altcorreo@gmail.com',
    'Madre'
);

CALL insertarTutorLegalYPersona(
    7,                          -- p7
    2,                          -- t2
    'Tutor legal2', 
    'Correcto',
    123456789, 
    'correo@gmail.com',
    NULL,
    'Padre'
);

CALL insertarAlumnoYPersona(
    1,                          -- p1
    1,                          -- a1
    'Alumno1', 
    'Mayor edad correcto', 
    123456789,
    'correo@gmail.com',
    NULL,
    '1998-12-22',
    NULL,
    '00000001A',
    TRUE,
    1,                          -- d1
    NULL
);

CALL insertarDomicilio( -- d2
    2,
    'Direccion alumno 2 y 3', 
    'La Rinconada', 
    41300
);

CALL insertarAlumnoYPersona(
    2,                          -- p2
    2,                          -- a2
    'Alumno2', 
    'Mayor edad sin telefono',
    123456789,
    'correo@gmail.com',
    NULL,
    '2000-10-22',
    NULL,
    '00000002A',
    TRUE,
    2,                          -- d2
    NULL
);

CALL insertarInfoSanitaria(
    1,
    'Asmatico',
    2                           -- a2
);

CALL insertarAlumnoYPersona(
    3,                          -- p3
    3,                          -- a3
    'Alumno3', 
    'Menor edad sin correo', 
    123456789,
    NULL,
    NULL,
    '2008-10-22',
    NULL,
    '00000003A',
    TRUE,
    2,                          -- d2
    2                           -- t2
);

CALL insertarDomicilio( -- d3
    3,
    'Direccion alumno 4', 
    'Palomares del Rio',
    41928
);

CALL insertarAlumnoYPersona(
    4,                          -- p4
    4,                          -- a4
    'Alumno4', 
    'Menor edad sin telefono y correo', 
    123456789,
    NULL,
    NULL,
    '2016-10-22',
    NULL,
    '00000004A',
    TRUE,
    3,                          -- d3
    2                           -- t2
);

CALL insertarSenseiYPersona(
    5,                          -- p5
    1,                          -- sens1
    'Sensei1', 
    'Correcto',
    123456789, 
    'correo@gmail.com'
);

CALL insertarGrupo(
    1,                          -- g1
    'Grupo disponible', 
    'Sevilla', 
    'Juvenil-Adulto', 
    15,
    60
);

CALL insertarGrupo(
    2,                          -- g2
    'Grupo completo', 
    'Sevilla', 
    'Alevín-Infantil', 
    2,
    60
);

CALL insertarTemporada( -- temp 1
    1,
    '2024-2025'
);

CALL insertarAlumnosGrupos(
    NULL,
    1,                          -- a1
    1,                          -- g1
    FALSE,
    1                           -- temp 1 (24-25)
);

CALL insertarAlumnosGrupos(
    NULL,
    2,                          -- a2
    1,                          -- g1
    FALSE,
    1                           -- temp 1 (24-25)
);

CALL insertarAlumnosGrupos(
    NULL,
    3,                          -- a3
    2,                          -- g2
    FALSE,
    1                           -- temp 1 (24-25)
);

CALL insertarAlumnosGrupos(
    NULL,
    4,                          -- a4
    2,                          -- g2
    FALSE,
    1                           -- temp 1 (24-25)
);

CALL insertarGrado(
    NULL,
    'Blanco',
    '2023-01-01',
    '2024-01-01',
    '2024-02-01',
    1                          -- a1
);

CALL insertarGrado(
    NULL,
    'Blanco',
    '2024-01-2',
    NULL,
    NULL,
    2                          -- a2
);

CALL insertarGrado(
    NULL,
    'Blanco',
    '2024-01-3',
    NULL,
    NULL,
    3                          -- a3
);

CALL insertarGrado(
    NULL,
    'Blanco',
    '2024-01-4',
    NULL,
    NULL,
    4                          -- a4
);

CALL insertarSesion(
    1,                         -- s1
    '2024-12-05 10:00:00',
    60,
    1,                         -- temp 1 (24-25)
    1                          -- g1
);

CALL insertarSesion(
    2,                         -- s2
    '2024-12-06 10:00:00',
    80,
    1,                         -- temp 1 (24-25)
    2                          -- g2
);

CALL insertarSesion(
    3,                         -- s3
    '2024-12-06 12:00:00',
    80,
    1,                         -- temp 1 (24-25)
    2                          -- g2
);

CALL insertarAsistencia(
    NULL,
    TRUE,
    1,                         -- a1
    1                          -- s1
);

CALL insertarAsistencia(
    NULL,
    TRUE,
    2,                         -- a2
    1                          -- s1
);

CALL insertarAsistencia(
    NULL,
    TRUE,
    3,                         -- a3
    2                          -- s2
);

CALL insertarAsistencia(
    NULL,
    FALSE,
    3,                         -- a3
    3                          -- s3
);

CALL insertarAsistencia(
    NULL,
    TRUE,
    4,                         -- a4
    2                          -- s2
);

CALL insertarAsistencia(
    NULL,
    TRUE,
    4,                         -- a4
    3                          -- s3
);

CALL insertarObservacion(
    NULL,
    '2024-12-05',
    'Se le da bien', 
    1,                         -- a1
    1                          -- sens1
);

CALL insertarAnuncio(
    NULL,
    'Anuncio publicado',
    CURDATE(), 
    'Descripcion 1', 
    1                          -- sens1
);

CALL insertarAnuncio(
    NULL,
    'Anuncio sin publicar con fecha', 
    '2024-12-01', 
    'Descripcion 2', 
    1                          -- sens1
);

CALL insertarPago(
    NULL,
    60.50, 
    '2023-01-01',
    'Bizum', 
    'Mensual', 
    1                          -- a1
);