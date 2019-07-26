% Example:
%
% Ping Pong in calibrated chess. This code should be executed after a
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
x = [];
y = [];
cc = squareSize;
Xmax = input('#squares in X direction?');
Ymax = input('#squares in Y direction?');
Xmin = 0; Ymin = 0;
MM = [0       0   Xmax*cc  Xmax*cc    0
    Ymax*cc 0   0        Ymax*cc    Ymax*cc
    0       0   0        0          0
    1       1   1        1          1];
me = h2i(P*MM);



for i=1:1000
    figure(3)
    clf
    imshow(I,[]);
    hold on
    plot(me(1,:),me(2,:),'m')
    text(me(1,1),me(2,1),'Y')
    text(me(1,3),me(2,3),'X')
    text(me(1,2),me(2,2),'O')
    %Z = -abs(2*sin(i*2/pi*dd));
    Z = 0;
    m = h2i(P*[cc*X cc*Y cc*Z 1]');
    x = [x m(1)];
    y = [y m(2)];
    if i<=50
        plot(x,y,'r')
    else
        plot(x(end-50:end),y(end-50:end),'r')
    end
    plot(m(1),m(2),'go')
    Xn = X+dx;
    if or(Xn<=Xmin,Xn>=Xmax)
        dx=-dx;
        Xn = X+dx;
    end
    Yn = Y+dy;
    if or(Yn<=Ymin,Yn>=Ymax)
        dy=-dy;
        Yn = Y+dy;
    end
    X = Xn; Y = Yn;
    drawnow
end

