# D. Mery, UC, September, 2019
# http://domingomery.ing.puc.cl


import scipy.io
import numpy as np
import face_recognition
from PIL import Image
from os import listdir
import cv2
from skimage.transform import resize
from sklearn.metrics.pairwise import euclidean_distances
import os, fnmatch
from keras.models import load_model
from pandas import read_csv
from copy import copy, deepcopy
#from face_recognition_toolbox import predict
#from face_recognition_toolbox.methods import FaceNet

fr_str = ['Dlib0','Dlib','FaceNet','vgg','vgg2']
fd_str = ['HOG','CNN','OpenCV']
sc_str = ['CosSim','Euclidean']
# modelvgg2 = FaceNet(model='20180402-114759.pb')


class Facer:
    def __init__(self,fd_method = 0, fr_method = 1, sc_method = 0, uninorm = 1, theta = 0.4):
        self.fd_method = fd_method
        self.fr_method = fr_method
        self.sc_method = sc_method
        self.uninorm   = uninorm
        self.theta     = theta
        self.show_fd   = 0
        self.id_sessions  = [0]
        self.id_subjects  = [0]
        self.session_prefix   = 0
        self.show_fd   = 0
        self.echo  = 0
        self.print_scr = 0
        self.scores = [0]
        self.csv_list = ''


    # printDefinitions()
    # inputs: fd_method, fr_method, sc_method, uninorm, theta
    # output: print all inputs
    def printDefinitions(self):
        self.printComment("fd = "+fd_str[self.fd_method]+", "+ "fr = "+fr_str[self.fr_method]+", "+ "sc = "+sc_str[self.sc_method]+ "(uninorm="+str(self.uninorm)+"), "+ "th = "+str(self.theta))

    # detectFaces()
    # inputs: fd_method, image
    # output: bbox with the bounding boxes of the detected faces
    def detectFaces(self):
        if self.fd_method == 0:    #Dlib - HOG
            self.bbox  = face_recognition.face_locations(self.image)
        elif self.fd_method == 1:  #Dlib - CNN
            self.bbox  = face_recognition.face_locations(self.image, number_of_times_to_upsample=0, model="cnn")
        elif self.fd_method == 2:  #OpenCV - Cascade Classifier
            cascPath = "haarcascade_frontalface_default.xml"
            faceCascade = cv2.CascadeClassifier(cascPath)
            gray = cv2.cvtColor(self.image, cv2.COLOR_BGR2GRAY)
            xywh = faceCascade.detectMultiScale(gray,scaleFactor=1.1,minNeighbors=5,minSize=(30, 30),flags = cv2.CASCADE_SCALE_IMAGE)
            self.bbox = xywh2bbox(xywh)
        else:
            self.printComment("error - face detection method " +str(self.fd_method)+ " not defined")

    # showFaceDetection()
    # inputs: image, bbox, show_fd
    # output: show image with bounding boxes
    def showFaceDetection(self):
        show_face_detection(self.image,self.bbox,self.show_fd)

    # loadModel()
    # input: fr_method
    # output: fr_model
    def loadModel(self):
        #if  self.fr_method == 4: # vgg2
            # self.fr_model = FaceNet(model='20180402-114759.pb')
        if  self.fr_method == 2: #FaceNet
            model_path = '/Users/domingomery/Python/keras-facenet/model/keras/facenet_keras.h5'
            self.fr_model = load_model(model_path)
        else:
            self.fr_model = 1

    # extractDecriptorImage()
    # inputs: image, fr_method, uninorm
    # outputs: decriptor of the image (only one descriptor)
    def extractDescriptorImage(self):
        if self.fr_method == 0: # dlib-original does not work always :(
            x    = face_recognition.face_encodings(self.image)[0]
        elif self.fr_method == 1:
            fl = None #dlib without face detection
            x0    = face_recognition.face_encodings(self.image,fl)
            if len(x0)==0:
                fl = [[0,len(self.image)-1,len(self.image[0])-1,0]]
                x = face_recognition.face_encodings(self.image,fl)[0]
            else:
                x = x0[0]
        elif self.fr_method == 2: #facenet
            image_size = 160
            img1 = im_prewhiten(self.image)
            img2 = resize(img1, (image_size, image_size), mode='reflect')
            img3 = img2.reshape(1,img2.shape[0],img2.shape[1],img2.shape[2])
            px = self.fr_model.predict_on_batch(img3[0:1,0:image_size,0:image_size,0:3])
            x = l2_normalize(px)
            x = x.reshape(x.shape[1])
        elif self.fr_method == 4: #vgg2
            # x = predict(self.image, method_name="FaceNet", model='20180402-114759.pb')
            x = modelvgg2.predict(self.image)
            # x = self.fr_model.predict(self.image)
        if self.uninorm == 1:
            self.descriptor = uninormalize(x)
        else:
            self.descriptor = x

    # extractDecriptorsBBoxes()
    # inputs: image, bbox, fr_method, uninorm
    # outputs: decriptors of the bounding boxes (one descriptor per bouning box)
    def extractDescriptorsBBoxes(self):
        n = len(self.bbox)
        X = [0] * n
        i = 0
        img_full = self.image
        for i in range(n):
            top, right, bottom, left = self.bbox[i]
            self.image = img_full[top:bottom, left:right]
            self.extractDescriptorImage()
            X[i] = self.descriptor
            i = i+1
        self.descriptors = X

    # extractDecriptorsImageList()
    # inputs: img_path, img_names, fd_method, fr_method, uninorm
    # outputs: descriptors and bounding boxes (bbox) of each image in the list given
    #          by img_path+img_names, in adition, the indices (ix) that give the
    #          number of the image
    def extractDescriptorsImageList(self):
        i = 0
        for img_name in self.img_names:
            self.printComment("extracting descriptors in image " + img_name+" ...")
            self.image = imread(self.img_path + img_name)
            if self.fd_method>=0:
                self.detectFaces()
                n = len(self.bbox)
                self.printComment(str(n) + " face(s) found in image " + img_name)
            else:
                # top, right, bottom, left
                self.bbox = [[0,len(self.image)-1,len(self.image[0])-1,0]]
                n = 1
            self.extractDescriptorsBBoxes()
            x = self.descriptors
            d = np.array(x)
            y = i*np.ones((n,1),dtype=int)
            if i==0:
                X    = d
                ix   = y
                bbox = np.array(self.bbox)
            else:
                X    = np.concatenate((X,d))
                ix   = np.concatenate((ix,y))
                bbox = np.concatenate((bbox,np.array(self.bbox)))
            i = i+1
        self.descriptors = X
        self.ix          = ix
        self.bbox        = bbox

    # getDescriptorsImageList()
    # input: see inputs for extractDescriptorsImageList
    #        full = 0, only descriptors are extracted
    #               1, descriptors, bbox and ix are extracted
    #        extract_desc = 0, the descriptors are loaded from npy files
    #                       1, the descriptors are computed
    # outputs: descriptors and bounding boxes (bbox) of each image in the list given
    #          by img_path+img_names, in adition, the indices (ix) that give the
    #          number of the image
    def getDescriptorsImageList(self):
        if self.full==0:
            if self.extract_desc == 1:
                self.extractDescriptorsImageList()
                if self.save_desc == 1:
                    self.saveDescriptors()
            else:
                self.loadDescriptors()
        else:
            if self.extract_desc == 1:
                self.extractDescriptorsImageList()
                if self.save_desc == 1:
                    self.saveDescriptors()
            else:
                self.loadDescriptors()


    # saveDescriptors()
    # input: img_path, fr_method
    #        full = 0, only descriptors are saved
    #               1, descriptors, bbox and ix are saved
    def saveDescriptors(self):
        st = self.img_path + fr_str[self.fr_method]
        if self.full == 1:
            self.comment = "saving descriptors, crops and indices in "+st+"..."
            bbox = self.bbox
            ix   = self.ix
            np.save(st+'_crop',bbox)
            np.save(st+'_ix',ix)
        else:
            self.printComment("saving descriptors in "+st+"...")
        X    = self.descriptors
        np.save(st+'_desc',X)

    # loadDescriptors()
    # input: img_path, fr_method
    #        full = 0, only descriptors are loaded
    #               1, descriptors, bbox and ix are loaded
    def loadDescriptors(self):
        st = self.img_path + fr_str[self.fr_method]
        if self.full == 1:
            self.comment = "loading descriptors, crops and indices from "+st+"..."
            bbox       = np.load(st+'_crop.npy')
            ix         = np.load(st+'_ix.npy')
            bbox       = bbox.astype(np.int)
            ix         = ix.astype(np.int)
            self.bbox  = bbox
            self.ix    = ix
        else:
            self.printComment("loading descriptors from "+st+"...")
        X      = np.load(st+'_desc.npy')
        self.descriptors = X


    # extractDescriptorsSession()
    # input: img_path, id_sessions, session_prefix,
    #        see inputs of getDescriptorsImageList()
    # output: compute and save all descriptors of session images
    def extractDescriptorsSession(self):
        self.save_desc    = 1  # save descriptors
        self.extract_desc = 1  # extract descriptors
        self.full         = 1
        m                 = len(self.id_sessions)
        img_path_sessions = self.img_path
        for j in range(m):
            id_session        = self.id_sessions[j]
            self.printComment("extracting descriptors for session "+str(id_session)+"...")
            session_str       = self.session_prefix + num2fixstr(id_session,2)
            img_path_session  = img_path_sessions + session_str + '/'
            img_names_session = dirfiles(img_path_session,'*.png')
            self.img_path     = img_path_session
            self.img_names    = img_names_session
            self.getDescriptorsImageList()

    # printComment()
    # input: echo, comment
    # output: print comment if echo = 1
    def printComment(self,comment):
        if self.echo == 1:
            print("[facer] : "+comment)

    # extractDescriptorsEnrollment()
    # input: img_path, id_subjects, see inputs of getDescriptorsImageList()
    # output: compute and save all descriptors of enrolled images
    def extractDescriptorsEnrollment(self):
        self.save_desc    =  1 # save descriptors
        self.extract_desc =  1 # extract descriptors
        self.getDescriptorsEnrollment()

    def getDescriptorsEnrollment(self):
        self.fd_method    = -1 # no face detection
        self.full         =  0
        m                 = len(self.id_subjects)
        img_path_enroll   = self.img_path
        for i in range(m):
            id_subject         = self.id_subjects[i]
            id_str             = num2fixstr(id_subject,6)
            img_path_enroll_id = img_path_enroll+id_str+'/'
            img_names_enroll   = dirfiles(img_path_enroll_id,'*.png')
            self.img_path      = img_path_enroll_id
            self.img_names     = img_names_enroll
            self.getDescriptorsImageList()
            x                  = self.descriptors
            d                  = np.array(x)
            n                  = d.shape[0]
            y                  = i*np.ones((n,1),dtype=int)
            if i==0:
                X    = d
                ix   = y
            else:
                X    = np.concatenate((X,d))
                ix   = np.concatenate((ix,y))
            i = i+1
        self.descriptorsE = X
        self.ixE          = ix
        self.img_path     = img_path_enroll



    # whoIsThis()
    # input: inputs for extractDescriptorImage() for query image
    #
    # output: print comment if echo = 1
    def whoIsThis(self,get_desc_enroll = 1):
        # query image: read, display and description
        self.get_desc_enroll = get_desc_enroll
        self.extractDescriptorImage()
        Y                 = self.descriptor # descriptor of query image

        self.save_desc    =  0  # save descriptors
        self.extract_desc =  0  # extract descriptors
        n                 = len(self.id_subjects)
        scores            = np.zeros((n,1))
        if self.get_desc_enroll == 1:
           self.getDescriptorsEnrollment()
        D  = self.descriptorsE
        ix = self.ixE
        for i in range(n):
            X         = extract_rows(D,ix,i)
            _,scr_best,_,_ = vector_distances(Y,X.T,self.sc_method,self.theta,self.print_scr)
            # scr,scr_best,ind_best,face_detected = vector_distances(Y,X.T,self.sc_method,self.theta,self.print_scr)
            scores[i] = scr_best

        id_best           = np.unravel_index(np.argmax(scores,axis=None),scores.shape)
        self.selected     = id_best[0]
        self.scr_selected = scores[self.selected]

    def reportAssistance(self):
        n                = len(self.id_subjects)
        m                = len(self.id_sessions)
        self.assistance  = self.scores>self.theta
        self.assist_mean = self.assistance.mean(1)*100
        self.assist_sum  = self.assistance.sum(1)
        self.printComment("assistance report in sessions "+str(self.id_sessions[0]) + "..." + str(self.id_sessions[m-1]))

        for i in range(n):
            id_subject = self.id_subjects[i]
            id_str     = num2fixstr(id_subject,3)
            id_name    = name_from_id(self.csv_list,id_subject)
            print("" +id_str+"  - "+' %35s' % id_name+"  : " +' %2d' % self.assist_sum[i]+"/"+str(m)+' = %6.2f%%' % self.assist_mean[i])



    # whoIsThis()
    # input: inputs for extractDescriptorImage() for query image
    #
    # output: print comment if echo = 1
    def whoIsThis_old(self):
        # query image: read, display and description
        self.extractDescriptorImage()
        Y                 = self.descriptor # descriptor of query image

        self.fd_method    = -1  # no face detection
        self.save_desc    =  0  # save descriptors
        self.extract_desc =  0  # extract descriptors
        self.full         =  0  # for enrollment extraction
        n                 = len(self.id_subjects)
        scores            = np.zeros((n,1))
        img_path_enroll   = self.img_path
        # get descriptors of enrolled faces and compute scores between them
        # and descriptors of query image
        for i in range(n):
            id_subject         = self.id_subjects[i]
            id_str             = num2fixstr(id_subject,6)
            img_path_enroll_id = img_path_enroll+id_str+'/'
            img_names_enroll   = dirfiles(img_path_enroll_id,'*.png')
            self.img_path      = img_path_enroll_id
            self.img_names     = img_names_enroll
            self.getDescriptorsImageList()
            X                  = self.descriptors
            _,scr_best,_,_ = vector_distances(Y,X.T,self.sc_method,self.theta,self.print_scr)
            # scr,scr_best,ind_best,face_detected = vector_distances(Y,X.T,self.sc_method,self.theta,self.print_scr)
            scores[i] = scr_best

        id_best    = np.unravel_index(np.argmax(scores,axis=None),scores.shape)
        self.selected          = id_best[0]
        self.scr_selected      = scores[self.selected]








