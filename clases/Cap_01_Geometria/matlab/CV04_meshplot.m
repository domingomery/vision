% X tiene los puntos 3D (o 2D) del solido
% T contiene los indices de un triangulo por fila
% D.Mery, PUC-DCC, Septiembre 2008
function CV04_meshplot(X,T,c)
p = [];
for i=1:size(T,1);
    p = [p; X(T(i,:)+1,:)];
end
if (size(X,2)==3)
    plot3(p(:,1),p(:,2),p(:,3),c);
else
    plot(p(:,1),p(:,2),c);
end

