	
--INSERCION DE DATOS
	


	/*
================================================================================
 SCRIPT DE INSERCIÓN DE DATOS (SEEDING) - V2
 Base de Datos: TP_BBDD1_2025_G02
 Cumple con los requisitos del Apartado 3 del TP BBDD1 2025
 MODIFICACIÓN: La tabla ARBOL no usa 'Calle' ni 'Altura_calle'.
 La ubicación se define por 'Id_plaza' (si existe) o por coordenadas si 'Id_plaza' es NULL.
================================================================================
*/

-- Usar la base de datos correcta
USE TP_BBDD1_2025_G02;
GO

/*
================================================================================
 APARTADO 3.a: 3 Cuadrillas y 10 Empleados
================================================================================
*/

PRINT 'Insertando Cuadrillas y Empleados...';

-- 3 Cuadrillas
INSERT INTO CUADRILLA (Nombre)
VALUES
('Cuadrilla Alfa (Poda)'),
('Cuadrilla Beta (Mantenimiento)'),
('Cuadrilla Gamma (Nuevas Plantaciones)');
GO

-- 10 Empleados
INSERT INTO EMPLEADO (Nombre_completo, Cuil, Telefono, Fecha_ingreso, Id_cuadrilla)
VALUES
('Juan Perez', '20-30111222-5', '3415123456', '2020-05-10', 1),
('Maria Garcia', '27-32222333-4', '3415765432', '2020-05-10', 1),
('Carlos Lopez', '20-31333444-3', '3415987654', '2021-02-15', 1),
('Ana Martinez', '27-33444555-2', '3416123321', '2021-03-20', 2),
('Luis Fernandez', '20-34555666-1', '3416456789', '2022-01-30', 2),
('Laura Rodriguez', '27-35666777-0', '3416654321', '2022-01-30', 2),
('Miguel Sanchez', '20-36777888-9', '3416987789', '2023-06-05', 3),
('Sofia Torres', '27-37888999-8', '3413123456', '2023-06-05', 3),
('Diego Gomez', '20-38999000-7', '3413321123', '2024-01-10', 3),
('Elena Diaz', '27-39000111-6', '3413567890', '2024-01-10', 3);
GO

/*
================================================================================
 TABLAS MAESTRAS (Especies, Ubicaciones, Tipos de Tarea, Estados)
================================================================================
*/

PRINT 'Insertando Tablas Maestras...';

-- 5 Especies
INSERT INTO ESPECIE (Nombre_comun, Nombre_cientifico)
VALUES
('Jacarandá', 'Jacaranda mimosifolia'),
('Lapacho Rosado', 'Handroanthus impetiginosus'),
('Ceibo', 'Erythrina crista-galli'),
('Tilo', 'Tilia platyphyllos'),
('Fresno Americano', 'Fraxinus pennsylvanica');
GO

-- 10 Ubicaciones (5 Plazas + 5 ubicaciones genéricas con Id_plaza NULL)
INSERT INTO PLAZA (Nombre)
VALUES
('Plaza Pringles'),
('Plaza San Martín'),
('Plaza 25 de Mayo'),
('Parque Urquiza'),
('Parque Independencia');
GO

-- Tipos de Tarea
INSERT INTO TAREA (Descripcion)
VALUES
('Plantado'),
('Poda de formación'),
('Poda de levante'),
('Remoción de ejemplar'),
('Control de plaga'),
('Riego');
GO

-- Estados de Salud
INSERT INTO ESTADO (Descripcion)
VALUES
('Sano'),
('Débil'),
('Seco'),
('Enfermo'),
('Caído');
GO

/*
================================================================================
 APARTADO 3.b: 50 Árboles
================================================================================
*/

PRINT 'Insertando 50 Árboles (Modelo: Id_plaza o NULL+Coords)...';

