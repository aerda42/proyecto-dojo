# Proyecto Gym-Do

## 1. Introducción al problema

El proyecto tiene como objetivo hacer una página web para el dojo de karate GYM-DO, que permita mejorar la gestión interna de la escuela y ofrecer una interfaz digital óptima para los interesados en practicar en el dojo.

---

## 2. Requisitos generales

#### R.G.01 Gestión de los alumnos
Como sensei, quiero gestionar la información de los alumnos para llevar un control adecuado de su evolución.

PRUEBAS DE ACEPTACIÓN:
- Un alumno se crea tras completar su formulario de inscripción.
- Un alumno se actualiza tras completar su formulario de renovación.
- Un alumno no se puede eliminar.

#### R.G.02 Gestión de los pagos
Como sensei, quiero gestionar los pagos de los alumnos para segurar un control financiero correcto.

PRUEBAS DE ACEPTACIÓN:
- El sistema debe gestionar pagos múltiples (un único pago para varios alumnos).
- El sistema debe comunicar automáticamente al alumno o tutor legal de la realización del pago.
- El sistema debe guardar la cantidad, la fecha y el método de cada pago.

#### R.G.03 Gestión de los anuncios
Como sensei, quiero publicar anuncios para mantener informados a los alumnos y tutores legales.

PRUEBAS DE ACEPTACIÓN:
- Un anuncio es creado por el sensei.
- Un anuncio es visualizado por los usuarios implicados.
- Un anuncio puede ser modificado, llegando su actualización como si de un nuevo anuncio se tratara.
- Un anuncio puede ser eliminado.

#### R.G.04 Gestión de las sesiones
Como sensei, quiero gestionar las sesiones de cada grupo para controlar la asistencia de los alumnos y ajustar las clases de cada temporada.

PRUEBAS DE ACEPTACIÓN:
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
12. fecha licencia anterior a la inicial
  - hay una lista con todos los grados
  - se intenta añadir un grado con fecha inicio = 19/12/2024, fecha licencia = 1/1/1999
  - se comprueba que el grado no está en la lista
13. fecha fin anterior a la inicial
  - hay una lista con todos los grados
  - se intenta añadir un grado con fecha inicio = 19/12/2024, fecha fin = 1/1/1999
  - se comprueba que el grado no está en la lista

#### R.N.01.10 Actualizar grado
El sistema debe permitir editar los grados de los alumnos.

PRUEBAS DE ACEPTACIÓN:
1. Actualización correcta
  - hay una lista con todos los grados
  - se añade un grado con: fecha inicio = 1/10/2024, fecha fin = 1/11/2024, fecha licencia = 5/11/2024, grado = blanco-amarillo, alumno = A1
  - se intenta modificar la licencia con: fecha fin = 1/09/2024
  - se comprueba que la licencia está en la lista con los cambios realizados
2. fechas inválidas
  - hay una lista con todos los grados
  - se añade un grado con: fecha inicio = 1/10/2024, fecha licencia = 1/11/2024, grado = blanco-amarillo, alumno = A1
  - se intenta modificar la licencia con: fecha licencia = 1/12/2024
  - se comprueba que el grado no se actualiza
3. grado que pasa a ser duplicado
  - hay una lista con todos los grados
  - se añade un grado con: fecha inicio = 19/12/2024, fecha fin = 30/12/2024, fecha licencia = 05/01/2025, grado = blanco-amarillo, alumno = 1
  - se intenta añadir un grado con fecha inicio = 19/12/2024, fecha fin = 30/12/2024, fecha licencia = 05/01/2025, grado = blanco-amarillo, alumno = 1
  - se comprueba que el grado no está en la lista

#### R.N.01.11 Tiempo mínimo de grado
Un alumno debe cumplir un tiempo mínimo con el grado que tenga para poder obtener el siguiente.

