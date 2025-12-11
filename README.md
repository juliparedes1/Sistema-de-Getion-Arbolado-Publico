# Sistema-Arbolado-Publico
Trabajo Final Bases de datos 1 
# 🌳 Sistema de Gestión de Arbolado Público 

![SQL Server](https://img.shields.io/badge/Database-SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)
![Data Modeling](https://img.shields.io/badge/Focus-Data_Modeling_%26_Analytics-blue?style=for-the-badge)

## 📋 Descripción del Proyecto

[cite_start]Este proyecto simula un sistema integral de **gestión de recursos urbanos** diseñado para la Dirección General de Parques y Paseos de la ciudad de Rosario[cite: 3].

El objetivo principal es resolver la complejidad logística del mantenimiento del arbolado público mediante una arquitectura de base de datos relacional robusta. El sistema permite administrar el ciclo de vida completo de los activos y servicios:
1.  [cite_start]**Gestión de Inventario:** Censo de especies, ubicación (coordenadas/plazas) y estado de salud[cite: 12, 13].
2.  [cite_start]**Operativa de Cuadrillas:** Asignación de tareas (poda, plantado, extracción) y auditoría de productividad[cite: 7, 10].
3.  [cite_start]**Atención Ciudadana:** Trazabilidad de reclamos vecinales y medición de tiempos de respuesta[cite: 14, 17].

## 🛠️ Stack Tecnológico y Conceptos Aplicados

[cite_start]El proyecto fue desarrollado íntegramente en **SQL Server (T-SQL)** implementando un modelo normalizado en **3FN**[cite: 24]. Se destacan las siguientes técnicas avanzadas:

* [cite_start]**Window Functions & CTEs:** Uso de `ROW_NUMBER()` y `PARTITION BY` dentro de *Common Table Expressions* para generar rankings complejos de árboles por altura y especie, optimizando el rendimiento de consultas analíticas[cite: 42].
* [cite_start]**Stored Procedures (SP):** Desarrollo de procedimientos con parámetros de salida (`OUTPUT`) para automatizar la lógica de negocio, como la predicción de próximas tareas de mantenimiento basadas en el historial[cite: 49, 51].
* [cite_start]**Vistas (Views) para KPIs:** Creación de vistas estratégicas que calculan métricas de *Lead Time* (Días entre Reclamo y Resolución) utilizando funciones de fecha (`DATEDIFF`) y lógica condicional[cite: 45].
* [cite_start]**Integridad Referencial:** Diseño de esquema relacional complejo manejando relaciones N:M entre Tareas, Árboles y Reclamos[cite: 35].

## 📂 Estructura del Repositorio

El código está dividido en tres scripts principales para garantizar la modularidad y reproducibilidad:

| Archivo | Descripción |
| :--- | :--- |
| `SCRIPT CREACION DB, VIEWS Y SP.sql` | [cite_start]**DDL:** Define la estructura de la base de datos, tablas, claves foráneas, Vistas y Stored Procedures[cite: 25]. |
| `INSERCION DE DATOS.sql` | [cite_start]**DML / Seed:** Script de población de datos masiva (50 árboles, 20 tareas, 20 reclamos, empleados) para pruebas de estrés y validación lógica[cite: 26]. |
| `SCRIPT DE EJECUCION DE EJERCICIOS.sql` | [cite_start]**Analysis:** Contiene las consultas de negocio (Queries), ejecución de Vistas y pruebas unitarias de los Stored Procedures[cite: 38]. |

## 🚀 Instalación y Uso

1.  **Clonar el repositorio:**
    ```bash
    git clone [https://github.com/juliparedes1/Sistema-de-Getion-Arbolado-Publico.git](https://github.com/juliparedes1/Sistema-de-Getion-Arbolado-Publico.git)
    ```
2.  **Crear la Base de Datos:**
    Ejecutar el archivo `SCRIPT CREACION DB, VIEWS Y SP.sql` en SQL Server Management Studio (SSMS). Esto generará la DB `TP_BBDD1_2025_G02` y todos los objetos necesarios.
3.  **Poblar los Datos:**
    Ejecutar `INSERCION DE DATOS.sql`. Este script insertará datos de prueba realistas (fechas, coordenadas, descripciones).
4.  **Ejecutar Análisis:**
    Abrir `SCRIPT DE EJECUCION DE EJERCICIOS.sql` para correr las consultas de análisis y probar los procedimientos almacenados.

## 📊 Casos de Uso y Análisis (Ejemplos)

El sistema responde a preguntas críticas de negocio definidas en los requerimientos:

### 1. Auditoría de Reclamos "Huérfanos"
[cite_start]Identificación de motivos de queja que, a pesar de tener múltiples reportes, no han sido asignados a ninguna cuadrilla (Estado: No Asignado)[cite: 40].

### 2. Ranking de Especies (Analytics)
[cite_start]Mediante el uso de CTEs, se identifican los **Top 3 ejemplares más altos** de cada especie biológica registrada, ordenados para priorizar acciones de poda de altura[cite: 42].

```sql
-- Snippet del uso de CTE y Window Function aplicado en el proyecto
WITH CTE_Ranking_alturas AS (
    SELECT Nombre_cientifico, Id_arbol, ALTURA_MAX, ROW_NUMBER() 
    OVER (PARTITION BY Nombre_cientifico ORDER BY ALTURA_MAX DESC) AS RANKING  
    FROM CTE_Alturas_maximas 
)
SELECT * FROM CTE_Ranking_alturas WHERE RANKING <= 3

Proyecto basado en escenarios reales de gestión pública para la materia Bases de Datos I.