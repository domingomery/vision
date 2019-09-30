# Ejemplos: Atributos faciales

## Ejemplo 1: Extraccion de landmarks, expresiones faciales, genero y edad
Este ejemplo contiene un [codigo](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/attributes/main_attributes.py) que es capaz de extraer para las n imagenes de caras contenidas en el directorio [faces](https://github.com/domingomery/vision/tree/master/clases/Cap03_DeepLearning/python/facerecognition/faces) los siguientes atributos:

* Coordenadas (x,y) de 68 landmarks faciales: Los Landmarks se almacenan en el archivo landmarks.npy. El archivo contiene una matriz de n filas y 136 columnas. La fila i contiene las coordenadas de los 68 landmarks de la cara i (los primeros 68 elementos para la coordenada x y los ultimos 68 elementos para la coordenada y).

* Expresiones faciales: Las expresiones faciales se almacenan en el archivo expressions.npy. El archivo contiene una matriz de n filas y 7 columnas. La fila i contiene las  7 expresiones de la cara i ("angry", "disgust", "scared", "happy", "sad", "surprised", "neutral"). La suma de cada fila es 1.

* Genero (mujer/hombre) y edad: Genero y edad se almacenan en el archivo gender_age.npy. El archivo contiene una matriz de n filas y 2 columnas. La fila i contiene dos valores, el primero indica la probabilidad de que la cara i pertenezca a una mujer (es decir la cara es clasificada como femeninan si esta valor es mayor que 0.5, de lo contrario es clasificada como una cara masculina); el segundo valor es la edad en a~nos. 

---


Updated on 30-Sep-2019 at 11:30 by Domingo Mery