PRUEBAS DE ACEPTACIÓN:
1. Tiempo cumplido
  - hay una lista con todos los grados que ha tenido un alumno
  - se comprueba que el grado más reciente del alumno A1 tiene cumple tiempo minimo = FALSE
  - se intenta añadir a la lista un grado nuevo al alumno A1
  - se comprueba que el grado no está en la lista
2. Tiempo sin cumplir
  - hay una lista con todos los grados que ha tenido un alumno
  - se comprueba que el grado más reciente del alumno A1 tiene cumple tiempo minimo = TRUE
  - se intenta añadir a la lista un grado nuevo al alumno A1
  - se comprueba que el grado está en la lista

#### R.N.01.12 Categorías de los grupos
Un grupo sólo puede ser de la categoría Alevín-Infantil o Juvenil-Adulto.

PRUEBAS DE ACEPTACIÓN:
1. Categoría correcta
  - hay una lista con todos los grupos
  - se intenta añadir un grupo con categoría = "Alevín-Infantil"
  - se compueba que el grupo está en la lista
2. Categoría inexistente
  - hay una lista con todos los grupos
  - se intenta añadir un grupo con categoría = "Experto"
  - se compueba que el grupo no está en la lista

#### R.N.01.13 Estados de los alumnos
El estado de un alumno sólo puede ser activo o inactivo, y es calculado automáticamente dependiendo de si pertenece a algún grupo o a alguna lista de espera de un grupo.

PRUEBAS DE ACEPTACIÓN:
1. Comprobar activo
  - hay una lista con todos los alumnos
  - se intenta añadir un alumno con grupoIdEntreno = 1, grupoIdEspera = NULL
  - se compueba que el alumno está en la lista
  - hay una vista con todos los alumnos
  - se comprueba que el alumno está en la vista con estadoAlumno = 'Activo'
2. Comprobar inactiva
  - hay una lista con todos los alumnos
  - se intenta añadir un alumno con grupoIdEntreno = NULL, grupoIdEspera = NULL
  - se compueba que el alumno está en la lista
  - hay una vista con todos los alumnos
  - se comprueba que el alumno está en la vista con estadoAlumno = 'Inactivo'

#### R.N.01.14 Cinturones de los grados
Un grado sólo puede ser blanco, blanco-amarillo, amarillo, amarillo-naranja, naranja, naranja-verde, verde, verde-azul, azul, azul-marrón, marrón, negro, negro 1º Dan, negro 2º Dan, negro 3º Dan, negro 4º Dan, negro 5º Dan, negro 6º Dan, negro 7º Dan, negro 8º Dan, negro 9º Dan, negro 10º Dan.

PRUEBAS DE ACEPTACIÓN:
1. Cinturón correcto
  - hay una lista con todos los grados
  - se intenta añadir un grado con gradoCinturon = "Amarillo"
  - se compueba que el grado está en la lista
2. Cinturón inexistente
  - hay una lista con todos los grados
  - se intenta añadir un grado con gradoCinturon = "Multicolor"
  - se compueba que el grado no está en la lista

#### R.N.01.15 Eliminar grado
Un grado no puede ser eliminado.

PRUEBAS DE ACEPTACIÓN:
- hay una lista con todos los grados
- se intenta eliminar un grado
- se comprueba que no se ha eliminado

#### R.N.01.16 Alumno en dos grupos
Un alumno no puede estar en dos grupos a la vez.

PRUEBAS DE ACEPTACIÓN:
- hay una lista con todos los alumnos
- se intenta añadir un alumno con: grupoIdEnteno = 1, grupoIdEspera = 2
- se comprueba que el alumno no está en la lista

#### R.N.01.17 Alumno en grupo disponible
Un grupo nuevo no puede aceptar más alumnos.

PRUEBAS DE ACEPTACIÓN:
- hay una lista con todos los grupos
- se añade un grupo con: limite alumnos = 0; (id=1)
- hay una lista con todos los alumnos
- se intenta añadir un alumno con: grupoIdEntreno = 1;
- se comprueba que el alumno no está en la lista

