# Proyecto Gym-Do

## 1. Introducción al problema

El proyecto tiene como objetivo hacer una página web para el dojo de karate GYM-DO, que permita mejorar la gestión interna de la escuela y ofrecer una interfaz digital óptima para los interesados en practicar en el dojo.

---

## 2. Requisitos generales

#### R.G.01 Gestión de los alumnos
Como sensei, quiero gestionar la información de los alumnos para llevar un control adecuado de su evolución.

- PRUEBAS DE ACEPTACIÓN:
  - Un alumno se crea tras completar su formulario de inscripción.
  - Un alumno se actualiza tras completar su formulario de renovación.
  - Un alumno no se puede eliminar.

#### R.G.02 Gestión de los pagos
Como sensei, quiero gestionar los pagos de los alumnos para segurar un control financiero correcto.

- PRUEBAS DE ACEPTACIÓN:
  - El sistema debe gestionar pagos múltiples (un único pago para varios alumnos).
  - El sistema debe comunicar automáticamente al alumno o tutor legal de la realización del pago.
  - El sistema debe guardar la cantidad, la fecha y el método de cada pago.

#### R.G.03 Gestión de los anuncios
Como sensei, quiero publicar anuncios para mantener informados a los alumnos y tutores legales.

- PRUEBAS DE ACEPTACIÓN:
  - Un anuncio es creado por el sensei.
  - Un anuncio es visualizado por los usuarios implicados.
  - Un anuncio puede ser modificado, llegando su actualización como si de un nuevo anuncio se tratara.
  - Un anuncio puede ser eliminado.

#### R.G.04 Gestión de las sesiones
Como sensei, quiero gestionar las sesiones de cada grupo para controlar la asistencia de los alumnos y ajustar las clases de cada temporada.

- PRUEBAS DE ACEPTACIÓN:
  - El sistema debe de crear automáticamente las sesiones de cada grupo de una temporada.
  - Una sesión se puede crear manualmente.
  - Una sesión se puede modificar manualmente.
  - Una sesión se puede eliminar manualmente.
  - El sistema debe comprobar la asistencia de los alumnos a la sesión de su correspondiente grupo.

---

## 3. Requisitos funcionales

#### R.F.01.1 Creación de Alumno  
Permitir la creación de un nuevo alumno mediante un formulario de inscripción online.

#### R.F.01.2 Actualización de Estado  
Actualizar automáticamente el estado del alumno a "activo" tras la renovación de su inscripción tras realizar el formulario de renovación.

#### R.F.01.3 Validación de Renovación  
Validar que solo los alumnos ya registrados puedan acceder al formulario de renovación.

#### R.F.01.4 Prohibición de Eliminación  
Prohibir la eliminación de la información de un alumno para mantener un registro histórico.

#### R.F.01.5 Cláusula de Protección de Datos
Asegurar que el alumno acepte una cláusula de protección de datos antes de completar el formulario de inscripción.

#### R.F.01.6 Informes Individuales  
Generar informes individuales de cada alumno, con datos de su asistencia, grado, y evolución.

#### R.F.01.7 Estadísticas de Rendimiento  
Generar estadísticas de rendimiento de cada grupo, comparando la evolución de sus integrantes.

#### R.F.01.8 Historial de Ascensos  
Almacenar un historial de los grado que ha tenido cada alumno y cuándo lo consiguió para un seguimiento detallado.

#### R.F.02.1 Registro de Pagos  
Permitir la creación de registros de pago únicos que cubran a varios alumnos a la vez.

#### R.F.02.2 Confirmación de Pago  
Enviar un recibo de confirmación de pago al correo electrónico del alumno o tutor legal.

#### R.F.02.3 Almacenamiento de Información de Pago  
Guardar la información de cada pago, incluyendo la cantidad, fecha, y tipo de pago (único, mensual, bimensual).

#### R.F.02.4 Métodos de Pago  
Habilitar la opción de distintos métodos de pago, como transferencia bancaria, efectivo, PayPal y Bizum.

#### R.F.03.1 Programación de Anuncios  
Permitir la programación de anuncios para que el sensei pueda planificar la publicación automática de los mismos en fechas y horas específicas.

#### R.F.03.2 Notificación de Nuevos Anuncios  
Enviar una notificación automática a los usuarios involucrados cuando se publique un nuevo anuncio.

