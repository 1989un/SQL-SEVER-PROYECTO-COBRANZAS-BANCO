![HR Analytics](/picture/banner.png)
##
# Proyecto SQL: Análisis Integral de Cobranzas en Evaluación de Morosidad y Eficiencia Operativa

<h2>Resumen (Overview)</h2>
El área de cobranzas de la empresa busca mejorar la recuperación de deuda, optimizar la gestión de contactos y reducir los niveles de morosidad. Sin embargo, actualmente no cuenta con una visión clara del comportamiento de pago de los clientes ni de la efectividad de sus estrategias de cobranza.

El objetivo de este proyecto es analizar la información disponible mediante herramientas como SQL Server Management Studio, con el fin de identificar patrones de morosidad, evaluar la eficiencia de las gestiones de cobranza y proponer recomendaciones que permitan mejorar la toma de decisiones y maximizar la recuperación de deuda.


## Estructura del Proyecto

<ul>
<li><a href="#sobre-los-datos">Sobre los Datos</a></li>
<li><a  href="#Tareas">Tareas</a></li>
<li><a  href="#limpieza-de-datos">Limpieza de Datos</a></li>
<li><a  href="#análisis-exploratorio-de-datos-e-insights">Análisis Exploratorio de Datos e Insights.</a></li>
</ul>

## Sobre los Datos

Los datos originales, junto con la descripción de cada variable, se encuentran disponibles en la fuente correspondiente: [aquí](https://www.kaggle.com/datasets/erickcaychoponce/dataset-contacto-de-cobranza/data)

El conjunto de datos utilizado para este análisis contiene información relacionada con la gestión de cobranzas, incluyendo detalles de deuda, comportamiento de pago, historial de contacto y promesas de pago de los clientes. En total, se cuenta con más de 8,000 registros y múltiples variables , exactamente 16 columnas que permiten analizar la morosidad, la efectividad de las gestiones y el riesgo de incumplimiento.


![HR Analytics](./picture/muestra_tabla_cobranzas.png)

## Tareas (Task)

En este análisis, apoyo al departamento de Cobranzas a responder lo siguiente:

1. **Antigüedad:** ¿Cuál es el promedio de antigüedad de los empleados en cada departamento?

## Limpieza de Datos

Antes de realizar el análisis, es fundamental asegurar que los datos estén limpios y listos.

#### Valores Nulos o Faltantes

Se realizó una validación de valores nulos en el campo clave CLIENTE, dado su impacto en la integridad del análisis. Tras la revisión, no se detectaron registros con valores faltantes.

```sql
-- Verificar valores faltantes en la tabla CLIENTE --

SELECT CLIENTE AS MISSINGVALUES
FROM TB_COBRANZAS
WHERE CLIENTE IS NULL

```


Posteriormente, se llevó a cabo un análisis para detectar registros duplicados considerando los campos clave del dataset. Esta validación es fundamental para asegurar la calidad de los datos. Tras la revisión, no se encontraron duplicados.

```sql
-- Verificar valores duplicados en la tabla CLIENTE --

SELECT *
FROM
(
SELECT CLIENTE,
      COUNT(1)  OVER (PARTITION BY CLIENTE) AS CUENTA
FROM TB_COBRANZAS
) T
WHERE CUENTA > 1

```

## Análisis Exploratorio de Datos (EDA) e Insights

### Pregunta #1: ¿Cuál es el nivel de morosidad de la cartera y cómo se distribuye entre los clientes?

Para analizar el nivel de morosidad de la cartera, se utilizó una consulta que agrupa a los clientes según su estado de mora (mora) y calcula tanto la cantidad de registros como su porcentaje respecto al total. Para ello, se emplearon las funciones COUNT, GROUP BY y una función de ventana OVER() para obtener el total general.

El resultado del porcentaje fue limitado  a dos decimales para mejorar la claridad y legibilidad de la información. Asimismo, se añadió el símbolo de porcentaje (%) para facilitar su interpretación por parte del usuario final.

```sql
-- Nivel de morosidad de la cartera y distribución entre los clientes --


SELECT mora, 
	 COUNT(*) AS cantidad,
	 CONCAT(CAST(100.0 * COUNT(*) / SUM(COUNT(*)) OVER() AS DECIMAL(10,2)),'%') as porcentaje
FROM TB_COBRANZAS
GROUP BY mora;	
```

![image](./picture/P1.png)


Los resultados muestran que el 76.14% de los clientes se encuentran en situación de mora, mientras que el 23.86% se mantiene al día en sus pagos. Esto indica una alta concentración de clientes morosos dentro de la cartera, lo que representa un riesgo significativo para la recuperación de deuda.