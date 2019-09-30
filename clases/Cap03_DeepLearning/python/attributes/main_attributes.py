# D. Mery, UC, September, 2019
# http://domingomery.ing.puc.cl

# Face images are in directory 'faces', there are two faces of M. Bachelet (mb_01 and mb_02), 
# two faces of S. Piñera (sp_01 and sp_02) and one face of somebody else (xx_01).
# This code extracts for each face 68 face landmarks, 7 facial expressions, age and gender
#
# Landmarks:
# ----------
# Landmarks are stored in file landmarks.npy. It consists of a matrix of n rows and 136 columns,
# where n is the number of faces in directory 'faces'. Row i has the 68 landmarks of face i 
# (first 68 elements are coordinates x, last 68 elements are coordinates y).
#
# Expressions:
# ------------
# Expressions are stored in file expressions.npy. It consists of a matrix of n rows and 7 columns,
# where n is the number of faces in directory 'faces'. Row i has the 7 expressions of face i 
# ("angry","disgust","scared", "happy", "sad", "surprised","neutral"). The sum oof each row is 1.
#
# Gender & Age:
# -------------
# Gender & age are stored in file gender_age.npy. It consists of a matrix of n rows and 2 columns,
# where n is the number of faces in directory 'faces'. Row i has the 2 values of face i: the first 
# is the probability to be a female (that means the face is classified as female if this value is
# greater than 0.5, other wise is male); the second value is the estimated age in years. 



from keras.preprocessing.image import img_to_array
from keras.models import load_model
import imutils
import cv2
import numpy as np
import sys
from utils import dirfiles, num2fixstr, imread
from pyagender import PyAgender
import dlib

predictor = dlib.shape_predictor('shape_predictor_68_face_landmarks.dat')


# parameters for loading data and images
expression_model_path = '_mini_XCEPTION.106-0.65.hdf5'
expression_classifier = load_model(expression_model_path, compile=False)
EXPRESSIONS           = ["angry","disgust","scared", "happy", "sad", "surprised","neutral"]
agender               = PyAgender()


dirpath = '../faces/'
img_names = dirfiles(dirpath,'*.jpg')

n = len(img_names)
print(n)
print(img_names)

gender_age = np.zeros((n,2))

landmarks = np.zeros((n,136))

for i in range(n):
    img = img_names[i]
    fimg = dirpath+img
    print(num2fixstr(i,4)+'/'+num2fixstr(n,4)+ ': reading '+fimg+'...')

    # landmarks
    # ---------
    img = dlib.load_rgb_image(fimg)
    h = img.shape[0]
    w = img.shape[1]
    dlib_rect = dlib.rectangle(int(0), int(0), int(w), int(h)) 
    shape = predictor(img, dlib_rect)

    for j in range(0,68):
        landmarks[i][j]    = shape.part(j).x
        landmarks[i][j+68] = shape.part(j).y

    # expressions
    # -----------
    frame = cv2.imread(fimg,0)
    roi = cv2.resize(frame, (48, 48))
    roi = roi.astype("float") / 255.0
    roi = img_to_array(roi)
    roi = np.expand_dims(roi, axis=0)
    expressions = expression_classifier.predict(roi)[0]
    if i==0:
        m = expressions.shape[0]
        data = np.zeros((n,m))
        
    data[i]    = expressions

    # age and gender
    # --------------
    gender_age[i] = agender.gender_age(cv2.imread(fimg))


print('saving landmarks.npy, expressions.npy, and gender_age.npy and  ...   ')
np.save('landmarks',landmarks)
np.save('expressions',data)
np.save('gender_age',gender_age)

    
