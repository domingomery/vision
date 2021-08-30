xa = [70,350,90,385];
ya = [110,20,500,535];
yb = [50,50,500,500];
xb = [50,375,50,375];


np = 4;
A = zeros(2*np,9);

for i=1:np
    j = i*2-1;
    A(j:j+1,:) = [xa(i) ya(i) 1 0 0 0 -xa(i)*xb(i) -ya(i)*xb(i) -xb(i); 0 0 0 xa(i) ya(i) 1 -xa(i)*yb(i) -ya(i)*yb(i) -yb(i)];
end

[U,S,V] = svd(A); %#ok<ASGLU>
h = V(:,end);
H =[h(1) h(2) h(3); h(4) h(5)  h(6);h(7) h(8) h(9)];
