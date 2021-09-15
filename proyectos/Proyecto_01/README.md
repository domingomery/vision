# Proeycto 01: Medidor 3D

## Enunciado
El objetivo de este proyecto es realizar un medidor 3D de objetos puestos en una "caja" a partir de múltiples vistas calibradas. Con este fin se deben tomar un conjunto de al menos tres fotos de una "caja" de dimensiones conocidas que contenga objetos. Como ejemplo se muestran dos de estas fotos, en las que se pretende medir la altura de los objetos presentes. En estas fotos, la "caja" queda definida como la estructura amarilla de dimensiones conocidas.

<img src="https://github.com/domingomery/vision/blob/master/proyectos/Proyecto_01/cajas_dimension.png" width="600">

La metodología del proyecto se muestra con detalles en esta [presentación](https://github.com/domingomery/vision/blob/master/proyectos/Proyecto_01/Proyecto_01.pptx). A continuación se resumen los pasos a seguir.



## Paso 1: Adquisición de imágenes

Tomar n fotos (n > 2) que contengan objetos dentro de una caja 3D de dimensiones conocidas.


## Paso 2: Calibración 
Calibrar las n vistas usando el método de Calibración Simple visto en clases [ver ejemplo de la mesa](https://github.com/domingomery/vision/blob/master/clases/Cap02_Geometria/presentaciones/CV02_Calibration.pptx)


## Paso 3: Matriz Fundamental 
Estimar la Matriz Fundamental ([vistas calibradas](https://github.com/domingomery/vision/blob/master/clases/Cap02_Geometria/presentaciones/CV02_EpipolarGeometry.pptx)) para la Geometría Epipolar de imágenes 1 y 2. IMPORTANTE: No usar el método de las vistas no calibradas del Trabajo en Clases 03.

## Paso 4: Selección de Punto en Imagen 1 (m1)
Encontrar un punto llamativo en la imagen 1, este punto se llamará m1. Se debe usar algún método de procesamiento de imágenes simple para encontrar este punto, por ejemplo se puede poner una marca roja en la parte más alta del objeto a medir. Se recomienda que al inicio del desarrollo del proyecto, las coordenadas de este punto sean definidas manualmente.

## Paso 5: Línea Epipolar
Encontrar la línea epipolar de m1 en la imagen 2.

## Paso 6: Punto Correspondiente en Imagen 2 (m2)
Encontrar el punto correspondiente sobre la línea epipolar, este punto se llamará m2. En la siguiente figura se muestran m1 (punto rojo), m2 (punto amarillo) y línea epipolar.


<img src="https://github.com/domingomery/vision/blob/master/proyectos/Proyecto_01/cajas_epipolar.png" width="600">

## Paso 7: Reconstrucción 3D

A partir de los puntos encontrados (m1 y m2) encontrar el punto 3D usando el [algoritmo](https://colab.research.google.com/drive/1yZZA3IZ2NB9bK8QMKL4_xQZkBNTNCUEz?usp=sharing) de reconstrucción 3D visto en clases.


## Paso 8: Medición de altura
A partir de la reconstrucción 3D estime la altura del objeto.

## Pasos adicionales:

* Comparación de la altura medida con la altura real (usando una regla de medición)

* Incluya una tercera imagen y use Geometría [Epipolar de Tres Vistas](https://github.com/domingomery/vision/blob/master/clases/Cap02_Geometria/presentaciones/CV02_EpipolarGeometry.pptx) repitiendo adecuadamente los pasos 3, 5, 6, 7 y 8.

* Incluya más objetos. El algoritmo debe funcionar con al menos tres objetos distintos.

* Incluir mejoras al método propuesto <== MUY IMPORTANTE

* Opcional: use trípode para tomar imágenes con y sin objetos

## Trabajo en Grupo
Se debe conformar un grupo de 3 integrantes.

## Fechas de Desarrollo en Clase
- Mi. 22/Sep > Entrega de Avances el Ju. 23 (al menos la calibración debe estar hecha)
- Mi. 29/Sep

## Fecha de Entrega
- Ver agenda en Google Classroom 

## Informe (20%)
En el informe se evalua calidad del informe, explicaciones, redacción, ortografía. El informe debe ser un PDF de no más de 8 páginas (Times New Roman, Espacio Simple, Tamano Carta, Tamano de Letra 10,11 o 12), con margenes razonables. El informe debe estar bien escrito en lenguaje formal, no coloquial ni anecdótico, sin faltas de ortografía y sin problemas de redacción. El informe debe contener: 1) Motivacion: explicar la relevancia del proyecto. 2) Solución propuesta: explicar cada uno de los pasos y haciendo referencia al código. 3) Experimentos realizados: explicar los experimetos, datos y los resultados obtenidos. 5) Conclusiones: mencionar las conclusiones a las que se llego.

## Solución Propuesta (50%)
A partir del enunciado, se deberá implementar una solución en Python usando Google Colab. El código diseñado debe ser debidamente comentado y explicado, por favor ser lo más claro posible para entender su solución, para hacer más fácil la corrección y para obtener mejor nota. Se evalua la calidad del método, si el diseño es robusto y rápido para el problema dado, si los experimentos diseñados y los datos empleados son adecuados, si el código es entendible, limpio, ordenado y bien comentado.

## Resultados Obtenidos (30%)
La nota en este item tendra que ver con la calidad de los resultados.

## Indicaciones para subir la tarea
El Proyecto (esto es un archivo Colab y el PDF del informe) debe subirse a Google Classroom.  

## Foro
Hacer comentarios preguntas que se hayan contestado en clases en el [foro](https://github.com/domingomery/vision/issues/4).