####################################################


# IMAGE PROCESSING
def im_prewhiten(image):
    if image.ndim == 4:
        axis = (1, 2, 3)
        size = image[0].size
    elif image.ndim == 3:
        axis = (0, 1, 2)
        size = image.size
    else:
        raise ValueError('Dimension should be 3 or 4')
    mean = np.mean(image, axis=axis, keepdims=True)
    std = np.std(image, axis=axis, keepdims=True)
    std_adj = np.maximum(std, 1.0/np.sqrt(size))
    image_new = (image - mean) / std_adj
    return image_new

def im_resize(image,img_size):
    I = 255*resize(image,img_size, mode = 'reflect')
    image_new  = I.astype(np.uint8)
    return image_new

def im_concatenate(image_seq,image,img_size,horizontal):
    if len(image)==0:
        image = np.zeros((img_size[0],img_size[1],3),dtype=np.uint8)
    else:
        image  = im_resize(image,img_size)
    if len(image_seq)==0:
        image_seq = image
    else:
        image_seq = np.concatenate((image_seq,image),axis=horizontal)
    return image_seq

def im_crop(img_name,bbox,show_img):
    S  = imread(img_name)
    top, right, bottom, left = bbox
    image = S[top:bottom, left:right]
    imshowx(image,show_img)
    return image

