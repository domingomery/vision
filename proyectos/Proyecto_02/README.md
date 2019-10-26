# Proeycto 02: Aplicacion de Analisis Facial en Colecciones de Imagenes

## Enunciado
El objetivo de esta tarea es realizar una aplicacion basada en analisis facial en colecciones de imagenes. Las aplicaciones deberan tener deteccioon de caras, reconocimiento facial, reconocimiento de expresiones, edad, genero, localizacion y pose. Se recomienda ver aplicaciones posbles en este paper:

Mery, D. [Face Analysis: State of the Art and Ethical Challenges](http://dmery.sitios.ing.uc.cl/Prints/Conferences/International/2019-PSIVT.pdf). Vision-Tech Workshop at PSIVT2019.

Algunos ejemplos se muestran a continuacion:
<img src="https://github.com/domingomery/vision/blob/master/proyectos/Proyecto_02/Diagrama.png" width="600">



## Adquisicion de Imagenes
Las imagenes pueden ser adquiridas de una base de datos publica o privada. Si es privada se debera poder mostrar en la presentacion algunas de las fotos (no es necesario hacer las fotos publicas). Las bases de datos mostradas en el paper mencionado pueden ser solicitadas al profesor del curso.

## Procesamiento
a) En un set de mas de 500 imagenes, se debe detectar las caras que se encuentren en ellas (al menos 3000 caras en total). b) Para cada cara se debe extraer al menos el descriptor facial usando ArcFace, 7 expresiones faciales, genero, edad, pose (yaw, pitch y roll) y localizacion (de la cara en la imagen). Este proceso se hace solo una vez y puede durar varias horas. Los resultados deberan guardarse en una base de datos. c) desarrollar una aplicacion rapida que tenga una utilidad practica basada en la base de datos. Variaciones de estas indicaciones se pueden conversar con el profesor. 

## Trabajo en Grupo
Se debe conformar un grupo de 4 integrantes, debe al menos uno/a que haya hecho el curso de Reconocimiento de Patrones, otro/a que haya hecho el curso de Procesamiento de Imagenes, otro/a que domine Matlab y otro/a que domine Python.

## Fechas de Desarrollo en Clase
- Lu. 07/Oct
- Mi. 09/Oct

## Informe (20%)
En el informe se evalua calidad del informe, explicaciones, redaccion, ortografia. El informe debe ser un PDF de una sola pagina (una cara en Times New Roman, Espacio Simple, Tamano Carta, Tamano de Letra 10,11 o 12), con margenes razonables. El informe debe estar bien escrito en lenguaje formal, no coloquial ni anecdotico, sin faltas de ortografia y sin problemas de redaccion. El informe debe contener: 1) Motivacion: explicar la relevancia de la tarea. 2) Solucion propuesta: explicar cada uno de los pasos y haciendo referencia al codigo. 3) Experimentos realizados: explicar los experimetos, datos y los resultados obtenidos. 5) Conclusiones: mencionar las conclusiones a las que se llego. Ver [Informe Modelo](https://github.com/domingomery/imagenes/blob/master/tareas/TareaModelo.pdf).

## Presentacion
- Enviar el informe y un video de 5-10 minutos con la presentacion al [profesor](mailto:domingo.mery@uc.cl) antes del miercoles 06 de Noviembre a las 6:30pm.

## Solución Propuesta (50%)
A partir del enunciado, se debera implementar una solución en Matlab o Python. El codigo disenado debe ser debidamente comentado y explicado, por favor sea lo más claro posible para entender su solucion, para hacer más fácil la corrección y para obtener mejor nota. Se evalua la calidad del metodo, si el diseno es robusto y rapido para el problema dado, si los experimentos disenados y los datos empleados son adecuados, si el codigo es entendible, limpio, ordenado y bien comentado.

## Resultados Obtenidos (30%)
La nota en este item tendra que ver con la calidad (subjetiva) del video.

## Indicaciones para subir la tarea
El informe y las imagenes necesarias deberan ser enviados por correo electronico al [profesor](mailto:domingo.mery@uc.cl) antes de la presentacion.  

## Foro
Hacer comentarios preguntas que se hayan contestado en clases en el [foro](https://github.com/domingomery/vision/issues/2).
