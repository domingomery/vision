% Example:
%
% Gauss bell on calibrated chess. This code should be executed after a
% calibration process usin Computer Vision Toolbox (see for example
% CV01_Calibration.m that uses chess images of ../images/calib_example)
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl

i = input('image? ');
I = imread(imageFileNames{i});


params = cameraParams;
R = params.RotationMatrices(:,:,i);
t = params.TranslationVectors(i,:);
P =  cameraMatrix(params, R, t)';

dd = 0.1;
X = 0; Y = 2; dx = dd; dy = dd;
cc = squareSize;
Xmax = 10;
%Xmax = input('#squares in X direction?');
Ymax = Xmax;
k = 5;

for t=0:0.2:10
    
    HH = fspecial('gaussian',k*Xmax,k*1.5);
    H = -HH/max2(HH)*t;
    
    Xmin = 0; Ymin = 0;
    MM = [0       0   Xmax*cc  Xmax*cc    0
        Ymax*cc 0   0        Ymax*cc    Ymax*cc
        0       0   0        0          0
        1       1   1        1          1];
    me = h2i(P*MM);
    
    
    figure(3)
    clf
    imshow(I,[]);
    hold on
    plot(me(1,:),me(2,:),'m')
    text(me(1,1),me(2,1),'Y')
    text(me(1,3),me(2,3),'X')
    text(me(1,2),me(2,2),'O')
    for X=0:k*Xmax
        x = [];
        y = [];
        for Y=0:k*Xmax
            if or(X==0,Y==0)
                Z = 0;
            else
                Z = H(X,Y);
            end
            m = h2i(P*[cc*X/k cc*Y/k cc*Z 1]');
            x = [x m(1)];
            y = [y m(2)];
        end
        plot(x,y,'r')
    end
    
    for Y=0:k*Xmax
        x = [];
        y = [];
        for X=0:k*Xmax
            if or(X==0,Y==0)
                Z = 0;
            else
                Z = H(X,Y);
            end
            m = h2i(P*[cc*X/k cc*Y/k cc*Z 1]');
            x = [x m(1)];
            y = [y m(2)];
        end
        plot(x,y,'r')
    end
    drawnow
end