#### R.N.02.1 Registro de Pagos
El sistema debe permitir el registro de pagos que cubran múltiples alumnos a la vez, y asegurarse de que se incluya la cantidad, fecha, y método de pago.

PRUEBAS DE ACEPTACIÓN:
1. Pago individual válido
  - hay una lista con todos los pagos
  - se intenta añadir un pago con: cantidad = 100€, fecha = 10/10/2024, financiamiento = "mensual", método de transacción = "transferencia bancaria",
2. Falta de algún campo
  - hay una lista con todos los pagos
  - se intenta añadir un pago con: cantidad = NULL, fecha = 10/10/2024, financiamiento = "mensual", método de transacción = "transferencia bancaria".

#### R.N.02.2 Comunicación de Pago
El sistema debe enviar automáticamente una notificación al correo electrónico del alumno o tutor legal cuando se registre un pago.

PRUEBAS DE ACEPTACIÓN:
- hay una lista con todas las comunicaciones
- se intenta añadir un pago con: alumno = "A1", cantidad = 50€, fecha = 10/10/2024, método de transacción = "Bizum", financiamiento = "Trimestral"
- se comprueba que en la lista hay una comunicación con el alumno que confirma el pago (mensaje automático por correo).

#### R.N.02.3 Métodos de pago de los pagos
Un pago sólo puede ser del método de pago efectivo, transferencia bancaria, paypal o bizum.

PRUEBAS DE ACEPTACIÓN:
1. Categoría correcta
  - hay una lista con todos los pagos
  - se intenta añadir un pago con metodoPago = "Efectivo"
  - se compueba que el pago está en la lista
2. Categoría inexistente
  - hay una lista con todos los pagos
  - se intenta añadir un pago con metodoPago = "abcd"
  - se compueba que el pago no está en la lista

#### R.N.02.4 Financiamiento de los pagos
Un pago sólo puede ser corresponder al pago inicial, mensual o bimensual.

PRUEBAS DE ACEPTACIÓN:
1. Financiamiento correcto
  - hay una lista con todos los pagos
  - se intenta añadir un pago con financiamiento = "Mensual"
  - se compueba que el pago está en la lista
2. Financiamiento inexistente
  - hay una lista con todos los pagos
  - se intenta añadir un pago con financiamiento = "Anual"
  - se compueba que el pago no está en la lista

#### R.N.03.1 Publicación de Anuncios
El sistema debe permitir la publicación de anuncios y de anuncios programados con anterioridad.

PRUEBAS DE ACEPTACIÓN:
1. Publicación programada correcta
  - hay una lista con todos los anuncios
  - se intenta añadir un anuncio con fecha futura y sin conflictos de mantenimiento
  - se comprueba que el anuncio está en la lista con estado = sin publicar
  - se comprueba que el anuncio está en la lista con estado = publicado tras la fecha y hora establecida previamente
2. Publicación instantánea correcta
  - hay una lista con todos los anuncios
  - se intenta añadir un anuncio sin fecha ni conflictos de mantenimiento
  - se comprueba que el anuncio está en la lista con estado = publicado

#### R.N.03.2 Edición de Anuncios
El sistema debe permitir la edición de anuncios.

PRUEBAS DE ACEPTACIÓN:
1. Anuncio publicado
  - hay una lista con todos los anuncios
  - se añade un anuncio
  - se intenta editar el anuncio con estado = publicado
  - se comprueba que el anuncio está en la lista actualizado correctamente
2. Anuncio sin publicar
  - hay una lista con todos los anuncios
  - se añade un anuncio
  - se intenta editar el anuncio con estado = sin publicar
  - se comprueba que el anuncio está en la lista actualizado correctamente

#### R.N.03.3 Eliminación de Anuncios
El sistema debe permitir eliminar anuncios.

PRUEBAS DE ACEPTACIÓN:
1. Anuncio publicado
  - hay una lista con todos los anuncios
  - se añade un anuncio con estado = publicado
  - se intenta eliminar el anuncio
  - se comprueba que al anuncio no está en la lista