#### R.F.03.3 Edición de Anuncios  
Permitir la edición de un anuncio publicado, notificando a los usuarios de cualquier actualización.

#### R.F.03.4 Eliminación de Anuncios  
Posibilitar la eliminación de anuncios antiguos para mantener la plataforma actualizada.

#### R.F.04.1 Automatización de Creación de Sesiones  
Automatizar la creación de sesiones semanales para cada grupo basado en el calendario de la temporada.

#### R.F.04.2 Edición Manual de Sesiones  
Habilitar la edición manual de sesiones para ajustar fechas y horarios.

#### R.F.04.3 Registro de Asistencia  
Integrar un sistema de registro de asistencia para cada sesión y generar un reporte de la misma.

#### R.F.04.4 Eliminación de Sesiones  
Permitir la eliminación de sesiones programadas en caso de eventos imprevistos.

---

## 4. Requisitos de información

#### R.I.01.1 Información de alumno
Como sensei, quiero guardar información de mis alumnos, en concreto:
nombre, apellidos, fecha de nacimiento, domicilio (dirección, municipio, código postal), información de contacto (teléfono, correo electrónico), grupo, dni, información sanitaria de interés, razón de inscripción, grado actual (Blanco, Blanco-Amarillo, Amarillo, Amarillo-Naranja, Naranja, Naranja-Verde, Verde, Verde-Azul, Azul, Azul-Marrón, Marrón, Negro, Negro 1º Dan, ..., Negro 10º Dan), observaciones (anotación, fecha), código federativo, estado (activo, inactivo, aceptaClausula), fecha de la primera práctica

#### R.I.01.2 Información de tutor legal
Como sensei, quiero guardar información de los tutores legales de mis alumnos, en concreto:
nombre, apellidos, parentesco, información de contacto (teléfono, correo electrónico, correo electrónico alternativo).

#### R.I.01.3 Información de grupo
Como sensei, quiero guardar información de los grupos, en concreto:
nombre, alumnos en grupo, límite de alumnos, alumnos en lista de espera, categoría (alevín/infantil, juvenil/adulto), ubicación, precio mensual

#### R.I.01.4 Información de grados
Como sensei, quiero guardar información de los grados de mis alumnos, en concreto:
grado de cinturón, fecha inicio, fecha fin, fecha licencia, alumno

#### R.I.02.1 Información de pagos
Como sensei, quiero guardar información de los pagos realizados por los alumnos, en concreto: 
cantidad, fecha, financiación (inicial, mensual, bimensual), método (metálico, transferencia bancaria, PayPal, Bizum).

#### R.I.03.1 Información de Anuncios
Como sensei, quiero guardar información de la programación de anuncios, en concreto:
fecha y hora, sensei, estado (publicado, sin publicar), asunto, descripción.

#### R.I.04.1 Información de Sesiones 
Como sensei, quiero registrar la información sobre las sesiones, en concreto:
grupo, fecha y hora, temporada

#### R.I.04.2 Información de Asistencia 
Como sensei, quiero registrar la información de asistencia para cada sesión, en concreto:
sesión, alumno, asistencia (presente, ausente)

---

## 5. Reglas de negocio

#### R.N.01.1 Creación alumno
Un alumno nuevo sólo podrá ser añadido al sistema si tiene todos los campos del formulario de inscripción completos, a excepción de:
 número de contacto del alumno: obligatorio si el alumno es mayor de edad,
 correo electrónico del alumno: obligatorio si el alumno es mayor de edad,
 dni: obligatorio si el alumno tiene más de 14 años,
 información sanitaria de interés: opcional,
 razón de inscripción: opcional,
 nombre del tutor legal: opcional,
 apellidos del tutor legal: opcional,
 número de contacto del tutor legal: obligatorio si el alumno es menor de edad,
 correo electrónico del tutor legal: obligatorio si el alumno es menor de edad,
 correo electrónico alternativo: opcional

