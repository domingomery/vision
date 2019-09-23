# D. Mery, UC, September, 2019
# http://domingomery.ing.puc.cl

# Face images are in directory 'faces', there are two faces of M. Bachelet (mb_01 and mb_02), 
# two faces of S. Piñera (sp_01 and sp_02) and one face of somebody else (xx_01).
# The features are stored in npy file, one row per image using the following order:
#
# mb_01.jpg...
# mb_02.jpg...
# sp_01.jpg...
# sp_02.jpg...
# xx_01.jpg...
# 
# In order to use cosine similarity, each row must normalized to uni-norm
# the normalized features (norm = 1 for each row) must be stored in matrix X
# Thus, X * X' = 
#              mb_01     mb_02     sp_01     sp_02     xx_01
#    mb_01     1.0000    0.9755    0.8425    0.8601    0.8850
#    mb_02     0.9755    1.0000    0.8311    0.8661    0.8750
#    sp_01     0.8425    0.8311    1.0000    0.9534    0.8474
#    sp_02     0.8601    0.8661    0.9534    1.0000    0.8617
#    xx_01     0.8850    0.8750    0.8474    0.8617    1.0000
#
# with a threshold = 0.95 the recognition is possible

import numpy as np
import face_recognition

from utils import dirfiles, num2fixstr, imread

def dlibfeatures(image):
    fl = None #dlib without face detection
    x0    = face_recognition.face_encodings(image,fl)
    if len(x0)==0:
        fl = [[0,len(image)-1,len(image[0])-1,0]]
        x = face_recognition.face_encodings(image,fl)[0]
    else:
        x = x0[0]
    return x


dirpath = '../faces/'
img_names = dirfiles(dirpath,'*.jpg')

n = len(img_names)

i = 0
for i in range(n):
    img = img_names[i]
    print('dlib: '+ num2fixstr(i,4)+'/'+num2fixstr(n,4)+ ': reading '+img+'...')

    img = imread(dirpath+img)
    features = dlibfeatures(img)
    if i==0:
        m = features.shape[0]
        data = np.zeros((n,m))
        
    data[i]    = features

print('original features (not normalized) are saved in data_dlib.npy...   ')
np.save('data_dlib',data)

