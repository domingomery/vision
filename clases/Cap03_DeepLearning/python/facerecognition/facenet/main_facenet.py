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
#    mb_01     1.0000    0.8588    0.0518    0.0445   -0.0159
#    mb_02     0.8588    1.0000    0.0466    0.1081    0.1102
#    sp_01     0.0518    0.0466    1.0000    0.8306   -0.0410
#    sp_02     0.0445    0.1081    0.8306    1.0000   -0.0221
#    xx_01    -0.0159    0.1102   -0.0410   -0.0221    1.0000#
# with a threshold = 0.8 the recognition is possible

import numpy as np
from keras.preprocessing import image
import argparse
from os import path, listdir, makedirs
from models import facenet
from utils import dirfiles, num2fixstr


def preprocess_by_img(img):
    mean = np.mean(img)
    std = np.std(img)
    height, widht = img.size
    size = height * widht
    std_adj = np.maximum(std, 1.0 / np.sqrt(size))

    return np.multiply(np.subtract(img, mean), 1 / std_adj)


def preprocess_fixed(img):
    img -= 127.5
    img /= 128

    return img


def l2_normalize(x, axis=-1, epsilon=1e-10):
    output = x / np.sqrt(np.maximum(np.sum(np.square(x), axis=axis, keepdims=True), epsilon))

    return output


def extract_features(weights, norm_type, source, destination):
    if path.isfile(source):
        full_path = True
        source_list = np.sort(np.loadtxt(source, dtype=np.str))
    else:
        full_path = False
        source_list = listdir(source)

    n_features = 128

    # VGGFace2 and Casia has 512 features as output
    if norm_type == 2:
        n_features = 512

    model = facenet.InceptionResNetV1(weights_path=weights, classes=n_features)

    for image_name in source_list:
        if not full_path:
            image_path = path.join(source, image_name)
        else:
            image_path = image_name
            image_name = path.split(image_name)[1]

        if not image_path.lower().endswith('.png') and not image_path.lower().endswith('.jpg') \
           and not image_path.lower().endswith('.bmp'):
            continue

        img = image.load_img(image_path, target_size=(160, 160))

        # this normalization is used with Celeb dataset
        if norm_type == 1:
            img = preprocess_by_img(img)

        img = image.img_to_array(img)
        img = np.expand_dims(img, axis=0)

        # this normalization is used with VGGFace2 and Casia-WebFace datasets
        if norm_type == 2:
            img = preprocess_fixed(img)

        features = model.predict(img)
        # features = l2_normalize(features)

        dest_path = destination

        if full_path:
            sub_folder = path.basename(
                path.normpath(path.split(image_path)[0]))

            dest_path = path.join(destination, sub_folder)

            if not path.exists(dest_path):
                makedirs(dest_path)

        features_name = path.join(dest_path, image_name[:-3] + 'npy')

        np.save(features_name, features)


norm_type  = 2

if norm_type == 1:
    weights    = 'weights/facenet_keras_ms1_celeb_weights.h5'
    n_features = 128
else:
    weights    = 'weights/facenet_keras_vggface2_weights.h5'
    # weights    = 'weights/facenet_keras_casia_webface_weights.h5'
    n_features = 512

model = facenet.InceptionResNetV1(weights_path=weights, classes=n_features)


dirpath = '../faces/'
img_names = dirfiles(dirpath,'*.jpg')

n = len(img_names)

i = 0
for i in range(n):
    img = img_names[i]
    print('facenet: '+ num2fixstr(i,4)+'/'+num2fixstr(n,4)+ ': reading '+img+'...')

    img = image.load_img(dirpath+img, target_size=(160, 160))
    if norm_type == 1:
        img = preprocess_by_img(img)
    img = image.img_to_array(img)
    img = np.expand_dims(img, axis=0)
    if norm_type == 2:
        img = preprocess_fixed(img)
    features = model.predict(img)
    if i==0:
        m = features.shape[1]
        data = np.zeros((n,m))
        
    data[i]    = features[0]

print('original features (not normalized) are saved in data_facenet.npy...   ')
np.save('data_facenet',data)