- PRUEBAS DE ACEPTACIÓN:
    - alumno correcto, grupo disponible: CORRECTO
    - alumno correcto, grupo completo: FALLO
    - alumno menor de edad olvida el número de contacto del tutor legal: FALLO
    - alumno menor de edad olvida el correo electrónico del tutor legal: FALLO
    - alumno menor de 14 años intenta meter DNI: CORRECTO (se guada como null)
    - alumno mayor de 14 años olvida DNI: FALLO
    - alumno mayor de edad olvida su número de contacto: FALLO
    - alumno mayor de edad olvida su correo electrónico: FALLO
    - alumno olvida aceptar la cláusula de protección de datos: FALLO
    - alumno duplicado: FALLO

#### R.N.01.2 Actualización alumno
Un alumno sólo podrá ser actulizado en el sistema si tiene todos los campos del formulario de renovación completos.

- PRUEBAS DE ACEPTACIÓN:
    - alumno correcto, grupo disponible: CORRECTO
    - alumno correcto, grupo completo: FALLO
    - alumno olvida su identificador: FALLO

#### R.N.01.3 Eliminación alumno
Un alumno no podrá ser eliminado del sistema.

- PRUEBAS DE ACEPTACIÓN:
    - se intenta eliminar: FALLO

#### R.N.01.4 Crear grupo
Un grupo sólo podrá ser creado si tiene completos todos sus campos.

- PRUEBAS DE ACEPTACIÓN:
    - grupo correcto: CORRECTO
    - grupo sin algún campo: FALLO
    - grupo con nombre repetido: FALLO
    - grupo con limite alumno negativo: FALLO

#### R.N.01.5 Actualizar grupo
Un grupo puede ser actualizado sólo si todos sus campos me mantienen completos tras la modificación

- PRUEBAS DE ACEPTACIÓN:
    - grupo correcto: CORRECTO
    - grupo con nombre repetido: FALLO

#### R.N.01.6 Eliminar grupo
Un grupo no puede ser eliminado.

- PRUEBAS DE ACEPTACIÓN:
    - se intenta eliminar: FALLO

#### R.N.01.7 Código Federativo
Un alumno debe tener un código federativo único que lo identifique en el sistema.

- PRUEBAS DE ACEPTACIÓN:
    - Código federativo válido: CORRECTO
    - Código federativo ya existente: FALLO (poner a null o dejar antiguo)

#### R.N.01.8 Cláusula de protección de datos
Todos los alumnos deben aceptar la cláusula de protección de datos para que se pueda registrar su información en el sistema.

- PRUEBAS DE ACEPTACIÓN:
    - Cláusula de protección de datos aceptada: CORRECTO
    - Cláusula de protección de datos no aceptada: FALLO

#### R.N.01.9 Creación grado
El sistema debe permitir apuntar nuevos grados.

- PRUEBAS DE ACEPTACIÓN:
    - Grado válido: CORRECTO
    - Grado duplicado: FALLO
    - Grado sin cinturón: FALLO
    - Grado sin fecha inicio: CORRECTO (fecha inicio = actual)
    - Grado sin fecha fin: CORRECTO
    - Grado sin fecha licencia: CORRECTO
    - Grado sin alumno: FALLO
    - Grado coincidente en alumno, cinturón: FALLO
    - fecha inicio posterior a la actual: FALLO
    - fecha licencia posterior a la actual: FALLO
    - fecha fin posterior a la actual: FALLO
    - fecha licencia anterior a la inicial: FALLO
    - fecha fin anterior a la inicial: FALLO

#### R.N.01.10 Actualizar grado
El sistema debe permitir editar los grados de los alumnos.

- PRUEBAS DE ACEPTACIÓN:
    - Actualización correcta: CORRECTO
    - fechas inválidas: FALLO
    - grado que pasa a ser duplicado: FALLO

#### R.N.01.11 Tiempo mínimo de grado
Un alumno debe cumplir un tiempo mínimo con el grado que tenga para poder obtener el siguiente.

- PRUEBAS DE ACEPTACIÓN:
    - grado nuevo tiempo cumplido: CORRECTO
    - grado nuevo tiempo sin cumplir: FALLO

#### R.N.01.12 Categorías de los grupos
Un grupo sólo puede ser de la categoría Alevín-Infantil o Juvenil-Adulto.

- PRUEBAS DE ACEPTACIÓN:
    - Categoría correcta: CORRECTO
    - Categoría inexistente: FALLO

#### R.N.01.13 Estados de los alumnos
El estado de un alumno sólo puede ser activo o inactivo, y es calculado automáticamente dependiendo de si pertenece a algún grupo o a alguna lista de espera de un grupo.

