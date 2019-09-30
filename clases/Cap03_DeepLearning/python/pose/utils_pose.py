import numpy as np
import os
import cv2
import math
from math import cos, sin

def plot_pose_cube(img, yaw, pitch, roll, tdx=None, tdy=None, size=150.):
  # Input is a cv2 image
  # pose_params: (pitch, yaw, roll, tdx, tdy)
  # Where (tdx, tdy) is the translation of the face.
  # For pose we have [pitch yaw roll tdx tdy tdz scale_factor]

  p = pitch * np.pi / 180
  y = -(yaw * np.pi / 180)
  r = roll * np.pi / 180
  if tdx != None and tdy != None:
    face_x = tdx - 0.50 * size
    face_y = tdy - 0.50 * size
  else:
    height, width = img.shape[:2]
    face_x = width / 2 - 0.5 * size
    face_y = height / 2 - 0.5 * size

  x1 = size * (cos(y) * cos(r)) + face_x
  y1 = size * (cos(p) * sin(r) + cos(r) * sin(p) * sin(y)) + face_y
  x2 = size * (-cos(y) * sin(r)) + face_x
  y2 = size * (cos(p) * cos(r) - sin(p) * sin(y) * sin(r)) + face_y
  x3 = size * (sin(y)) + face_x
  y3 = size * (-cos(y) * sin(p)) + face_y

  # Draw base in red
  cv2.line(img, (int(face_x), int(face_y)), (int(x1),int(y1)),(0,0,255),3)
  cv2.line(img, (int(face_x), int(face_y)), (int(x2),int(y2)),(0,0,255),3)
  cv2.line(img, (int(x2), int(y2)), (int(x2+x1-face_x),int(y2+y1-face_y)),(0,0,255),3)
  cv2.line(img, (int(x1), int(y1)), (int(x1+x2-face_x),int(y1+y2-face_y)),(0,0,255),3)
  # Draw pillars in blue
  cv2.line(img, (int(face_x), int(face_y)), (int(x3),int(y3)),(255,0,0),2)
  cv2.line(img, (int(x1), int(y1)), (int(x1+x3-face_x),int(y1+y3-face_y)),(255,0,0),2)
  cv2.line(img, (int(x2), int(y2)), (int(x2+x3-face_x),int(y2+y3-face_y)),(255,0,0),2)
  cv2.line(img, (int(x2+x1-face_x),int(y2+y1-face_y)), (int(x3+x1+x2-2*face_x),int(y3+y2+y1-2*face_y)),(255,0,0),2)
  # Draw top in green
  cv2.line(img, (int(x3+x1-face_x),int(y3+y1-face_y)), (int(x3+x1+x2-2*face_x),int(y3+y2+y1-2*face_y)),(0,255,0),2)
  cv2.line(img, (int(x2+x3-face_x),int(y2+y3-face_y)), (int(x3+x1+x2-2*face_x),int(y3+y2+y1-2*face_y)),(0,255,0),2)
  cv2.line(img, (int(x3), int(y3)), (int(x3+x1-face_x),int(y3+y1-face_y)),(0,255,0),2)
  cv2.line(img, (int(x3), int(y3)), (int(x3+x2-face_x),int(y3+y2-face_y)),(0,255,0),2)

  return img

def draw_axis(img, yaw, pitch, roll, tdx=None, tdy=None, size = 100):
  pitch = pitch * np.pi / 180
  yaw = -(yaw * np.pi / 180)
  roll = roll * np.pi / 180

  if tdx != None and tdy != None:
    tdx = tdx
    tdy = tdy
  else:
    height, width = img.shape[:2]
    tdx = width / 2
    tdy = height / 2

  # X-Axis pointing to right. drawn in red
  x1 = size * (cos(yaw) * cos(roll)) + tdx
  y1 = size * (cos(pitch) * sin(roll) + cos(roll) * sin(pitch) * sin(yaw)) + tdy

  # Y-Axis | drawn in green
  x2 = size * (-cos(yaw) * sin(roll)) + tdx
  y2 = size * (cos(pitch) * cos(roll) - sin(pitch) * sin(yaw) * sin(roll)) + tdy

  # Z-Axis (out of the screen) drawn in blue
  x3 = size * (sin(yaw)) + tdx
  y3 = size * (-cos(yaw) * sin(pitch)) + tdy

  cv2.line(img, (int(tdx), int(tdy)), (int(x1),int(y1)),(0,0,255),3)
  cv2.line(img, (int(tdx), int(tdy)), (int(x2),int(y2)),(0,255,0),3)
  cv2.line(img, (int(tdx), int(tdy)), (int(x3),int(y3)),(255,0,0),2)

  return img