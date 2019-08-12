% Example:
%
% SIFT: keypoints detection using DoG at different
%       scales.
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl

close all


Ia = double(rgb2gray(imread('../images/GreatWall_a.jpg')));
I = Ia(1:2:end,1:2:end);
% test with k=1.4 and s=3 to detect large windows
%                     s=1.1 to detect small windows

% DoG
I = I/max2(I);
figure(1)
imshow(I,[])
title('Image I');
xlabel('x');
ylabel('y');
while(1)
    disp('D(x,y,s)=(G(x,y,ks)-G(x,y,s)*I(x,y)')
    k = sqrt(2);
    s = input('sigma = ? ');
    
    % scale sigma/k
    
    J1 = CV01_SIFT_DoG_Function(I,s/k,s,0);
    J2 = CV01_SIFT_DoG_Function(I,s,s*k,0);
    J3 = CV01_SIFT_DoG_Function(I,s*k,s*k*k,0);
    figure(2);imshow(abs([J1 J2 J3]),[]);drawnow
    
    %figure(1); imshow(abs(J1),[]); title('DoG: s/k ... s')
    %figure(2); imshow(abs(J2),[]); title('DoG: s ... s*k')
    %figure(3); imshow(abs(J3),[]); title('DoG: s*k ... s*k*k')
    
    [N,M] = size(J2);
    Y = zeros(N,M);
    for i=10:N-11
        for j=10:M-11
            T1 = J1(i-1:i+1,j-1:j+1);
            T2 = J2(i-1:i+1,j-1:j+1);
            T3 = J3(i-1:i+1,j-1:j+1);
            t = [T1(:)' T2(:)' T3(:)'];
            t0 = J2(i,j); % central point
            if and(or(t0==max(t),t0==min(t)),abs(t0)>0.05)
                Y(i,j)=1;
            end
        end
    end
    figure(3)
    imshow(I,[])
    hold on
    [ii,jj]=find(Y==1);
    %plot(jj,ii,'rx');
    %plot(jj,ii,'ro');
    n = length(jj);
    r = 4*s;
    m = 16;
    x = r*sin(2*pi/m*(0:m))';
    y = r*cos(2*pi/m*(0:m))';
    for i=1:n
        x0 = jj(i)*ones(m+1,1);
        y0 = ii(i)*ones(m+1,1);
        plot(x0+x,y0+y,'r')
    end
end
