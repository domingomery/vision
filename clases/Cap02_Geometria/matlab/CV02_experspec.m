function CV02_experspec(tx,ty,tz,wx,wy,wz)
% Defintions
% axis
axp = [1 0 0 0 0
       0 0 1 0 0
       0 0 0 0 1
       1 1 1 1 1];

% mesh points
load meshpoints
Mp = [Mp'; ones(1,size(Mp,1))]; % homogeneus coordinates
n = size(Mp,2);
      

% Object Coordinate System
figure(1);clf
subplot(2,2,1); hold off
CV02_meshplot(Mp(1:3,:)',T,'b')
title('Object Coordinate System (Xp,Yp,Zp)');
hold on
plot3(axp(1,:),axp(2,:),axp(3,:),'r')
text(axp(1,1),axp(2,1),axp(3,1),'Xp');
text(axp(1,3),axp(2,3),axp(3,3),'Yp');
text(axp(1,5),axp(2,5),axp(3,5),'Zp');
view(136,36)
axis equal


% World Coordinate System
%figure(2); clf
subplot(2,2,2); hold off
%tx = 1; ty = -1; tz = 2;
t = [tx ty tz]';

%wx = 0; wy = 0; wz = 0;
R = Bmv_matrixr3d(wx,wy,wz);

H = [R t;0 0 0 1];
M = H*Mp;
ax = H*axp;
CV02_meshplot(M(1:3,:)',T,'b')
hold on
title('Word Coordinate System (X,Y,Z)');
plot3(ax(1,:),ax(2,:),ax(3,:),'r')
text(ax(1,1),ax(2,1),ax(3,1),'Xp');
text(ax(1,3),ax(2,3),ax(3,3),'Yp');
text(ax(1,5),ax(2,5),ax(3,5),'Zp');
dX = 3; dY=3; dZ=5; f = 5;
plot3(dX*axp(1,:),dY*axp(2,:),dZ*axp(3,:),'g')
text(dX*axp(1,1),dX*axp(2,1),dX*axp(3,1),'X');
text(dY*axp(1,3),dY*axp(2,3),dY*axp(3,3),'Y');
text(dZ*axp(1,5),dZ*axp(2,5),dZ*axp(3,5),'Z');
plot3(0,0,0,'r*')
text(0,0,0,'C');
Mr = [-dX -dX  dX  dX -dX
      -dY  dY  dY -dY -dY
        f   f   f  f   f
        1   1   1  1   1];
    
plot3(Mr(1,:),Mr(2,:),Mr(3,:))
axr = [dX/2 0  0
       0    0 dY/2
       f    f  f
       1    1  1];
plot3(axr(1,:),axr(2,:),axr(3,:))
text(axr(1,1),axr(2,1),axr(3,1),'x');
text(axr(1,3),axr(2,3),axr(3,3),'y');



view(-38,26)
axis equal




% Projection Coordinate System
%figure(3); clf
subplot(2,2,3); hold off
P = [f 0 0 0 ; 0 f 0 0 ; 0 0 1 0];
%ms = [-dX/2  -dX/2  dX/2  dX/2 -dX/2
%      -dY/2   dY/2  dY/2 -dY/2 -dY/2
%        1      1      1     1     1 ];

m = P*M;
m = m./(ones(3,1)*m(3,:));
CV02_meshplot(m(1:2,:)',T,'r')
hold on
title('Projection Coordinate System (x,y)');
xlabel('x');
ylabel('y');
axis([-dX dX -dY dY]);
subplot(2,2,2);
Mf = [m(1:2,:); f*ones(1,n); ones(1,n)];
CV02_meshplot(Mf(1:3,:)',T,'r')




% Image Coordinate System
%figure(4); clf
subplot(2,2,4); hold off
alfax = 30;
alfay = 30;
s     = 4;
u0    = 200;
v0    = 200; 
K = [alfax*f s*f     u0
       0   alfay*f   v0
       0     0        1];
w = K*m;
%axi = K*ms;

axi = [  1    1 512 512   1
        1  512 512   1   1
        1    1   1   1   1];
ms = inv(K)*axi;    



%plotmalla(w(1:2,:)',T,'g')
%axis([min(axi(1,:)) max(axi(1,:)) min(axi(2,:)) max(axi(2,:)) ]);
subplot(2,2,3)
plot(ms(1,:),ms(2,:),'k:')

I = zeros(512,512);
for i=1:n
    u = fix(w(1,i)+0.5);
    v = fix(w(2,i)+0.5);
    if (u>1)&&(u<512)&&(v>1)&&(v<512)
    I(v-1:v+1,u-1:u+1) = 1;
    end
end
subplot(2,2,4)
imshow(I)
title('Image Coordinate System (u,v)');
xlabel('u');
ylabel('v');
axis on
