-- Personas:
-- P1:
INSERT INTO Personas (nombre, apellidos, telefono, correo)
VALUES ('Alumno1', 'Mayor edad correcto', 000000001, 'a1@gmail.com');
-- P2:
INSERT INTO Personas (nombre, apellidos, telefono, correo)
VALUES ('Alumno2', 'Mayor edad sin telefono', 111111111, 'a2@gmail.com');
-- P3:
INSERT INTO Personas (nombre, apellidos, telefono, correo)
VALUES ('Alumno3', 'Menor edad sin correo', 000000003, NULL);
-- P4:
INSERT INTO Personas (nombre, apellidos, telefono, correo)
VALUES ('Alumno4', 'Menor edad sin telefono y correo', NULL, NULL);
-- P5:
INSERT INTO Personas (nombre, apellidos, telefono, correo)
VALUES ('Sensei1', 'Correcto', 999999999, 's1@gmail.com');
-- P6:
INSERT INTO Personas (nombre, apellidos, telefono, correo)
VALUES ('Tutor legal1', 'Sin telefono', 999999998, 't2@gmail.com');
-- P7:
INSERT INTO Personas (nombre, apellidos, telefono, correo)
VALUES ('Tutor legal2', 'Correcto', 999999997, 't1@gmail.com');


-- Domicilio:
-- Domicilio 1 / A1:
INSERT INTO Domicilios (direccion, municipio, cp)
VALUES ('Direccion alumno 1', 'Olivares', 41804);
-- Domicilio 2 / A2 Y A3:
INSERT INTO Domicilios (direccion, municipio, cp)
VALUES ('Direccion alumno 2 y 3', 'La Rinconada', 41300);
-- Domicilio 3 / A4:
INSERT INTO Domicilios (direccion, municipio, cp)
VALUES ('Direccion alumno 4', 'Palomares del Rio', 41928);


-- Tutores Legales:
-- Tutor legal 1 / Persona 6: Sin teléfono (no la metemos como madre a2 pq es mayor edad)
INSERT INTO TutoresLegales (correoAlternativo, parentesco, personaId)
VALUES ('altm2&3@gmail.com', 'Madre', 6);
-- Tutor legal 2 / Persona 7: Datos completos
INSERT INTO TutoresLegales (correoAlternativo, parentesco, personaId)
VALUES (NULL, 'Padre', 7);


-- Grupos:
-- Grupos validos: 
-- G1_Disponible: Grupo con espacio disponible.  
INSERT INTO Grupos(nombre, ubicacion, categoria, limiteAlumnos, precioMes)
VALUES ('Grupo A', 'Sevilla', 'Juvenil-Adulto', 15, 60);
-- G2_Completo: Grupo lleno.  
INSERT INTO Grupos(nombre, ubicacion, categoria, limiteAlumnos, precioMes)
VALUES ('Grupo B', 'Sevilla', 'Alevín-Infantil', 2, 60);


-- Alumnos:
-- Alumno 1 / Persona 1: Mayor de edad con datos completos G1
INSERT INTO Alumnos (razonInscripcion, fechaNacimiento, codigoFederativo, dni, clausulaPDD, personaId, domicilioId, tutorId, grupoIdEntreno, grupoIdEspera)
VALUES ('Motivo Personal', '1998-12-22', 00001, '00000001A', TRUE, 1, 1, NULL, 1, NULL);
-- Alumno 2 / Persona 2: Menor de edad sin teléfono G1 hijo t1
INSERT INTO Alumnos (razonInscripcion, fechaNacimiento, codigoFederativo, dni, clausulaPDD, personaId, domicilioId, tutorId, grupoIdEntreno, grupoIdEspera)
VALUES ('Motivo Personal', '2008-10-22', 00002, '00000002A', TRUE, 2, 2, 2, 1, NULL);
-- Alumno 3 / Persona 3: Menor de edad sin correo G2 hijo t1
INSERT INTO Alumnos (razonInscripcion, fechaNacimiento, codigoFederativo, dni, clausulaPDD, personaId, domicilioId, tutorId, grupoIdEntreno, grupoIdEspera)
VALUES ('Motivo Personal', '2008-10-22', 00003, '00000003A', TRUE, 3, 2, 2, 2, NULL);
-- Alumno 4 / Persona 4: Alumno completo menor edad sin telefono sin correo G2 hijo t2 
INSERT INTO Alumnos (razonInscripcion, fechaNacimiento, codigoFederativo, dni, clausulaPDD, personaId, domicilioId, tutorId, grupoIdEntreno, grupoIdEspera)
VALUES ('Motivo Personal', '2008-10-22', 00004, '00000004A', TRUE, 4, 3, 2, 2, NULL);


