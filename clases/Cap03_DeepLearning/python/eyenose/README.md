# Ejemplos: Convolutional Neural Networks (CNN)

## Ejemplo 1: EyeNose (reconocimiento de ojos vs. narices)
Este ejemplo tiene dos clases. Las imagenes estan en un archivo matlab [eyenose.mat](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/eyenose/eyenose.mat). En este archivo hay cuatro variables:
* X_train : arreglo de 8320 x 1 x 32 x 32 > 8320 patches de 32 x 32 pixeles (en escala de grises)
* X_test  : arreglo de 2080 x 1 x 32 x 32 > 2080 patches de 32 x 32 pixeles (en escala de grises)
* Y_train : arreglo de 8320 x 1 > clase de cada una de las muestras de training (0: ojo, 1: nariz)
* Y_train : arreglo de 2080 x 1 > clase de cada una de las muestras de training (0: ojo, 1: nariz)

Para entrenar un modelo se sugiere usar el programa [main.py](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/eyenose/main.py). Ver en las lineas 17 y 18 como se ejecuta. La arquitectura del modelo se define en las lineas 26, 27 y 28. En este ejemplo la primera capa es una layer tipo convolucional de 7x7x2, la segunda capa es de 5x5x4, y asi sucesivamente. El modelo termina con una capa fully connected de 10 nodos (que luego se combinan con otra capa fully connected de dos nodos porque este problema es de dos clases).


## Ejemplo 2: CatDog (reconocimiento de gatos vs. perros)
Al igual que el ejemplo anterior, este ejemplo tiene dos clases. Las imagenes originales de training y testing en formato jpg se pueden descargar [aqui](https://www.dropbox.com/sh/5ovb01dw0z2gd3g/AABqt0R3PB4hIaVevThDJHfJa?dl=0). Ademas se pueden utilizar las siguientes versiones de la base de datos en las que se encuentran definidas las variables X_train, X_tes, Y_train y Y_test:
* [catdog32x32x1.mat](https://www.dropbox.com/s/kirxbkv3tafcm07/catdog32x32x1.mat?dl=0): patches de 32x32 en escala de grises
* [catdog64x64x1.mat](https://www.dropbox.com/s/zb26q65n2k6ixnb/catdog64x64x1.mat?dl=0)): patches de 64x64 en escala de grises
* [catdog64x64x3.mat](https://www.dropbox.com/s/eiu5z1vswxr13er/catdog64x64x3.mat?dl=0)): patches de 64x64x3 en colores RGB
* [catdog128x128x3.mat](https://www.dropbox.com/s/iapgvgjymcb1tgz/catdog128x128x3.mat?dl=0)): patches de 128x128x3 en colores RGB
(los archivos .mat fueron generados con este [codigo](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/eyenose/buildDataset_catdog.m))

Para entrenar un modelo se sugiere usar el programa [main_new.py](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/eyenose/main_new.py). Este programa es igual que el anterior pero acepta imagenes a color (ver definicion de la variable input_shape en la linea 119).



---


Updated on 12-Sep-2019 at 9:30 by Domingo Mery