- PRUEBAS DE ACEPTACIÓN:
    - Comprobar activo: CORRECTO (sale activo)
    - Comprobar inactiva: CORRECTO (sale inactivo)

#### R.N.01.14 Cinturones de los grados
Un grado sólo puede ser blanco, blanco-amarillo, amarillo, amarillo-naranja, naranja, naranja-verde, verde, verde-azul, azul, azul-marrón, marrón, negro, negro 1º Dan, negro 2º Dan, negro 3º Dan, negro 4º Dan, negro 5º Dan, negro 6º Dan, negro 7º Dan, negro 8º Dan, negro 9º Dan, negro 10º Dan.

- PRUEBAS DE ACEPTACIÓN:
    - Cinturón correcto: CORRECTO
    - Cinturón inexistente: FALLO

#### R.N.01.15 Eliminar grado
Un grado no puede ser eliminado.

- PRUEBAS DE ACEPTACIÓN:
  - intentar eliminar: FALLO

#### R.N.01.16 Alumno en dos grupos
Un alumno no puede estar en dos grupos a la vez.

- PRUEBAS DE ACEPTACIÓN:
    - alumno en dos grupos: FALLO

#### R.N.01.17 Alumno en grupo disponible
Un grupo lleno no puede aceptar más alumnos.

- PRUEBAS DE ACEPTACIÓN:
    - grupo lleno: FALLO

#### R.N.02.1 Registro de Pagos
El sistema debe permitir el registro de pagos que cubran múltiples alumnos a la vez, y asegurarse de que se incluya la cantidad, fecha, y método de pago.

- PRUEBAS DE ACEPTACIÓN:
    - Pago individual válido: CORRECTO
    - Falta de algún campo: FALLO

#### R.N.02.2 Comunicación de Pago
El sistema debe enviar automáticamente una notificación al correo electrónico del alumno o tutor legal cuando se registre un pago.

- PRUEBAS DE ACEPTACIÓN:
    - realizar pago: CORRECTO

#### R.N.02.3 Métodos de pago de los pagos
Un pago sólo puede ser del método de pago efectivo, transferencia bancaria, paypal o bizum.

- PRUEBAS DE ACEPTACIÓN:
    - Categoría correcta: CORRECTO
    - Categoría inexistente: FALLO

#### R.N.02.4 Financiamiento de los pagos
Un pago sólo puede ser corresponder al pago inicial, mensual o bimensual.

- PRUEBAS DE ACEPTACIÓN:
    - Financiamiento correcto: CORRECTO
    - Financiamiento inexistente: FALLO

#### R.N.03.1 Publicación de Anuncios
El sistema debe permitir la publicación de anuncios y de anuncios programados con anterioridad.

- PRUEBAS DE ACEPTACIÓN:
    - Publicación programada correcta: CORRECTO
    - Publicación instantánea correcta: CORRECTO

#### R.N.03.2 Edición de Anuncios
El sistema debe permitir la edición de anuncios.

- PRUEBAS DE ACEPTACIÓN:
    - Anuncio publicado: CORRECTO
    - Anuncio sin publicar: CORRECTO

#### R.N.03.3 Eliminación de Anuncios
El sistema debe permitir eliminar anuncios.

- PRUEBAS DE ACEPTACIÓN:
    - Anuncio publicado: CORRECTO
    - Anuncio no publicado: CORRECTO

#### R.N.03.4 Estados de los anuncios
Un anuncio sólo puede estar publicado o sin publicar.

- PRUEBAS DE ACEPTACIÓN:
    - Estado correcto: CORRECTO
    - Estado inexistente: FALLO

#### R.N.04.1 Creación de Sesiones
El sistema debe generar automáticamente sesiones semanales para cada grupo basándose en el calendario de la temporada y las reglas definidas.

- PRUEBAS DE ACEPTACIÓN:
    - generar correcto: CORRECTO
    - generar fechas pasadas: FALLO ?

#### R.N.04.2 Edición de Sesiones
El sistema debe permitir que el sensei edite manualmente las fechas, horas o lugares de las sesiones programadas, asegurando que cualquier modificación sea notificada a los usuarios involucrados.

