# Ejemplos: Convolutional Neural Networks (CNN)

## Ejemplo 1: EyeNose (reconocimiento de ojos vs. narices)
Este ejemplo tiene dos clases. Las imagenes estan en un archivo matlab [eyenose.mat](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/eyenose/eyenose.mat). En este archivo hay cuatro variables:
* X_train : arreglo de 8320 x 1 x 32 x 32 > 8320 patches de 32 x 32 pixeles (en escala de grises)
* X_test  : arreglo de 2080 x 1 x 32 x 32 > 2080 patches de 32 x 32 pixeles (en escala de grises)
* Y_train : arreglo de 8320 x 1 > clase de cada una de las muestras de training (0: ojo, 1: nariz)
* Y_train : arreglo de 2080 x 1 > clase de cada una de las muestras de training (0: ojo, 1: nariz)

Para entrenar un modelo se sugiere usar el programa [main.py](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/eyenose/main.py). Ver en las lineas 17 y 18 como se ejecuta. La arquitectura del modelo se define en las lineas 26, 27 y 28. En este ejemplo la primera capa es una layer tipo convolucional de 7x7x2, la segunda capa es de 5x5x4, y asi sucesivamente. El modelo termina con una capa fully connected de 10 nodos (que luego se combinan con otra capa fully connected de dos nodos porque este problema es de dos clases).

---


Updated on 12-Sep-2019 at 9:30 by Domingo Mery
