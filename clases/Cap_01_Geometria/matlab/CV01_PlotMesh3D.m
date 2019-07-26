% Example:
%
% Plot in 3D of a set of 3D points given by M that are transformed
% by an Euclidean H matrix = [ R t; 0 0 0 1]. R is the rotation matrix
% computed using rotation angles w(1), w(2), w(3); and t is the 
% 3D translation. 
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl

function CV01_PlotMesh3D(M,t,w)

R = Bmv_matrixr3d(w(1),w(2),w(3));
H = [R t; 0 0 0 1]; Mp = H*M;
plot3(Mp(1,:),Mp(2,:),Mp(3,:))
axis([-1 1 -1 1 -1 1]*5)
xlabel('X'); ylabel('Y'); zlabel('Z');
fprintf('t = (%5.2f,%5.2f,%5.2f) w = (%5.2f,%5.2f,%5.2f)\n',t,w)
