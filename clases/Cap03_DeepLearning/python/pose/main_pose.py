# -*- coding: utf-8 -*-

from mxnet import gluon
from mxnet.gluon import nn
from mxnet import nd
from collections import namedtuple
import random
import mxnet as mx
import cv2
import argparse
import numpy as np
from PIL import Image
import os
import utils_pose
from utils import dirfiles, num2fixstr, imread
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.pyplot import savefig

def stable_softmax(z):
    z = nd.exp(z - nd.max(z, axis=1, keepdims=True))
    return z / mx.nd.sum(z, axis=1).reshape((batch_size, 1))

def bin_label(z):
    # Real label to Bin label
    z = (z + 102) / 3.0
    z = nd.ceil(z)
    return z

def calc_loss(pred, label):
    # Mean average loss
    softmax_pred = stable_softmax(pred) + NEAR_0
    expectation = idx_tensor * softmax_pred
    expectation = nd.sum(expectation, 1) * 3 - 102
    loss = nd.abs(expectation - label)
    loss = nd.sum(loss) / len(loss)
    return loss

batch_size = 1 
image_size = 48
model_structure = 'model/model_15-symbol.json' 
model_params = 'model/model_15-0000.params' 
dev = -1
    
if dev == -1:
    ctx = mx.cpu()
else:
    ctx = mx.gpu(dev)
      
NEAR_0 = 1e-10
idx_tensor = nd.array([idx for idx in range(1,67)]).as_in_context(ctx)
    
resize_w, resize_h = 48, 48
channel = 1
      
symnet = mx.symbol.load(model_structure)
mod = mx.mod.Module(symbol=symnet, context=ctx)
mod.bind(data_shapes=[('data', (batch_size, 1, 48, 48))])
mod.load_params(model_params)
Batch = namedtuple('Batch', ['data'])

# read images
dirpath = 'test_images/'
image_names = dirfiles(dirpath,'*.jpg')

n = len(image_names)
pose = np.zeros((n,3))
for i in range(n):
    image_name = image_names[i]
    print(image_name)
    image_file = dirpath + '/' + image_name
    img = cv2.imread(image_file, 0)
            
            
    img = cv2.resize(img, (image_size, image_size))
    img = img[np.newaxis]
    img = img[np.newaxis]

    # net forward
    mod.forward(Batch([mx.nd.array(img)]),is_train=False)

    # get result
    pred = mod.get_outputs()
    pred_pitch,pred_roll,pred_yaw = pred[0][0,0:66].reshape([1,66]),pred[0][0,66:66*2].reshape([1,66]),pred[0][0,66*2:66*3].reshape([1,66])
            
    # expectation
    softmax_pred_pitch = stable_softmax(pred_pitch) + NEAR_0
    expectation_pitch = idx_tensor * softmax_pred_pitch
    expectation_pitch = nd.sum(expectation_pitch, 1) * 3 - 99

    softmax_pred_roll = stable_softmax(pred_roll) + NEAR_0
    expectation_roll = idx_tensor * softmax_pred_roll
    expectation_roll = nd.sum(expectation_roll, 1) * 3 - 99

    softmax_pred_yaw = stable_softmax(pred_yaw) + NEAR_0
    expectation_yaw = idx_tensor * softmax_pred_yaw
    expectation_yaw = nd.sum(expectation_yaw, 1) * 3 - 99

    pose[i][0] = expectation_pitch.asnumpy()[0]
    pose[i][1] = expectation_roll.asnumpy()[0]
    pose[i][2] = expectation_yaw.asnumpy()[0]

print('saving pitch, roll and yaw in pose.npy  ...   ')
np.save('pose',pose)

