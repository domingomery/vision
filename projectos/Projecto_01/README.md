# Proeycto 01: Google Street en el Campus San Joaquin

## Enunciado
El objetivo de esta tarea es realizar un navegador por el campus a partir de algunas imagenes estaticas y transformaciones proyectivas 2D. Con este fin se deben tomar un conjunto de no mas de 40 imagenes en el Callejon de Mineria del Campus San Joquin (que se encuentra al lado del Resturant Clementina). 

## Adquisicion de Imagenes
Las fotos deben ser tomadas de la siguiente manera (esta forma que sirva de referencia, puede haber otras formas similares): Ubicarse en el inicio del Callejon 1) en este punto se toman unas 8 imagenes haciendo rotar el eje vertical de la camara en 360 grados (por ejemplo una foto a 0 grados, otra a 45 grados, etc), 2) luego caminando hacia adelante (internandose en el Callejon) tomar una foto cada unos 30-50 cm hasta llegar a un nuevo punto a unos 2 metros del punto anterior, 3) repetir al menos dos veces los puntos 1) y 2). 

## Procesamiento
a) Se debe generar una panoramica de 360 grados para conjunto de imagenes del punto 1) explicado en la adquisicion de imagenes. b) se debe generar las imagenes intermedias del punto 2), es decir, si las fotos fueron tomadas cada 30 cm, es necesario generar las 30 imagenes intermedias por cada centimetro de avance (considerar la distancia de un centimetro entre frame y frame como referencia). c) generar un video a color de al menos 2 minutos de frames de al menos 400 x 600 pixeles, que muestre el Callejon como si hubiese sido capturado por una camara de video que siga la trayectoria explicada en la adquisicion de imagenes. En el diseno pensar en una solucion que pueda generar un video para cualquier secuencia. Para la entrega se debe presentar solamente el video del punto c. 

## Fechas de Desarrollo en Clase
Mi. 28/Ago 
Lu. 02/Sep

## Presentacion
Mi. 04/Sep 

## Informe (20%)
En el informe se evalua calidad del informe, explicaciones, redaccion, ortografia. El informe debe ser un PDF de una sola pagina (una cara en Times New Roman, Espacio Simple, Tamano Carta, Tamano de Letra 10,11 o 12), con margenes razonables. El informe debe estar bien escrito en lenguaje formal, no coloquial ni anecdotico, sin faltas de ortografia y sin problemas de redaccion. El informe debe contener: 1) Motivacion: explicar la relevancia de la tarea. 2) Solucion propuesta: explicar cada uno de los pasos y haciendo referencia al codigo. 3) Experimentos realizados: explicar los experimetos, datos y los resultados obtenidos. 5) Conclusiones: mencionar las conclusiones a las que se llego. Ver [Informe Modelo](https://github.com/domingomery/imagenes/blob/master/tareas/TareaModelo.pdf).

## Solución Propuesta (50%)
A partir del enunciado, se debera implementar una solución en Matlab o Python. El codigo disenado debe ser debidamente comentado y explicado, por favor sea lo más claro posible para entender su solucion, para hacer más fácil la corrección y para obtener mejor nota. Se evalua la calidad del metodo, si el diseno es robusto y rapido para el problema dado, si los experimentos disenados y los datos empleados son adecuados, si el codigo es entendible, limpio, ordenado y bien comentado.

## Resultados Obtenidos (30%)
La nota en este item tendra que ver con la calidad (subjetiva) del video.

## Indicaciones para subir la tarea
 El video debera ser subido a YouTube, DropBox, o Google Drive, y se debera etc. El link del video subido y el informe sera enviado por correo electronico al [profesor](mailto:domingo.mery@uc.cl) antes de la presentacion.  

## Foro
Hacer comentarios preguntas que se hayan contestado en clases en el [foro](https://github.com/domingomery/vision/issues/1).