-- 50 Árboles
-- (25 en Plazas, 25 en ubicaciones genéricas (Id_plaza = NULL))
-- (Con y sin fecha de plantado)
INSERT INTO ARBOL (Id_arbol, id_Especie, Id_plaza, Longitud, Latitud, Fecha_plantado)
VALUES
-- 5 en Plaza 1 (Pringles)
('A001', 1, 1, '-60.6358', '-32.9475', '2015-08-20'),
('A002', 2, 1, '-60.6357', '-32.9474', '2015-08-20'),
('A003', 3, 1, '-60.6356', '-32.9473', NULL), -- Sin fecha
('A004', 4, 1, '-60.6355', '-32.9472', '2016-09-10'),
('A005', 5, 1, '-60.6354', '-32.9471', NULL), -- Sin fecha
-- 5 en Plaza 2 (San Martín)
('A006', 1, 2, '-60.6418', '-32.9490', '2012-07-15'),
('A007', 2, 2, '-60.6417', '-32.9489', '2012-07-15'),
('A008', 3, 2, '-60.6416', '-32.9488', '2013-03-01'),
('A009', 4, 2, '-60.6415', '-32.9487', NULL), -- Sin fecha
('A010', 5, 2, '-60.6414', '-32.9486', '2013-03-01'),
-- 5 en Plaza 3 (25 de Mayo)
('A011', 1, 3, '-60.6320', '-32.9460', '2010-01-01'),
('A012', 2, 3, '-60.6319', '-32.9459', '2010-01-01'),
('A013', 3, 3, '-60.6318', '-32.9458', NULL), -- Sin fecha
('A014', 4, 3, '-60.6317', '-32.9457', '2011-05-25'),
('A015', 5, 3, '-60.6316', '-32.9456', '2011-05-25'),
-- 5 en Plaza 4 (Parque Urquiza)
('A016', 1, 4, '-60.6280', '-32.9510', '2018-11-11'),
('A017', 2, 4, '-60.6279', '-32.9509', NULL), -- Sin fecha
('A018', 3, 4, '-60.6278', '-32.9508', '2018-11-11'),
('A019', 4, 4, '-60.6277', '-32.9507', '2019-02-01'),
('A020', 5, 4, '-60.6276', '-32.9506', NULL), -- Sin fecha
-- 5 en Plaza 5 (Parque Independencia)
('A021', 1, 5, '-60.6500', '-32.9600', '2005-01-01'),
('A022', 2, 5, '-60.6499', '-32.9599', '2005-01-01'),
('A023', 3, 5, '-60.6498', '-32.9598', '2006-03-10'),
('A024', 4, 5, '-60.6497', '-32.9597', NULL), -- Sin fecha
('A025', 5, 5, '-60.6496', '-32.9596', '2006-03-10'),
-- 5 en Ubicación Genérica 1 (Ej. Av. Pellegrini) -> Id_plaza = NULL
('A026', 1, NULL, '-60.6430', '-32.9550', '2014-06-01'),
('A027', 2, NULL, '-60.6431', '-32.9551', '2014-06-01'),
('A028', 3, NULL, '-60.6432', '-32.9552', NULL), -- Sin fecha
('A029', 4, NULL, '-60.6433', '-32.9553', '2014-06-01'),
('A030', 5, NULL, '-60.6434', '-32.9554', '2014-06-01'),
-- 5 en Ubicación Genérica 2 (Ej. Bv. Oroño) -> Id_plaza = NULL
('A031', 1, NULL, '-60.6450', '-32.9520', '2008-01-01'),
('A032', 2, NULL, '-60.6451', '-32.9521', NULL), -- Sin fecha
('A033', 3, NULL, '-60.6452', '-32.9522', '2008-01-01'),
('A034', 4, NULL, '-60.6453', '-32.9523', '2008-01-01'),
('A035', 5, NULL, '-60.6454', '-32.9524', '2008-01-01'),
-- 5 en Ubicación Genérica 3 (Ej. Calle Mendoza) -> Id_plaza = NULL
('A036', 1, NULL, '-60.6400', '-32.9500', '2017-09-15'),
('A037', 2, NULL, '-60.6401', '-32.9501', '2017-09-15'),
('A038', 3, NULL, '-60.6402', '-32.9502', NULL), -- Sin fecha
('A039', 4, NULL, '-60.6403', '-32.9503', '2017-09-15'),
('A040', 5, NULL, '-60.6404', '-32.9504', '2017-09-15'),
-- 5 en Ubicación Genérica 4 (Ej. Calle Corrientes) -> Id_plaza = NULL
('A041', 1, NULL, '-60.6380', '-32.9490', '2019-10-01'),
('A042', 2, NULL, '-60.6381', '-32.9491', '2019-10-01'),
('A043', 3, NULL, '-60.6382', '-32.9492', '2019-10-01'),
('A044', 4, NULL, '-60.6383', '-32.9493', NULL), -- Sin fecha
('A045', 5, NULL, '-60.6384', '-32.9494', '2019-10-01'),
-- 5 en Ubicación Genérica 5 (Ej. Calle Entre Ríos) -> Id_plaza = NULL
('A046', 1, NULL, '-60.6400', '-32.9480', '2020-03-01'),
('A047', 2, NULL, '-60.6401', '-32.9481', NULL), -- Sin fecha
('A048', 3, NULL, '-60.6402', '-32.9482', '2020-03-01'),
('A049', 4, NULL, '-60.6403', '-32.9483', '2020-03-01'),
('A050', 5, NULL, '-60.6404', '-32.9484', '2020-03-01');
GO

