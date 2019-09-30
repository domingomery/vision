# Ejemplos: Atributos faciales

## Ejemplo 1: Extraccion de landmarks, expresiones faciales, genero y edad
Este ejemplo contiene un [codigo](https://github.com/domingomery/vision/blob/master/clases/Cap03_DeepLearning/python/attributes/main_attributes.py) que es capaz de extraer:
* coordenadas (x,y) de 68 landmarks faciales
Landmarks: Landmarks are stored in file landmarks.npy. It consists of a matrix of n rows and 136 columns, where n is the number of faces in directory 'faces'. Row i has the 68 landmarks of face i  (first 68 elements are coordinates x, last 68 elements are coordinates y).

* expresiones faciales "angry", "disgust", "scared", "happy", "sad", "surprised", "neutral"
Expressions: Expressions are stored in file expressions.npy. It consists of a matrix of n rows and 7 columns, where n is the number of faces in directory 'faces'. Row i has the 7 expressions of face i ("angry","disgust","scared", "happy", "sad", "surprised","neutral"). The sum oof each row is 1.

* genero (mujer/hombre) y edad
Gender & Age: Gender & age are stored in file gender_age.npy. It consists of a matrix of n rows and 2 columns, where n is the number of faces in directory 'faces'. Row i has the 2 values of face i: the first is the probability to be a female (that means the face is classified as female if this value is greater than 0.5, other wise is male); the second value is the estimated age in years. 

---


Updated on 30-Sep-2019 at 11:30 by Domingo Mery
