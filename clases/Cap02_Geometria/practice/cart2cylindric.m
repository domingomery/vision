% see cylindric_transform.png in this directory

X = imread('pano_01.jpg');
figure(1); imshow(X); title('original image');
[N,M] = size(X);
Y = zeros(N,M*2);

My = size(Y,2);

r = 800;
f = 1200;

for i=1:N
    ip = round(i);
    if and(ip>=1,ip<=N)
        for j=1:My
            jp = j-My/2;
            theta = atan(jp/f);
            jp = round(r*theta+M/2);
            if and(jp>=1,jp<=M)
                Y(i,j) = X(ip,jp);
            end
        end
    end
end

figure(2); imshow(uint8(Y)); title('transformed image');
    
    
    
    
    
    
    
    