# LINEAR ALGEBRA
def uninormalize(vector):
    norm=np.linalg.norm(vector)
    if norm==0:
        norm=np.finfo(vector.dtype).eps
    uninorm_vector = vector/norm
    return uninorm_vector

def l2_normalize(vector, axis=-1, epsilon=1e-10):
    l2_norm_vector = vector / np.sqrt(np.maximum(np.sum(np.square(vector), axis=axis, keepdims=True), epsilon))
    return l2_norm_vector

def vector_distances(D1,d2,distance_method,theta,print_distances):
    detection = 0
    if distance_method == 0: # cosine similarity
        distances     = np.matmul(D1,d2)
        ind_best      = np.unravel_index(np.argmax(distances,axis=None),distances.shape)
        distance_best = distances.max()
        if distance_best>theta:
            detection = 1
    elif distance_method == 1: # euclidean distance
        d2        = d2.reshape(1,d2.shape[0])
        distances = euclidean_distances(D1,d2)
        ind_best  = np.unravel_index(np.argmin(distances,axis=None),distances.shape)
        # scr_best  = distances.min()
        if distance_best<theta:
            detection = 1
    if print_distances==1:
        print("distances:----- ")
        print(distances)
    return distances,distance_best,ind_best,detection

def find_equal2(x,i):
    ii = np.nonzero(x==i)
    return ii[0]