- PRUEBAS DE ACEPTACIÓN:
    - Edición manual exitosa: CORRECTO
    - Edición sin algún campo: CORRECTO (no modificaciones en esos)

#### R.N.04.3 Registro de Asistencia  
El sistema debe permitir el registro de asistencia durante cada sesión de manera individual o grupal, y debe generar un reporte detallado para el sensei, mostrando el estado de asistencia de cada alumno.

- PRUEBAS DE ACEPTACIÓN:
    - asiste 1 alumno: CORRECTO
    - asisten varios alumnos: CORRECTO

#### R.N.04.4 Eliminación de Sesiones  
El sistema debe permitir la eliminación de sesiones en caso de eventos imprevistos. Se debe registrar un historial con el motivo de la eliminación.

- PRUEBAS DE ACEPTACIÓN:
    - intentar eliminar: CORRECTO

#### R.N.04.5 Sesiones no coincidentes
No puede haber dos sesiones que coincidan en fecha, hora y ubicación.

- PRUEBAS DE ACEPTACIÓN:
    - sesión duplicada: FALLO

---

## 6. Mapa de historias de usuario

- [R.G.01. Gestión alumnos](#rg01-gestión-de-los-alumnos)
  - [R.F.01.1 Creación alumno](#rf011-creación-de-alumno)
  - [R.F.01.2 Actualizar estado](#rf012-actualización-de-estado)
  - [R.F.01.3 Validar renovación](#rf013-validación-de-renovación)
  - [R.F.01.4 Prohibición eliminación](#rf014-prohibición-de-eliminación)
  - [R.F.01.5 Cláusula de Protección de Datos](#rf015-cláusula-de-protección-de-datos)
  - [R.F.01.6 Informes individuales](#rf016-informes-individuales)
  - [R.F.01.7 Estadísticas rendimiento](#rf017-estadísticas-de-rendimiento)
  - [R.F.01.8 Historial grados](#rf018-historial-de-ascensos)
  - [R.I.01.1 Información alumno](#ri011-información-de-alumno)
    - [R.N.01.1 Creación alumno](#rn011-creación-alumno)
    - [R.N.01.2 Actualización alumno](#rn012-actualización-alumno)
    - [R.N.01.3 Eliminación alumno](#rn013-eliminación-alumno)
    - [R.N.01.7 Código Federativo](#rn017-código-federativo)
    - [R.N.01.8 Protección de datos](#rn018-cláusula-de-protección-de-datos)
    - [R.N.01.13 Estados de los alumnos](#rn0113-estados-de-los-alumnos)
    - [R.N.01.16 Alumno en dos grupos](#rn0116-alumno-en-dos-grupos)
    - [R.N.01.17 Alumno en grupos disponibles](#rn0117-alumno-en-grupo-disponible)
  - [R.I.01.2 Información tutor legal](#ri012-información-de-tutor-legal)
    - [R.N.01.1 Creación alumno](#rn011-creación-alumno)
  - [R.I.01.3 Información grupo](#ri013-información-de-grupo)
    - [R.N.01.4 Crear grupo](#rn014-crear-grupo)
    - [R.N.01.5 Actualizar grupo](#rn015-actualizar-grupo)
    - [R.N.01.6 Eliminar grupo](#rn016-eliminar-grupo)
    - [R.N.01.12 Categorías de los grupos](#rn0112-categorías-de-los-grupos)
  - [R.I.01.4 Información grados](#ri014-información-de-grados)
    - [R.N.01.9 Creación grado](#rn019-creación-grado)
    - [R.N.01.10 Actualización grado](#rn0110-actualizar-grado)
    - [R.N.01.11 Tiempo mínimo grado](#rn0111-tiempo-mínimo-de-grado)
    - [R.N.01.14 Cinturones de los grados](#rn0114-cinturones-de-los-grados)
    - [R.N.01.15 Eliminación grado](#rn0115-eliminar-grado)

- [R.G.02. Gestión pagos](#rg02-gestión-de-los-pagos)
  - [R.F.02.1 Registro pagos](#rf021-registro-de-pagos)
  - [R.F.02.2 Confirmación pago](#rf022-confirmación-de-pago)
  - [R.F.02.3 Almacenamiento información pago](#rf023-almacenamiento-de-información-de-pago)
  - [R.F.02.4 Métodos pago](#rf024-métodos-de-pago)
  - [R.I.02.1 Información de pagos](#ri021-información-de-pagos)
    - [R.N.02.1 Registro de Pagos](#rn021-registro-de-pagos)
    - [R.N.02.2 Comunicación de Pago](#rn022-comunicación-de-pago)
    - [R.N.02.3 Métodos de pago de los pagos](#rn023-métodos-de-pago-de-los-pagos)
    - [R.N.02.4 Financiamiento de los pagos](#rn024-financiamiento-de-los-pagos)

- [R.G.03. Gestión anuncios](#rg03-gestión-de-los-anuncios)
  - [R.F.03.1 Programación anuncios](#rf031-programación-de-anuncios)
  - [R.F.03.2 Notificación anuncios](#rf032-notificación-de-nuevos-anuncios)
  - [R.F.03.3 Edición anuncios](#rf033-edición-de-anuncios)
  - [R.F.03.4 Eliminación anuncios](#rf034-eliminación-de-anuncios)
  - [R.I.03.1 Información de Anuncios](#ri031-información-de-anuncios)
    - [R.N.03.1 Publicación de Anuncios](#rn031-publicación-de-anuncios)
    - [R.N.03.2 Edición de Anuncios](#rn032-edición-de-anuncios)
    - [R.N.03.3 Eliminación de Anuncios](#rn033-eliminación-de-anuncios)
    - [R.N.03.4 Estados de los anuncios](#rn034-estados-de-los-anuncios)

- [R.G.04. Gestión sesiones](#rg04-gestión-de-las-sesiones)
  - [R.F.04.1 Automatización sesiones](#rf041-automatización-de-creación-de-sesiones)
  - [R.F.04.2 Edición sesiones](#rf042-edición-manual-de-sesiones)
  - [R.F.04.3 Registro asistencia](#rf043-registro-de-asistencia)
  - [R.F.04.4 Eliminación sesiones](#rf044-eliminación-de-sesiones)
  - [R.I.04.1 Información de Sesiones](#ri041-información-de-sesiones)
    - [R.N.04.1 Creación de Sesiones](#rn041-creación-de-sesiones)
    - [R.N.04.2 Edición de Sesiones](#rn042-edición-de-sesiones)
    - [R.N.04.4 Eliminación de Sesiones](#rn044-eliminación-de-sesiones)
    - [R.N.04.5 Sesiones no coincidentes](#rn045-sesiones-no-coincidentes)
  - [R.I.04.2 Información de Asistencia](#ri042-información-de-asistencia)
    - [R.N.04.3 Registro de Asistencia](#rn043-registro-de-asistencia)

---

## 7. Modelo conceptual

![<diagramaUML>](<img/DiagramaUML.drawio.png>)

## 8. Modelo relacional
- Personas (!personaId, teléfono, correo, nombre, apellidos)
- Domicilios (!domicilioId, direccion, municipio, cp)
- TutoresLegales (!tutorId, correoAlternativo, parentesco, personaId @Personas)
- Temporadas (!temporadaId, temporada)
- Grupos (!grupoId, nombre, limiteAlumnos, categoria, ubicacion, precioMes)
- Alumnos (!alumnoId, razonInscripcion, fechaNacimiento, codigoFederativo, dni, clausulaPDD, personaId @Personas, domicilioId @Domicilios, tutorId @TutoresLegales)
- AlumnosGrupos (!alumnosGruposId, alumnoId @Alumnos, grupoId @Grupos, esLista, temporada @Temporadas)
- Grados (!gradoId, gradoCinturon, fechaInicio, fechaFin,  fechaLicencia, alumnoId @Alumnos)
- Senseis (!senseiId, personaId @Personas)
- Sesiones (!sesionId, fechaHora, temporada @Temporadas, grupoId @Grupos)
- Asistencias (!asistenciaId, alumnoPresente, alumnoId @Alumnos, sesionId @Sesiones)
- Observaciones (!observacionId, fecha, argumento, alumnoId @Alumnos, senseiId @Senseis)
- Anuncios (!anuncioId, asunto, fechaHora, descripcion, seseiId @Senseis)
- InfosSanitarias (!infoSanitariaId, argumento, alumnoId @Alumnos)
- Pagos (!pagoId, cantidad, fecha, metodo, financiamiento, alumnoId @Alumnos)