# Ejemplos: Reconoocimiento de Caras usando dlib, facenet y arcface

Para estos ejemplos contamos con 5 images de caras (disponibles en la carpeta [faces](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/)): 2 fotos de M. Bachelet (mb_01.jpg y mb_02.jpg), 2 fotos de S. Pinera (sp_01.jpg y sp_02.jpg) y 1 foto de otra persona (xx_01.jpg).

<img src="https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/mb_01.jpg" width="100">
<img src="https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/mb_02.jpg" width="100">
<img src="https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/sp_01.jpg" width="100">
<img src="https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/sp_02.jpg" width="100">
<img src="https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/faces/xx_01.jpg" width="100">

Para cada una de estas fotos se debe sacar un descriptor usando tres metodos distintos: dlib, facenet y arcface. Los tamanos de los descriptores son n = 128, 512 y 192 elementos respectivamente. Para cada uno de los metodos se ofrece un codigo de referencia que extrae el descriptor original para cada imagen y lo almacena en una matriz de 5 x n elementos. Es necesario normalizar las filas de esta matriz para que tengan norma uno, de esta forma la similitud entre la cara i y la cara j queda establecida por el producto punto de la fila i con la fila j de esta matriz. Si el producto punto, que equivale al coseno del angulo formado por estos vectores, es mayor a un umbral, entonces podemos decir que ambas caras pueden pertenecer a la misma persona. La matriz normalizada, de tamano 5 x n, se puede guardar en una matriz X, de esta forma para establecer la similitud entre todas las caras se realiza la multiplicacion matricial de X por su transpuesta. Los valores i,j que superan el umbral de en esta matriz determinaran que las caras i y j pertenecerian a la misma persona. En el caso de i=j (diagonal de la matriz) el valor es 1 porque se compara una imagen consigo misma.



## Ejemplo 1: Libreria dlib (nivel principiante)
Para aquellas personas que nunca han trabajado en reconocimiento de caras se recomienda usar la libreria dlib, cuya instalacion es muy simple.  Ver instlacion de dlib [aqui](https://pypi.org/project/dlib/). Como referencia para utilizar dlib en reconocimiento de caras se recomienda usar el codigo disponible en esta [carpeta](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/dlib/). Este codigo genera un archivo npy de 5 x 128 con los descriptores originales (no normalizados). Es necesario normalizar y obtener una matriz X cuyas filas tengan norma uno. El resultado de la multiplicacion de X por su transpuesta debe dar esto: 

`    ...... mb_01     mb_02     sp_01     sp_02     xx_01`

`    mb_01     1.0000    0.9755    0.8425    0.8601    0.8850`

`    mb_02     0.9755    1.0000    0.8311    0.8661    0.8750`

`    sp_01     0.8425    0.8311    1.0000    0.9534    0.8474`

`    sp_02     0.8601    0.8661    0.9534    1.0000    0.8617`

`    xx_01     0.8850    0.8750    0.8474    0.8617    1.0000`

Se observa que con un umbral de 0.95 se puede obtener un buen reconocimiento de caras.


## Ejemplo 2: Libreria facenet (nivel intermedio)
Para aquellas personas que tienen algo de experiencia en reconocimiento de caras se recomienda usar la libreria facenet.  Ver instlacion de dlib [aqui](https://github.com/nyoki-mtl/keras-facenet). Como referencia para utilizar facenet en reconocimiento de caras se recomienda usar el codigo disponible en esta [carpeta](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/facenet/). Este codigo genera un archivo npy de 5 x 512 con los descriptores originales (no normalizados). Es necesario normalizar y obtener una matriz X cuyas filas tengan norma uno. El resultado de la multiplicacion de X por su transpuesta debe dar esto: 

`    ...... mb_01     mb_02     sp_01     sp_02     xx_01`

`    mb_01     1.0000    0.8588    0.0518    0.0445   -0.0159`

`    mb_02     0.8588    1.0000    0.0466    0.1081    0.1102`

`    sp_01     0.0518    0.0466    1.0000    0.8306   -0.0410`

`    sp_02     0.0445    0.1081    0.8306    1.0000   -0.0221`

`    xx_01    -0.0159    0.1102   -0.0410   -0.0221    1.0000`

Se observa que con un umbral de 0.8 se puede obtener un buen reconocimiento de caras.

## Ejemplo 3: Libreria arcface (nivel avanzado)
Para aquellas personas que tienen experiencia en reconocimiento de caras se recomienda usar la libreria arcface.  Existen muchas versiones, algunas requieren GPU. Para una implementacion sin GPU se recomienda usar el codigo disponible en esta [carpeta](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/facerecognition/arcface/). Antes de correr el codigo se debe bajar el archiovo resnet100.onnx (ver instrucciones en el archivo de texto en la carpeta). Este codigo genera un archivo npy de 5 x 192 con los descriptores originales (no normalizados). Es necesario normalizar y obtener una matriz X cuyas filas tengan norma uno. El resultado de la multiplicacion de X por su transpuesta debe dar esto: 

`    ...... mb_01     mb_02     sp_01     sp_02     xx_01`

`    mb_01     1.0000    0.7335    0.0751    0.0699    0.0493`

`    mb_02     0.7335    1.0000    0.0448    0.0749    0.0389`

`    sp_01     0.0751    0.0448    1.0000    0.7201   -0.0067`

`    sp_02     0.0699    0.0749    0.7201    1.0000    0.0772`

`    xx_01     0.0493    0.0389   -0.0067    0.0772    1.0000`

Se observa que con un umbral de 0.7 se puede obtener un buen reconocimiento de caras.


---


Updated on 23-Sep-2019 at 11:20 by Domingo Mery