2. Anuncio no publicado
  - hay una lista con todos los anuncios
  - se añade un anuncio con estado = sin publicar
  - se intenta eliminar el anuncio
  - se comprueba que al anuncio no está en la lista

#### R.N.03.4 Estados de los anuncios
Un anuncio sólo puede estar publicado o sin publicar.

PRUEBAS DE ACEPTACIÓN:
1. Estado correcto
  - hay una lista con todos los anuncios
  - se intenta añadir un anuncio con estado = 'Sin publicar'
  - se compueba que el anuncio está en la lista
2. Estado inexistente
  - hay una lista con todos los anuncios
  - se intenta añadir un anuncio con estado = 'Nuevo'
  - se compueba que el anuncio está en la lista

#### R.N.04.1 Creación de Sesiones
El sistema debe generar automáticamente sesiones semanales para cada grupo basándose en el calendario de la temporada y las reglas definidas.

PRUEBAS DE ACEPTACIÓN:
- hay una lista con todas las sesiones
- se intenta añadir un calendario con: temporada = 2024-2025, grupos = [G1]
- se comprueba que en la lista están todas las sesiones del G1

#### R.N.04.2 Edición de Sesiones
El sistema debe permitir que el sensei edite manualmente las fechas, horas o lugares de las sesiones programadas, asegurando que cualquier modificación sea notificada a los usuarios involucrados.

PRUEBAS DE ACEPTACIÓN:
1. Edición manual exitosa
  - hay una lista con todas las sesiones
  - se intenta modificar la fecha o lugar de una sesión 
  - se comprueba que la sesión está en la lista con las modificaciones adecuadas
2. Edición sin algún campo
  - hay una lista con todas las sesiones
  - se intenta modificar una sesión dejando algún campo en blanco
  - se comprueba que la sesión está en la lista con las modificaciones adecuadas, dejando los campos vacíos sin modificar

#### R.N.04.3 Registro de Asistencia  
El sistema debe permitir el registro de asistencia durante cada sesión de manera manual o automática, y debe generar un reporte detallado para el sensei, mostrando el estado de asistencia de cada alumno.

PRUEBAS DE ACEPTACIÓN:
- hay una lista con todas las asistencias
- se intentan añadir las asistencias de: sesión = S1, grupo = G3, alumnos = [A3, A4, A9, A10]
- se comprueba que la asistencia de cada alumno del grupo de la sesión está en la lista

#### R.N.04.4 Eliminación de Sesiones  
El sistema debe permitir la eliminación de sesiones en caso de eventos imprevistos. Se debe registrar un historial con el motivo de la eliminación.

PRUEBAS DE ACEPTACIÓN:
- hay una lista con todas las sesiones
- se añade la sesión S1: grupo = G1, fechaHora = 2024-12-05 19:00:00, temporada = "2024/25"
- se intenta eliminar la sesión S1
- se comprueba que la sesión no está en la lista

#### R.N.04.5 Sesiones no coincidentes
No puede haber dos sesiones que coincidan en fecha y hora, y ubicación.

PRUEBAS DE ACEPTACIÓN:
- hay una lista con todas las sesiones
- se añade la sesión S1:  grupo = G1, fechaHora = 2024-09-15 21:00:00, temporada = "2024/25"
- se intenta añadir la sesión S2: grupo = G1, fechaHora = 2024-04-29 08:00:00, temporada = "2024/25"
- se comprueba que la sesión no está en la lista

---

## 5. Mapa de historias de usuario

R.G.01. Gestión alumnos
- R.F.01.1 Creación alumno
- R.F.01.2 Actualizar estado
- R.F.01.3 Validar renovación
- R.F.01.4 Prohibición eliminación
- R.F.01.5 Cláusula de Protección de Datos
- R.F.01.6 Informes individuales
- R.F.01.7 Estadísticas rendimiento
- R.F.01.8 Historial grados
- R.I.01.1 Información alumno
  - R.N.01.1 Creación alumno
  - R.N.01.2 Actualización alumno
  - R.N.01.3 Eliminación alumno
  - R.N.01.7 Código Federativo
  - R.N.01.8 Protección de datos
  - R.N.01.13 Estados de los alumnos
  - R.N.01.16 Alumno en dos grupos
  - R.N.01.17 Alumno en grupos disponibles
