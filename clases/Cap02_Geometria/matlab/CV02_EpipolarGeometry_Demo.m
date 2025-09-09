clf

q   = 1.5; % LineWidth
m   = 10;  % Puntos 3D en cada rayo
z   = 20;  % altura adicional en el eje Z para poner el texto
f   = 18;  % FontSize
col = 'rgbcmyk';

T = [
    100   700   100
    600   700   100
    600   700   600
    100   700   600
    700   100   100
    700   600   100
    700   600   600
    700   100   600
    350    0   0
    350   700   350
      0   350   0
    700   350   350
    ];

L = [ 
     1  2  1 
     2  3  1 
     3  4  1 
     4  1  1 
     5  6  3
     6  7  3
     7  8  3
     8  5  3
     9  0  1
    10  0  1
     9 10  1
    11  0  3
    12  0  3
    11 12  3
    ];


n = size(L,1);






for i = 1:n
    c  = col(L(i,3));
    M1 = T(L(i,1),:);
    if L(i,2) > 0
        M2 = T(L(i,2),:);
        plot3([M1(1) M2(1)],[M1(2) M2(2)],[M1(3) M2(3)],c,'linewidth',q)
    else
        plot3(M1(1),M1(2),M1(3),[c '*'])
    end
    hold on
end



% VISTA 1
H1 = [0 0 1 0; 1 0 0 -350; 0 1 0 0; 0 0 0 1];
P1 = [700 0 0 0; 0 700 0 0; 0 0 1 0];
K1 = [1 0 0 ; 0 1 350; 0 0 1];
A  = K1*P1*H1;

for j=1:m
    M = [350,700*j/m,350*j/m,1]';
    plot3(M(1),M(2),M(3),'r*')
    w = A*M;
    u1 = w(1)/w(3);
    v1 = w(2)/w(3);
    plot3(v1,700,u1,'mo')
    disp([u1,v1])
end

% VISTA 2
H2 = [0 1 0 -350;0 0 1 0; 1 0 0 0; 0 0 0 1];
P2 = [700 0 0 0; 0 700 0 0; 0 0 1 0];
K2 = [1 0 350;0 1 0; 0 0 1];
B  = K2*P2*H2;

for j=1:m
    M = [700*j/m,350,350*j/m,1]';
    plot3(M(1),M(2),M(3),'b*')
    w = B*M;
    u2 = w(1)/w(3);
    v2 = w(2)/w(3);
    plot3(700,u2,v2,'mo')
    disp([u2,v2])
end

% LINEA EPIPOLAR
ini = 1;
for j=3:m-3
    M = [350,700*j/m,350*j/m,1]';
    plot3(M(1),M(2),M(3),'r*')
    w = B*M;
    u2 = w(1)/w(3);
    v2 = w(2)/w(3);
    plot3([0 700],[350 u2],[0 v2],'m:','LineWidth',q)
    disp([u2,v2])
    if ini==1
        Mini = [700,u2,v2];
        ini = 0;
    end
end
Mend = [700,u2,v2];
plot3([Mini(1) Mend(1)],[Mini(2) Mend(2)],[Mini(3) Mend(3)],'g','LineWidth',q)
text(350,0,0+z,'${\bf C}_1$','Interpreter', 'latex','FontSize',f)
text(0,350,0+z,'${\bf C}_2$','Interpreter', 'latex','FontSize',f)
text(350,700,350+z,'${\bf m}_1$','Interpreter', 'latex','FontSize',f)
text(700,350,350+z,'${\bf m}_2$','Interpreter', 'latex','FontSize',f)
text(700,u2,v2+z,'$\ell$','Interpreter', 'latex','FontSize',f)




axis([0 700 0 700 0 700])
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on
%axis off
setw
