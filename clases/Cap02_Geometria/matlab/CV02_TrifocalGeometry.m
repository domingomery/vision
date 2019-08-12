% Example:
%
% Trifocal imaging using fundamental matrices
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl


load projmatrices % this .mat file is in matlab/data

A = P1;
B = P2;
C = P3;


F13 = Bmv_fundamental(A,C);
F23 = Bmv_fundamental(B,C);

I1 = imread('../images/view_1.jpg'); % this .jpg file is in matlab/images
I2 = imread('../images/view_2.jpg'); % this .jpg file is in matlab/images
I3 = imread('../images/view_3.jpg'); % this .jpg file is in matlab/images
figure(1);imshow(I1);hold on
figure(2);imshow(I2);hold on
figure(3);imshow(I3);hold on


[N,M] = size(I2);
x = [1 M]';

while(1)
    figure(1);
    disp('click a point in Figure 1...') % click
    p = vl_click; m1 = [p(1) p(2) 1]';
    plot(p(1),p(2),'g+')
    figure(3)
    ell_13 = F13*m1;
    a = ell_13(1); b = ell_13(2); c = ell_13(3);
    y = -(a*x+c)/b;
    plot(x,y)

    figure(2);
    disp('click corresponding point in Figure 2...') % click
    p = vl_click; m2 = [p(1) p(2) 1]';
    plot(p(1),p(2),'g+')
    figure(3)
    ell_23 = F23*m2;
    a = ell_23(1); b = ell_23(2); c = ell_23(3);
    y = -(a*x+c)/b;
    plot(x,y)

    m3 = cross(ell_13,ell_23);
    
    x3 = m3(1)/m3(3);
    y3 = m3(2)/m3(3);
    
    plot(x3,y3,'ro')
    plot(x3,y3,'r*')

end