PRINT 'Insertando Registros de Árboles (Salud y Altura)...';

-- Registros de Salud y Altura para los 50 árboles
-- (Con y sin altura registrada)
-- (Distintos estados de salud)
-- (Datos para Req 4.d: Top 3 más altos por especie)
INSERT INTO REGISTRO_ARBOL (Fecha_medida, Altura, Id_estado, Id_arbol)
VALUES
('2025-10-01', 8.5, 1, 'A001'),
('2025-10-01', 7.2, 1, 'A002'),
('2025-10-01', NULL, 2, 'A003'), -- Sin altura
('2025-10-01', 10.1, 1, 'A004'),
('2025-10-01', 9.0, 3, 'A005'),
('2025-10-02', 12.5, 1, 'A006'), -- Especie 1 (alto)
('2025-10-02', 11.8, 1, 'A007'), -- Especie 2 (alto)
('2025-10-02', 6.5, 1, 'A008'),
('2025-10-02', NULL, 1, 'A009'), -- Sin altura
('2025-10-02', 10.5, 4, 'A010'), -- Enfermo
('2025-10-03', 13.1, 1, 'A011'), -- Especie 1 (más alto)
('2025-10-03', 12.0, 1, 'A012'), -- Especie 2 (más alto)
('2025-10-03', 7.0, 1, 'A013'),
('2025-10-03', 9.8, 1, 'A014'),
('2025-10-03', 9.5, 1, 'A015'),
('2025-10-04', 5.5, 1, 'A016'),
('2025-10-04', NULL, 2, 'A017'), -- Sin altura
('2025-10-04', 8.1, 1, 'A018'), -- Especie 3 (alto)
('2025-10-04', 7.3, 1, 'A019'),
('2025-10-04', 6.8, 1, 'A020'),
('2025-10-05', 11.5, 1, 'A021'), -- Especie 1 (3er alto)
('2025-10-05', 10.5, 1, 'A022'), -- Especie 2 (3er alto)
('2025-10-05', 7.9, 1, 'A023'),
('2025-10-05', 11.2, 1, 'A024'), -- Especie 4 (alto)
('2025-10-05', 11.0, 1, 'A025'), -- Especie 5 (alto)
('2025-10-06', 9.2, 1, 'A026'),
('2025-10-06', 8.8, 1, 'A027'),
('2025-10-06', NULL, 1, 'A028'), -- Sin altura
('2025-10-06', 10.8, 1, 'A029'), -- Especie 4 (2do alto)
('2025-10-06', 10.2, 1, 'A030'), -- Especie 5 (2do alto)
('2025-10-07', 10.0, 1, 'A031'),
('2025-10-07', 9.5, 1, 'A032'),
('2025-10-07', 8.0, 1, 'A033'), -- Especie 3 (2do alto)
('2025-10-07', 10.5, 1, 'A034'), -- Especie 4 (3er alto)
('2025-10-07', 10.1, 1, 'A035'), -- Especie 5 (3er alto)
('2025-10-08', 6.0, 1, 'A036'),
('2025-10-08', 5.8, 1, 'A037'),
('2025-10-08', 7.5, 1, 'A038'), -- Especie 3 (3er alto)
('2025-10-08', NULL, 2, 'A039'), -- Sin altura
('2025-10-08', 6.5, 1, 'A040'),
('2025-10-09', 4.0, 1, 'A041'),
('2025-10-09', 3.8, 1, 'A042'),
('2025-10-09', 4.1, 1, 'A043'),
('2025-10-09', 4.2, 1, 'A044'),
('2025-10-09', NULL, 1, 'A045'), -- Sin altura
('2025-10-10', 3.0, 1, 'A046'),
('2025-10-10', 2.8, 1, 'A047'),
('2025-10-10', 3.1, 1, 'A048'),
('2025-10-10', 3.3, 1, 'A049'),
('2025-10-10', 3.5, 5, 'A050'); -- Caído
GO

