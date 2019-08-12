% Example:
%
% 3D distance using stereo vision and 3D reconstruction
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl


load projmatrices % this .mat file is in matlab/data

A = P1;
B = P3;


F = Bmv_fundamental(A,B);

I1 = imread('../images/view_1.jpg'); % this .jpg file is in matlab/images
I2 = imread('../images/view_3.jpg'); % this .jpg file is in matlab/images
figure(1);imshow(I1);hold on
figure(2);imshow(I2);hold on

D = 1500;
M = [D 0 0 0 0  
     0 0 D 0 0
     0 0 0 0 D 
     1 1 1 1 1];

m1 = h2i(A*M); figure(1);plot(m1(1,:),m1(2,:),'m');
text(m1(1,1),m1(2,1),'X');
text(m1(1,3),m1(2,3),'m');
text(m1(1,5),m1(2,5),'Z');

m2 = h2i(B*M); figure(2);plot(m2(1,:),m2(2,:),'m');
text(m2(1,1),m2(2,1),'X');
text(m2(1,3),m2(2,3),'m');
text(m2(1,5),m2(2,5),'Z');

[N,M] = size(I2);
x = [1 M]';

while(1)
    figure(1);
    disp('click first point in Figure 1...') % click
    p = vl_click; 
    m1 = [p(1) p(2) 1]';
    mm1 = m1;
    plot(p(1),p(2),'g+')
    figure(2)
    disp('click first point in Figure 2...') % click
    p = vl_click; 
    m2 = [p(1) p(2) 1]';
    mm2 = m2;
    plot(p(1),p(2),'g+')

    M1 = Bmv_reco3dn([m1 m2],[A;B]);

    figure(1);
    disp('click second point in Figure 1...') % click
    p = vl_click; 
    m1 = [p(1) p(2) 1]';
    plot(p(1),p(2),'r+')
    plot([mm1(1) m1(1)],[mm1(2) m1(2)],'m')
    figure(2)
    disp('click second point in Figure 2...') % click
    p = vl_click; 
    m2 = [p(1) p(2) 1]';
    plot(p(1),p(2),'r+')
    plot([mm2(1) m2(1)],[mm2(2) m2(2)],'m')

    M2 = Bmv_reco3dn([m1 m2],[A;B]);
    
    d12 = norm(M1-M2);
    
    fprintf('d12 = %5.2f [cm]\n',d12/10);
    
    
end