- R.I.01.2 Información tutor legal
  - R.N.01.1 Creación alumno
- R.I.01.3 Información grupo
  - R.N.01.4 Crear grupo
  - R.N.01.5 Actualizar grupo
  - R.N.01.6 Eliminar grupo
  - R.N.01.12 Categorías de los grupos
- R.I.01.4 Información grados
  - R.N.01.9 Creación grado
  - R.N.01.10 Actualización grado
  - R.N.01.11 Tiempo mínimo grado
  - R.N.01.14 Cinturones de los grados
  - R.N.01.15 Eliminación grado

R.G.02. Gestión pagos
- R.F.02.1 Registro pagos
- R.F.02.2 Confirmación pago
- R.F.02.3 Almacenamiento información pago
- R.F.02.4 Métodos pago
- R.I.02.1 Información de pagos
  - R.N.02.1 Registro de Pagos
  - R.N.02.2 Comunicación de Pago
  - R.N.02.3 Métodos de pago de los pagos
  - R.N.02.4 Financiamiento de los pagos

R.G.03. Gestión anuncios
- R.F.03.1 Programación anuncios
- R.F.03.2 Notificación anuncios
- R.F.03.3 Edición anuncios
- R.F.03.4 Eliminación anuncios
- R.I.03.1 Información de Anuncios
  - R.N.03.1 Publicación de Anuncios
  - R.N.03.2 Edición de Anuncios
  - R.N.03.3 Eliminación de Anuncios
  - R.N.03.4 Estados de los anuncios

R.G.04. Gestión sesiones
- R.F.04.1 Automatización sesiones
- R.F.04.2 Edición sesiones
- R.F.04.3 Registro asistencia
- R.F.04.4 Eliminación sesiones
- R.I.04.1 Información de Sesiones
  - R.N.04.1 Creación de Sesiones
  - R.N.04.2 Edición de Sesiones
  - R.N.04.4 Eliminación de Sesiones
  - R.N.04.5 Sesiones no coincidentes
- R.I.04.2 Información de Asistencia
  - R.N.04.3 Registro de Asistencia

---

## 6. Modelo conceptual

![<diagramaUML>](<img/DiagramaUML.drawio.png>)

## 7. Modelo relacional
Alumnos (!alumnoId, razonInscripcion, fechaNacimiento, codigoFederativo, dni, clausulaPDD, personaId @Personas, domicilioId @Domicilios, tutorId @TutoresLegales, grupoIdEntreno @Grupos, grupoIdEspera @Grupos)

Personas (!personaId, teléfono, correo, nombre, apellidos)

Domicilios (!domicilioId, direccion, municipio, cp)

TutoresLegales (!tutorId, correoAlternativo, parentesco, personaId @Personas)

Grados (!gradoId, gradoCinturon, fechaInicio, fechaFin,  fechaLicencia, alumnoId @Alumnos)

Asistencias (!asistenciaId, alumnoPresente, alumnoId @Alumnos, sesionId @Sesiones)

Grupos (!grupoId, nombre, limiteAlumnos, categoria, ubicacion, precioMes)

Observaciones (!observacionId, fecha, argumento, alumnoId @Alumnos, senseiId @Senseis)

Sesiones (!sesionId, fechaHora, temporada, grupoId @Grupos)

Anuncios (!anuncioId, asunto, fechaHora, descripcion, seseiId @Senseis)

Senseis (!senseiId, personaId @Personas)

InfosSanitarias (!infoSanitariaId, argumento, alumnoId @Alumnos)

Pagos (!pagoId, cantidad, fecha, metodo, financiamiento, alumnoId @Alumnos)