/*
================================================================================
 APARTADO 3.c: 20 Tareas
================================================================================
*/

PRINT 'Insertando 20 Tareas...';

-- 20 Tareas asignadas a cuadrillas
-- (Distribuidas en 3+ meses: Oct, Nov, Dic 2025)
-- (Con y sin Fecha_realizacion)
-- (Datos para Req 4.a: Cuadrilla 1 tendrá más tareas en Octubre)
INSERT INTO TAREA_CUADRILLA (Id_tarea, Id_cuadrilla, Fecha_creacion, Fecha_realizacion, Comentario)
VALUES
(2, 1, '2024-11-23 08:00', '2025-02-02 15:00', 'Poda de formación completada.'), -- Tarea 1 (Oct)
(3, 1, '2024-11-21 09:00', '2025-02-03 16:00', 'Poda de levante en plaza.'), -- Tarea 2 (Oct)
(4, 2, '2024-11-23 08:00', '2025-02-06 12:00', 'Remoción de ejemplar seco.'), -- Tarea 3 (Oct)
(5, 2, '2024-11-25 10:00', '2025-02-08 17:00', 'Control de plaga (pulgón).'), -- Tarea 4 (Oct)
(1, 3, '2024-12-02 08:00', '2025-02-10 14:00', 'Plantado de nuevos ejemplares.'), -- Tarea 5 (Oct)
(2, 1, '2024-11-27 09:00', '2025-02-13 15:00', 'Poda correctiva.'), -- Tarea 6 (Oct)
(3, 1, '2024-12-03 08:00', '2025-02-16 16:00', 'Poda de despeje luminarias.'), -- Tarea 7 (Oct)
(6, 2, '2024-12-12 07:00', '2025-02-20 11:00', 'Riego en canteros.'), -- Tarea 8 (Oct)
(4, 1, '2024-12-13 09:00', '2025-02-26 13:00', 'Remoción de árbol caído por tormenta.'), -- Tarea 9 (Oct) (Ligado a Reclamo)
(2, 1, '2024-12-20 08:00', '2025-03-02 15:00', 'Poda en Bv. Oroño.'), -- Tarea 10 (Nov)
(5, 2, '2025-01-20 09:00', '2025-03-04 17:00', 'Seguimiento control de plaga.'), -- Tarea 11 (Nov)
(1, 3, '2024-12-18 08:00', '2025-03-05 14:00', 'Reposición de marras.'), -- Tarea 12 (Nov)
(4, 1, '2025-01-10 09:00', NULL, 'Remoción de raíz peligrosa.'), -- Tarea 13 (Nov) (Ligado a Reclamo)
(2, 1, '2025-01-15 08:00', '2025-03-16 16:00', 'Poda.'), -- Tarea 14 (Nov)
(3, 2, '2025-01-20 09:00', '2025-03-21 15:00', 'Poda de levante.'), -- Tarea 15 (Nov)
(6, 3, '2025-02-01 07:00', '2025-04-01 11:00', 'Riego de plantaciones nuevas.'), -- Tarea 16 (Dic)
(2, 1, '2025-02-03 08:00', '2025-04-04 15:00', 'Poda correctiva.'), -- Tarea 17 (Dic)
(4, 2, '2025-02-05 09:00', NULL, 'Pendiente de remoción.'), -- Tarea 18 (Dic) (PENDIENTE)
(5, 1, '2025-02-10 08:00', NULL, 'Pendiente de control.'), -- Tarea 19 (Dic) (PENDIENTE)
(1, 3, '2025-02-15 09:00', NULL, 'Pendiente de plantación.'); -- Tarea 20 (Dic) (PENDIENTE)
GO