def extract_rows(D,ix,i):
    ii        = find_equal2(ix,i)
    X         = D[ii,:]
    return X


# OS
def num2fixstr(x,d):
    st = '%0*d' % (d,x)
    return st

def dirfiles(img_path,img_ext):
    img_names = fnmatch.filter(sorted(os.listdir(img_path)),img_ext)
    return img_names

def imread(filename):
    image = face_recognition.load_image_file(filename)
    # image = cv2.imread(filename)
    return image

def imreadx(filename,show_img):
    image = imread(filename)
    imshowx(image,show_img)
    return image

def imshow(image):
    pil_image = Image.fromarray(image)
    pil_image.show()

def imshowx(image,show_img):
    if show_img == 1:
        pil_image = Image.fromarray(image)
        pil_image.show()

def show_crop(image,bbox,show_img):
    top, right, bottom, left = bbox
    img_crop = image[top:bottom, left:right]
    imshowx(img_crop,show_img)
    #cv2.rectangle(image,(left,top),(right,bottom),(255,0,0),6)
    #imshowx(image,show_img)

def show_face_detection(image,bbox,show_fd):
    if show_fd == 1:
        font = cv2.FONT_HERSHEY_DUPLEX
        x = np.array(bbox)
        n = int(x.size/4)
        I = deepcopy(image) # I=image copy a reference of image, not the array
        if n>1:
            for i in range(n):
                top, right, bottom, left = bbox[i]
                cv2.rectangle(I,(left,top),(right,bottom),(0,0,255),6)
                cv2.putText(I,num2fixstr(i,3),(left+6,bottom-5), font, 0.7, (255,255,255),1)
        elif n==1:
            top, right, bottom, left = bbox
            cv2.rectangle(I,(left,top),(right,bottom),(0,0,255),6)
            # cv2.putText(I,num2fixstr(0,3),(left+6,bottom-5), font, 1, (255,255,255),1)
        imshow(I)

def name_from_id(csv_file,id):
    df = read_csv(csv_file)
    ids = df['ID']
    n = len(ids)
    id_name = 'not found'
    for i in range(n):
        if ids[i] == id:
            id_name = df['FIRST_NAME'][i]+" "+df['LAST_NAME'][i]
            break
    return id_name

def xywh2bbox(xywz):
    x=xywz[:,0];y=xywz[:,1];w=xywz[:,2];h=xywz[:,3]
    t = deepcopy(xywz)
    t[:,0] = y
    t[:,1] = x+w
    t[:,2] = y+h
    t[:,3] = x
    bbox = t.astype(np.int)
    return bbox
