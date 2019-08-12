% Example:
%
% 3D representation of a Pyramid.
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl

clt
p1 = [0 0 0 1]';
p2 = [2 0 0 1]';
p3 = [2 2 0 1]';
p4 = [0 2 0 1]';
p5 = [1 1 2 1]';
figure
P = [p1 p2 p3 p4 p5];
plot3(P(1,:),P(2,:),P(3,:),'rx')
axis([-4 4 -4 4 -4 4])
xlabel('X'); ylabel('Y'); zlabel('Z');



figure
s = [1 2 5 1 4 5 3 2 3 4];
M = P(:,s);

if 1

t = [0 0 0]'; w = [0 0 0]';    
CV02_PlotMesh3D(M,t,w);
enterpause

t = [1 2 3]'; w = [0 0 0]';    
CV02_PlotMesh3D(M,t,w);
enterpause

t = [0 0 0]'; w = [pi/2 0 0]'; 
CV02_PlotMesh3D(M,t,w);
enterpause

t = [0 0 2]'; w = [pi   0 0]';     
CV02_PlotMesh3D(M,t,w);
enterpause

t = [2 2 0]'; w = [0 pi/4 -pi/8]'; 
CV02_PlotMesh3D(M,t,w);
enterpause

end

t = [0 0 0]'; w = [0 0 0]';    
for wx = 0:pi/36:2*pi
    w(1) = wx;
    CV02_PlotMesh3D(M,t,w);
    drawnow
end

for wy = 0:pi/36:2*pi
    w(2) = wy;
    CV02_PlotMesh3D(M,t,w);
    drawnow
end

for wz = 0:pi/36:2*pi
    w(3) = wz;
    CV02_PlotMesh3D(M,t,w);
    drawnow
end

N = 200;
for i = 0:N
    tx  = i/N;
    ty = -i/N;
    tz  = 2*i/N;
    wx  = i/N*2*pi; 
    wy  = i/N*2*pi; 
    wz  = i/N*2*pi; 
    t = [tx ty tz]';
    w = [wx wy wz]';
    CV02_PlotMesh3D(M,t,w);
    drawnow
end



