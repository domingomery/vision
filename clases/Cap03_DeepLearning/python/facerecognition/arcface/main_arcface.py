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
#    mb_01     1.0000    0.7335    0.0751    0.0699    0.0493
#    mb_02     0.7335    1.0000    0.0448    0.0749    0.0389
#    sp_01     0.0751    0.0448    1.0000    0.7201   -0.0067
#    sp_02     0.0699    0.0749    0.7201    1.0000    0.0772
#    xx_01     0.0493    0.0389   -0.0067    0.0772    1.0000
# with a threshold = 0.7 the recognition is possible


from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
import cv2
import sys
import numpy as np
import mxnet as mx
import os

from scipy import misc
import random
import sklearn
from sklearn.decomposition import PCA
from time import sleep
from easydict import EasyDict as edict
from mtcnn_detector import MtcnnDetector
from skimage import transform as trans
import matplotlib.pyplot as plt
from mxnet.contrib.onnx.onnx2mx.import_model import import_model


import fnmatch
from utils import dirfiles, num2fixstr


def get_model(ctx, model):
    image_size = (112,112)
    # Import ONNX model
    sym, arg_params, aux_params = import_model(model)
    # Define and binds parameters to the network
    model = mx.mod.Module(symbol=sym, context=ctx, label_names = None)
    model.bind(data_shapes=[('data', (1, 3, image_size[0], image_size[1]))])
    model.set_params(arg_params, aux_params)
    return model


#for i in range(4):
#    mx.test_utils.download(dirname='mtcnn-model', url='https://s3.amazonaws.com/onnx-model-zoo/arcface/mtcnn-model/det{}-0001.params'.format(i+1))
#    mx.test_utils.download(dirname='mtcnn-model', url='https://s3.amazonaws.com/onnx-model-zoo/arcface/mtcnn-model/det{}-symbol.json'.format(i+1))
#    mx.test_utils.download(dirname='mtcnn-model', url='https://s3.amazonaws.com/onnx-model-zoo/arcface/mtcnn-model/det{}.caffemodel'.format(i+1))
#    mx.test_utils.download(dirname='mtcnn-model', url='https://s3.amazonaws.com/onnx-model-zoo/arcface/mtcnn-model/det{}.prototxt'.format(i+1))

# Determine and set context


if len(mx.test_utils.list_gpus())==0:
    ctx = mx.cpu()
else:
    ctx = mx.gpu(0)
# Configure face detector
# det_threshold = [0.6,0.7,0.8]
#mtcnn_path = os.path.join(os.path.dirname('__file__'), 'mtcnn-model')
#detector = MtcnnDetector(model_folder=mtcnn_path, ctx=ctx, num_worker=1, accurate_landmark = True, threshold=det_threshold)

# no threshold using pr = get_image(im)                  d-prime = 2.443
# with threshold = 0.1 and accurate_landmark = False.... d-prime = 3.271
det_threshold = [0.01,0.01,0.01]
mtcnn_path = os.path.join(os.path.dirname('__file__'), 'mtcnn-model')
detector = MtcnnDetector(model_folder=mtcnn_path, ctx=ctx, num_worker=1, accurate_landmark = False, threshold=det_threshold)


def preprocess(img, bbox=None, landmark=None, **kwargs):
    M = None
    image_size = []
    str_image_size = kwargs.get('image_size', '')
    # Assert input shape
    if len(str_image_size)>0:
        image_size = [int(x) for x in str_image_size.split(',')]
        if len(image_size)==1:
            image_size = [image_size[0], image_size[0]]
        assert len(image_size)==2
        assert image_size[0]==112
        assert image_size[0]==112 or image_size[1]==96
    
    # Do alignment using landmark points
    if landmark is not None:
        assert len(image_size)==2
        src = np.array([
          [30.2946, 51.6963],
          [65.5318, 51.5014],
          [48.0252, 71.7366],
          [33.5493, 92.3655],
          [62.7299, 92.2041] ], dtype=np.float32 )
        if image_size[1]==112:
            src[:,0] += 8.0
        dst = landmark.astype(np.float32)
        tform = trans.SimilarityTransform()
        tform.estimate(dst, src)
        M = tform.params[0:2,:]
        assert len(image_size)==2
        warped = cv2.warpAffine(img,M,(image_size[1],image_size[0]), borderValue = 0.0)
        return warped
    
    # If no landmark points available, do alignment using bounding box. If no bounding box available use center crop
    if M is None:
        if bbox is None:
            det = np.zeros(4, dtype=np.int32)
            det[0] = int(img.shape[1]*0.0625)
            det[1] = int(img.shape[0]*0.0625)
            det[2] = img.shape[1] - det[0]
            det[3] = img.shape[0] - det[1]
        else:
            det = bbox
        margin = kwargs.get('margin', 44)
        bb = np.zeros(4, dtype=np.int32)
        bb[0] = np.maximum(det[0]-margin/2, 0)
        bb[1] = np.maximum(det[1]-margin/2, 0)
        bb[2] = np.minimum(det[2]+margin/2, img.shape[1])
        bb[3] = np.minimum(det[3]+margin/2, img.shape[0])
        ret = img[bb[1]:bb[3],bb[0]:bb[2],:]
        if len(image_size)>0:
            ret = cv2.resize(ret, (image_size[1], image_size[0]))
        return ret
    
def get_input(detector,face_img):
    # Pass input images through face detector
    ret = detector.detect_face(face_img, det_type = 0)
    if ret is None:
        return None
    bbox, points = ret
    if bbox.shape[0]==0:
        return None
    bbox = bbox[0,0:4]
    points = points[0,:].reshape((2,5)).T
    # Call preprocess() to generate aligned images
    nimg = preprocess(face_img, bbox, points, image_size='112,112')
    nimg = cv2.cvtColor(nimg, cv2.COLOR_BGR2RGB)
    aligned = np.transpose(nimg, (2,0,1))
    return aligned

def get_image(face_img):
    # Pass input images through face detector
    # nimg = preprocess(face_img, bbox, points, image_size='112,112')
    nimg = cv2.resize(face_img,(112,112))
    nimg = cv2.cvtColor(nimg, cv2.COLOR_BGR2RGB)
    aligned = np.transpose(nimg, (2,0,1))
    return aligned

def get_feature(model,aligned):
    input_blob = np.expand_dims(aligned, axis=0)
    data = mx.nd.array(input_blob)
    db = mx.io.DataBatch(data=(data,))
    model.forward(db, is_train=False)
    embedding = model.get_outputs()[0].asnumpy()
    embedding = sklearn.preprocessing.normalize(embedding).flatten()
    return embedding


model_name = 'resnet100.onnx'
print(" ")
print(" ")
print(" ")
print("- - - - - - - - - - - - - - - - - - - - - - - - -")
print('loading model '+model_name+'...')
model = get_model(ctx , model_name)
print('model loaded!')



dirpath = '../faces/'
img_names = dirfiles(dirpath,'*.jpg')

n = len(img_names)

i = 0

data = np.zeros((n,512))
for i in range(n):
    img = img_names[i]
    print('arcface: '+num2fixstr(i,4)+'/'+num2fixstr(n,4)+ ': reading '+img+'...')

    im = cv2.imread(dirpath+img)
    pr = get_input(detector,im)
    x  = get_feature(model,pr)
    data[i]    = x

print('original features (not normalized) are saved in data_arcface.npy...   ')
np.save('data_arcface',data)