-- Grados:
-- Grado_Alumno1: Grado con fecha de licencia.  
INSERT INTO Grados(gradoCinturon, fechaInicio, fechaFin, fechaLicencia, alumnoId)
VALUES ('Blanco', '2023-01-01', '2024-02-01', '2024-01-01', 1);
-- Grado2_SinLicencia: Grado sin fecha de licencia.  
INSERT INTO Grados(gradoCinturon, fechaInicio, fechaFin, fechaLicencia, alumnoId)
VALUES ('Blanco', '2024-01-2', NULL, NULL, 2);
-- Grado2_SinLicencia: Grado sin fecha de licencia.  
INSERT INTO Grados(gradoCinturon, fechaInicio, fechaFin, fechaLicencia, alumnoId)
VALUES ('Blanco', '2024-01-3', NULL, NULL, 3);
-- Grado2_SinLicencia: Grado sin fecha de licencia.  
INSERT INTO Grados(gradoCinturon, fechaInicio, fechaFin, fechaLicencia, alumnoId)
VALUES ('Blanco', '2024-01-4', NULL, NULL, 4);


-- Senseis:
-- Sensei 1 / Persona 5: Senseis correctos:
INSERT INTO Senseis(personaId)
VALUES (4);


-- Sesiones:
-- Sesion1_Correcta G1 1
INSERT INTO Sesiones(fechaHora, temporada, grupoId)
VALUES ('2024-12-05 10:00:00', '2024/25', 1);
-- Sesion2_Correcta G2 1
INSERT INTO Sesiones(fechaHora, temporada, grupoId)
VALUES ('2024-12-06 12:00:00', '2024/25', 2);
-- Sesion3_Correcta G2 2
INSERT INTO Sesiones(fechaHora, temporada, grupoId)
VALUES ('2024-12-07 10:00:00', '2024/25', 2);


-- Asistencias:
-- Asistencias A1:
INSERT INTO Asistencias(alumnoPresente, alumnoId, sesionId)
VALUES (TRUE, 1, 1);
-- Asistencias A2:
INSERT INTO Asistencias(alumnoPresente, alumnoId, sesionId)
VALUES (TRUE, 2, 1);
-- Asistencias A3:
INSERT INTO Asistencias(alumnoPresente, alumnoId, sesionId)
VALUES (TRUE, 3, 2);
-- Asistencias A4
INSERT INTO Asistencias(alumnoPresente, alumnoId, sesionId)
VALUES (TRUE, 3, 3);
-- Asistencias A5:
INSERT INTO Asistencias(alumnoPresente, alumnoId, sesionId)
VALUES (TRUE, 4, 2);
-- Asistencias A6
INSERT INTO Asistencias(alumnoPresente, alumnoId, sesionId)
VALUES (TRUE, 4, 3);


-- Observaciones:
-- Observacion A1, S1, Primera Sesion
INSERT INTO Observaciones(fecha, argumento, alumnoId, senseiId)
VALUES ('2024-12-05', 'Se le da bien', 1, 1);


-- Anuncios correctos:
-- Anuncio1_Publicado: Anuncio publicado.
INSERT INTO Anuncios(asunto, fechaHora, descripcion, senseiId)
VALUES ('Anuncio publicado', CURDATE(), 'Descripcion 1', 1);
-- Anuncio2_SinPublicar: Anuncio sin publicar con fecha.
INSERT INTO Anuncios(asunto, fechaHora, descripcion, senseiId)
VALUES ('Anuncio sin publicar con fecha', '2024-12-01', 'Descripcion 2', 1);


-- Info sanitaria:
-- Info sanitaria A2:
INSERT INTO InfosSanitarias(argumento, alumnoId)
VALUES ('Asmatico', 2);


-- Pagos:
-- Pago1_Individual A4: Pago individual.  
INSERT INTO Pagos(cantidad, fecha, metodo, financiamiento, alumnoId)
VALUES (60.50, '2023-01-01', 'Bizum', 'Mensual', 1);