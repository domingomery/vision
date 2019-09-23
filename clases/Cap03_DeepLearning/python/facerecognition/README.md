# Ejemplos: Reconoocimiento de Caras usando dlib, facenet y arcface

Para estos ejemplos contamos con 5 images de caras (disponibles en la carpeta [faces](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/)): 2 fotos de M. Bachelet (mb_01.jpg y mb_02.jpg), 2 fotos de S. Pinera (sp_01.jpg y sp_02.jpg) y 1 foto de otra persona (xx_01.jpg).

<img src="https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/mb_01.jpg" width="100">
<img src="https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/mb_02.jpg" width="100">
<img src="https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/sp_01.jpg" width="100">
<img src="https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/sp_02.jpg" width="100">
<img src="https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/xx_01.jpg" width="100">

Para cada una de estas fotos se debe sacar un descriptor usando tres metodos distintos, dlib, facenet y arcface. Los tamanos de los descriptores son n = 128, 512 y 192 elementos respectivamente. Para cada uno de los metodos se ofrece un codigo de referencia que extrae el descriptor original para cada imagen y lo almacena en una matriz de 5 x n elementos. Es necesario normalizar las filas de esta matrix para que tengan norma uno, de esta forma la similitud entre la cara i y la cara j queda establecida por el producto punto de la fila i con la fila j de esta matriz. Si el producto punto, que equivale al coseno del angulo formado por estos vetores, es mayor que un threshold entonces podemos decir que ambas caras pertenecen a la misma persona.



## Ejemplo 1: Libreria dlib (nivel principiante)
Este ejemplo tiene dos clases. Las imagenes estan en un archivo matlab [eyenose.mat](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/eyenose/eyenose.mat). En este archivo hay cuatro variables:
* X_train : arreglo de 8320 x 1 x 32 x 32 > 8320 patches de 32 x 32 pixeles (en escala de grises)
* X_test  : arreglo de 2080 x 1 x 32 x 32 > 2080 patches de 32 x 32 pixeles (en escala de grises)
* Y_train : arreglo de 8320 x 1 > clase de cada una de las muestras de training (0: ojo, 1: nariz)
* Y_train : arreglo de 2080 x 1 > clase de cada una de las muestras de training (0: ojo, 1: nariz)


## Ejemplo 2: Libreria facenet (nivel intermedio)
Este ejemplo tiene dos clases. Las imagenes estan en un archivo matlab [eyenose.mat](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/eyenose/eyenose.mat). En este archivo hay cuatro variables:
* X_train : arreglo de 8320 x 1 x 32 x 32 > 8320 patches de 32 x 32 pixeles (en escala de grises)
* X_test  : arreglo de 2080 x 1 x 32 x 32 > 2080 patches de 32 x 32 pixeles (en escala de grises)
* Y_train : arreglo de 8320 x 1 > clase de cada una de las muestras de training (0: ojo, 1: nariz)

## Ejemplo 3: Libreria arcface (nivel avanzado)
Este ejemplo tiene dos clases. Las imagenes estan en un archivo matlab [eyenose.mat](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/eyenose/eyenose.mat). En este archivo hay cuatro variables:
* X_train : arreglo de 8320 x 1 x 32 x 32 > 8320 patches de 32 x 32 pixeles (en escala de grises)
* X_test  : arreglo de 2080 x 1 x 32 x 32 > 2080 patches de 32 x 32 pixeles (en escala de grises)
* Y_train : arreglo de 8320 x 1 > clase de cada una de las muestras de training (0: ojo, 1: nariz)


---


Updated on 12-Sep-2019 at 9:30 by Domingo Mery
