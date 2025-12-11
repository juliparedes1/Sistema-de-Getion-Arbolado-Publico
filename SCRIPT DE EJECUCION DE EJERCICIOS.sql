
--Mostrar la cuadrilla que más tareas realizó en el mes de FEBRERO ***NO TENEMOS TAREAS REALIZADAS EN OCTUBRE de 2025***, y
--la cantidad de tareas realizadas.

SELECT TOP 1 Id_cuadrilla,COUNT(T.Id_tarea) 'CANTIDAD_TAREAS' 
FROM TAREA_CUADRILLA TC INNER JOIN TAREA T ON TC.Id_tarea = T.Id_tarea 
WHERE MONTH(Fecha_realizacion) = 2
GROUP BY TC.Id_cuadrilla


--Mostrar los Motivos de Reclamos que tengan más de 3 reclamos en estado
--no asignado (sin tarea).


SELECT Id_motivo, Motivo 
FROM MOTIVO
WHERE Id_motivo 
	IN (SELECT M.Id_motivo
	FROM RECLAMO R 
	INNER JOIN MOTIVO M ON M.Id_motivo = R.Id_motivo
	WHERE Id_tarea_arbol IS NULL 
	GROUP BY M.Id_motivo 
	HAVING COUNT(*) >= 3)


--Mostrar los Árboles (código, especie y ubicación) que no tengan ningún reclamo.

SELECT A.Id_arbol, E.Nombre_cientifico, P.Nombre, A.Latitud, A.Longitud   
FROM ARBOL A INNER JOIN ESPECIE E 
ON A.id_Especie = E.Id_especie 
LEFT JOIN PLAZA P ON P.Id_plaza = A.Id_plaza 
WHERE Id_arbol 
	NOT IN (SELECT Id_arbol FROM RECLAMO) 

--Mostrar los tres árboles (código y altura) más altos de cada especie. Mostrar
--los resultados ordenados por especie y luego altura decreciente.

GO

WITH  CTE_Alturas_maximas AS (
	SELECT E.Nombre_cientifico AS Nombre_cientifico , RA.Id_arbol AS Id_arbol, MAX(RA.Altura) AS ALTURA_MAX
	FROM REGISTRO_ARBOL RA INNER JOIN  ARBOL A 
	ON RA.Id_arbol = A.Id_arbol INNER JOIN ESPECIE E 
	ON A.id_Especie = E.Id_especie 
	WHERE RA.Altura IS NOT NULL 
	GROUP BY RA.Id_arbol, E.Nombre_cientifico
),
CTE_Ranking_alturas AS (
	SELECT Nombre_cientifico, Id_arbol, ALTURA_MAX, ROW_NUMBER() 
	OVER (PARTITION BY Nombre_cientifico ORDER BY ALTURA_MAX DESC) AS RANKING  
	FROM CTE_Alturas_maximas 
)
SELECT Nombre_cientifico, Id_arbol, ALTURA_MAX, RANKING 
FROM CTE_Ranking_alturas 
WHERE RANKING <= 3 
ORDER BY Nombre_cientifico, RANKING ASC




--====================
--EJECUCION DE VISTAS
--====================

SELECT * FROM Vmostrar_info_reclamos

SELECT * FROM Vresumen_tarea


--==================================
--PRUEBAS DEL FUNCIONAMIENTO DEL SP
--==================================

DECLARE @fecha DATETIME;
DECLARE @retorno INT;
EXEC @retorno = SP_siguiente_tarea_arbol 'A024', 'Plantado', @fecha OUTPUT

SELECT @fecha as ultima_fecha, @retorno as Retorno

EXEC @retorno = SP_siguiente_tarea_arbol 'A010', 'Control de plaga', @fecha OUTPUT

SELECT @fecha as ultima_fecha, @retorno as Retorno


EXEC @retorno = SP_siguiente_tarea_arbol 'A029', 'Plantado', @fecha OUTPUT

SELECT @fecha as ultima_fecha, @retorno as Retorno

EXEC @retorno = SP_siguiente_tarea_arbol 'A002', 'Poda de formación', @fecha OUTPUT

SELECT @fecha as ultima_fecha, @retorno as Retorno