PRINT 'Asignando Árboles a Tareas...';

-- Asignación de Tareas a Árboles (Relación M:N)
-- (Tareas asociadas a uno o más árboles)
INSERT INTO TAREA_ARBOL (Id_arbol, Id_tarea_cuadrilla)
VALUES
('A001', 1), -- Tarea 1 -> 1 árbol
('A002', 1), -- Tarea 1 -> 2 árboles
('A003', 1), -- Tarea 1 -> 3 árboles (Múltiples árboles)
('A006', 2), -- Tarea 2 -> 1 árbol
('A005', 3), -- Tarea 3 -> 1 árbol
('A010', 4), -- Tarea 4 -> 1 árbol
('A046', 5), -- Tarea 5 -> 1 árbol
('A047', 5), -- Tarea 5 -> 2 árboles
('A048', 5), -- Tarea 5 -> 3 árboles
('A009', 6), -- Tarea 6 -> 1 árbol
('A014', 7), -- Tarea 7 -> 1 árbol
('A015', 7), -- Tarea 7 -> 2 árboles
('A021', 8), -- Tarea 8 -> 1 árbol
('A050', 9), -- Tarea 9 -> 1 árbol (Árbol caído)
('A031', 10), -- Tarea 10 -> 1 árbol
('A032', 10), -- Tarea 10 -> 2 árboles
('A010', 11), -- Tarea 11 -> 1 árbol (Misma árbol que T4)
('A003', 12), -- Tarea 12 -> 1 árbol (Mismo árbol que T1)
('A026', 13), -- Tarea 13 -> 1 árbol
('A033', 14), -- Tarea 14 -> 1 árbol
('A034', 14), -- Tarea 14 -> 2 árboles
('A035', 14), -- Tarea 14 -> 3 árboles
('A022', 15), -- Tarea 15 -> 1 árbol
('A023', 15), -- Tarea 15 -> 2 árboles
('A049', 16), -- Tarea 16 -> 1 árbol
('A050', 16), -- Tarea 16 -> 2 árboles
('A018', 17), -- Tarea 17 -> 1 árbol
('A005', 18), -- Tarea 18 (Pendiente) -> 1 árbol
('A010', 19), -- Tarea 19 (Pendiente) -> 1 árbol
('A020', 20), -- Tarea 20 (Pendiente) -> 1 árbol
('A024', 20), -- Tarea 20 (Pendiente) -> 2 árboles
('A028', 20); -- Tarea 20 (Pendiente) -> 3 árboles
GO

/*
================================================================================
 APARTADO 3.d: 20 Reclamos
================================================================================
*/

PRINT 'Insertando 20 Reclamos...';

