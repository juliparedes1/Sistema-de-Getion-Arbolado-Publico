	CREATE DATABASE TP_BBDD1_2025_G02;

	GO

	USE  TP_BBDD1_2025_G02

	CREATE TABLE CUADRILLA(
		Id_cuadrilla INT IDENTITY PRIMARY KEY ,
		Nombre VARCHAR(50) NOT NULL
	);

	CREATE TABLE EMPLEADO(
		Id_empleado INT PRIMARY KEY IDENTITY,
		Nombre_completo VARCHAR(100) NOT NULL,
		Cuil VARCHAR(15) UNIQUE NOT NULL,
		Telefono VARCHAR(20) NOT NULL,
		Fecha_ingreso DATE NOT NULL,
		Id_cuadrilla INT FOREIGN KEY REFERENCES CUADRILLA(Id_cuadrilla)
	);

	CREATE TABLE TAREA(
		Id_tarea INT PRIMARY KEY IDENTITY,
		Descripcion VARCHAR(100) NOT NULL
	);

	CREATE TABLE ESPECIE(
		Id_especie INT IDENTITY PRIMARY KEY,
		Nombre_comun VARCHAR(70),
		Nombre_cientifico VARCHAR(150) NOT NULL
	);

	CREATE TABLE PLAZA(
		Id_plaza INT PRIMARY KEY IDENTITY,
		Nombre VARCHAR(50) NOT NULL
	);

	CREATE TABLE ARBOL (
		Id_arbol VARCHAR(4) PRIMARY KEY,
		id_Especie INT FOREIGN KEY REFERENCES ESPECIE(Id_especie) NOT NULL,
		Id_plaza INT FOREIGN KEY REFERENCES PLAZA(Id_plaza),
		Longitud VARCHAR(30) NOT NULL,
		Latitud VARCHAR(30) NOT NULL,
		Fecha_plantado DATE
	);

	CREATE TABLE TAREA_CUADRILLA(
		Id_tarea_cuadrilla INT PRIMARY KEY IDENTITY,
		Id_tarea INT FOREIGN KEY REFERENCES TAREA(Id_tarea) NOT NULL,
		Id_cuadrilla INT FOREIGN KEY REFERENCES CUADRILLA(Id_cuadrilla) NOT NULL,
		Fecha_creacion DATETIME NOT NULL,
		Fecha_realizacion DATETIME,
		Comentario VARCHAR(300)
	); 

	CREATE TABLE ESTADO (
		Id_estado INT IDENTITY PRIMARY KEY,
		Descripcion VARCHAR(50) NOT NULL
	);

	CREATE TABLE REGISTRO_ARBOL (
		Id_registro INT IDENTITY PRIMARY KEY,
		Fecha_medida DATE,
		Altura FLOAT,
		Id_estado INT FOREIGN KEY REFERENCES ESTADO(Id_estado) NOT NULL,
		Id_arbol VARCHAR(4) FOREIGN KEY REFERENCES ARBOL(Id_arbol) NOT NULL
	);

	CREATE TABLE TAREA_ARBOL(
		Id_tarea_arbol INT IDENTITY PRIMARY KEY,
		Id_arbol VARCHAR(4) FOREIGN KEY REFERENCES ARBOL(Id_arbol),
		Id_tarea_cuadrilla INT FOREIGN KEY REFERENCES TAREA_CUADRILLA(Id_tarea_cuadrilla)
	);

	CREATE TABLE MOTIVO(
		Id_motivo INT PRIMARY KEY IDENTITY,
		Motivo VARCHAR(200)
	);

	CREATE TABLE RECLAMO(
		Id_reclamo INT IDENTITY PRIMARY KEY,
		Id_motivo INT NOT NULL FOREIGN KEY REFERENCES MOTIVO(Id_motivo),
		Email_reclamo VARCHAR(150) NOT NULL,
		Id_tarea_arbol INT FOREIGN KEY REFERENCES TAREA_ARBOL(Id_tarea_arbol),
		Id_Arbol VARCHAR(4) FOREIGN KEY REFERENCES ARBOL(Id_Arbol) NOT NULL,
		Fecha_reclamo DATE NOT NULL

	);
GO
USE  TP_BBDD1_2025_G02


--================================================================
--CREACION DE VISTAS
--================================================================

/*
a. Mostrar información de los reclamos. Se desea saber la fecha de cada uno,
el código del árbol asociado al reclamo, la cantidad de días que se tardó en
asignar la tarea y la cantidad de días que se tardó en resolver el mismo. Si
no tiene tarea asignada o no fue resuelto calcular los días hasta la fecha
actual
*/

GO

CREATE VIEW Vmostrar_info_reclamos AS
SELECT R.Id_Arbol, R.Fecha_reclamo,
	CASE WHEN TC.Fecha_creacion IS NULL THEN 
		DATEDIFF(DAY, R.Fecha_reclamo, GETDATE())
		ELSE DATEDIFF(DAY, R.Fecha_reclamo, TC.Fecha_creacion)
		END AS TIEMPO_EN_ASIGNAR_TAREA,

	CASE WHEN TC.Fecha_realizacion IS NULL THEN
		DATEDIFF(DAY, R.Fecha_reclamo,GETDATE())
		ELSE DATEDIFF(DAY, R.Fecha_reclamo, TC.Fecha_realizacion)
		END AS TIEMPO_EN_RESOLVER_TAREA
	FROM RECLAMO R LEFT JOIN TAREA_ARBOL TA 
	ON TA.Id_tarea_arbol = R.Id_tarea_arbol LEFT JOIN TAREA_CUADRILLA TC 
	ON TA.Id_tarea_cuadrilla = TC.Id_tarea_cuadrilla

GO


/*
b. Resumen de tareas ya realizadas según su tipo. Se desea saber la fecha de
la primer y última tarea de cada tipo y la cantidad de tareas realizadas
*/

CREATE VIEW Vresumen_tarea AS
SELECT 
    T.Descripcion AS Tipo_Tarea, 
    MIN(TC.Fecha_realizacion) AS Fecha_Primera,
    MAX(TC.Fecha_realizacion) AS Fecha_Ultima,
    COUNT(TC.Id_tarea_cuadrilla) AS Cantidad_Realizadas
FROM TAREA T
JOIN TAREA_CUADRILLA TC ON T.Id_tarea = TC.Id_tarea
WHERE TC.Fecha_realizacion IS NOT NULL 
GROUP BY T.Descripcion;

GO

--================================================================
--CREACION DE STORED PROCEDURE
--================================================================


CREATE PROCEDURE SP_siguiente_tarea_arbol
	@id_arbol VARCHAR(4),
	@tarea VARCHAR(100),
	@fecha_siguiente DATETIME OUTPUT
 AS
 BEGIN
 DECLARE @RETORNO INT
	SELECT @fecha_siguiente = MIN(TC.Fecha_creacion), @RETORNO = COUNT(TC.Id_tarea)
	FROM TAREA_CUADRILLA TC INNER JOIN TAREA_ARBOL TA
	ON TA.Id_tarea_cuadrilla = TC.Id_tarea_cuadrilla INNER JOIN TAREA T 
	ON T.Id_tarea = TC.Id_tarea
	WHERE TA.Id_arbol = @id_arbol AND T.Descripcion = @tarea AND TC.Fecha_realizacion IS NULL

	RETURN @RETORNO 
 END;
 GO