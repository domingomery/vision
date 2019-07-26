% Example:
%
% Estimation of Fundamental Matrix using a stereo calibrated system
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl


load projmatrices % this .mat file is in matlab/data

A = P1;
B = P2;


F = Bmv_fundamental(A,B);

I1 = imread('../images/view_1.jpg'); % this .jpg file is in matlab/images
I2 = imread('../images/view_2.jpg'); % this .jpg file is in matlab/images
figure(1);imshow(I1);hold on
figure(2);imshow(I2);hold on

D = 1500;
M = [D 0 0 0 0  
     0 0 D 0 0
     0 0 0 0 D 
     1 1 1 1 1];

m1 = h2i(A*M); figure(1);plot(m1(1,:),m1(2,:),'y');
text(m1(1,1),m1(2,1),'X');
text(m1(1,3),m1(2,3),'Y');
text(m1(1,5),m1(2,5),'Z');

m2 = h2i(B*M); figure(2);plot(m2(1,:),m2(2,:),'y');
text(m2(1,1),m2(2,1),'X');
text(m2(1,3),m2(2,3),'Y');
text(m2(1,5),m2(2,5),'Z');

[N,M] = size(I2);
x = [1 M]';

while(1)
    figure(1);
    disp('click a point in Figure 1...') % click
    p = vl_click; m1 = [p(1) p(2) 1]';
    plot(p(1),p(2),'g+')
    figure(2)
    ell = F*m1;
    a = ell(1); b = ell(2); c = ell(3);
    y = -(a*x+c)/b;
    plot(x,y)
end