-- 20 Reclamos
-- (Distribuidos en 3+ meses: Sep, Oct, Nov 2025)
-- (Distintas situaciones: no asignados, asignados, resueltos)
-- (Tareas asociadas a cero, uno o varios reclamos)
-- (Datos para Req 4.b: Motivo "Árbol caído" tendrá > 3 no asignados)

INSERT INTO MOTIVO VALUES ('Se requieren arboles nuevos'),
('se requiere poda'),
('Recolectar hojas'),
('Arbol caido'),
('arbol cortando calle'),
('ramas caidas'),
('arbol seco'),
('raices destruyen vereda'),
('raices destruyen calle')


INSERT INTO RECLAMO (Id_motivo, Email_reclamo, Id_Arbol, Fecha_reclamo, Id_tarea_arbol)
VALUES
-- Reclamos ASIGNADOS Y RESUELTOS (10)
(1, 'vecino1@gmail.com', 'A006', '2024-10-02', 2), -- Ligado a Tarea 2
(2, 'vecino2@hotmail.com', 'A005', '2024-10-04', 3), -- Ligado a Tarea 3
(3, 'vecino3@gmail.com', 'A010', '2024-10-06', 4), -- Ligado a Tarea 4
(4, 'vecino_urgente@gmail.com', 'A050', '2024-10-25', 9), -- Ligado a Tarea 9
(5, 'otro_vecino@gmail.com', 'A050', '2024-10-25', 9), -- Varios reclamos, misma tarea
(6, 'abuela_tropezon@hotmail.com', 'A026', '2024-11-08', 13), -- Ligado a Tarea 13
(7, 'conductor@gmail.com', 'A031', '2024-10-30', 10), -- Ligado a Tarea 10
(8, 'vecino_oscuras@gmail.com', 'A032', '2024-10-30', 10), -- Varios reclamos, misma tarea
(9, 'vecino3@gmail.com', 'A010', '2024-11-01', 11), -- Ligado a Tarea 11 (Mismo árbol, otro reclamo)
(9, 'corredor@gmail.com', 'A022', '2024-11-19', 15), -- Ligado a Tarea 15

-- Reclamos ASIGNADOS PERO PENDIENTES (5)
(1, 'vecino_asustado@gmail.com', 'A005', '2024-12-04', 18), -- Ligado a Tarea 18 (Pendiente)
(2, 'vecino3_insiste@gmail.com', 'A010', '2024-12-09', 19), -- Ligado a Tarea 19 (Pendiente)
(3, 'vecino_preocupado@hotmail.com', 'A005', '2024-12-04', 18), -- Varios reclamos, misma tarea
(4, 'vecina_verde@gmail.com', 'A020', '2024-12-14', 20), -- Ligado a Tarea 20 (Pendiente)
(4, 'otro_vecino_verde@gmail.com', 'A024', '2024-12-14', 20), -- Ligado a Tarea 20 (Pendiente)

-- Reclamos NO ASIGNADOS (5) (Id_tarea_cuadrilla = NULL)
(3, 'urgente@hotmail.com', 'A040', '2024-09-15', NULL), -- Dato para Req 4.b
(2, 'vecino_reporta@gmail.com', 'A041', '2024-10-20', NULL), -- Dato para Req 4.b
(2, 'emergencia@gmail.com', 'A042', '2024-11-05', NULL), -- Dato para Req 4.b
(4, 'gracias@hotmail.com', 'A043', '2024-11-28', NULL), -- Dato para Req 4.b
(4, 'peligro@gmail.com', 'A017', '2024-12-01', NULL),
(2, 'peligrote@gmail.com', 'A018', '2021-11-01', NULL),
(4, 'peligrito@gmail.com', 'A021', '2020-04-01', NULL),
(2, 'pepito_peligroso@gmail.com', 'A029', '2022-04-01', NULL);


GO


PRINT '================================================';
PRINT ' SCRIPT DE INSERCIÓN COMPLETADO CORRECTAMENTE.';
PRINT '================================================';








