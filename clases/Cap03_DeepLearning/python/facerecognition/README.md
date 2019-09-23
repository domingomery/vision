# Ejemplos: Reconoocimiento de Caras usando dlib, facenet y arcface

Para estos ejemplos contamos con 5 images de caras: 2 fotos de M. Bachelet, 2 fotos de S. Pinera y 1 foto de otra persona.


<img src="https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/mb_01.jpg" width="100">
<img src="https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/mb_02.jpg" width="100">
<img src="https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/sp_01.jpg" width="100">
<img src="https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/sp_02.jpg" width="100">
<img src="https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/mb_01.jpg" width="100">


## Ejemplo 1: Libreria dlib (nivel principiante)
Este ejemplo tiene dos clases. Las imagenes estan en un archivo matlab [eyenose.mat](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/eyenose/eyenose.mat). En este archivo hay cuatro variables:
* X_train : arreglo de 8320 x 1 x 32 x 32 > 8320 patches de 32 x 32 pixeles (en escala de grises)
* X_test  : arreglo de 2080 x 1 x 32 x 32 > 2080 patches de 32 x 32 pixeles (en escala de grises)
* Y_train : arreglo de 8320 x 1 > clase de cada una de las muestras de training (0: ojo, 1: nariz)
* Y_train : arreglo de 2080 x 1 > clase de cada una de las muestras de training (0: ojo, 1: nariz)


## Ejemplo 2: Libreria facenet (nivel principiante)
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
