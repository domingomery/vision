I1 = rgb2gray(imread('../images/image1.jpg'));
I1 = imresize(I1,0.3);
I1 = Bim_lin(I1);
figure(6);imshow(I1,[]);title('Left image')

I2 = rgb2gray(imread('../images/image2.jpg'));
I2 = imresize(I2,0.3);
I2 = Bim_lin(I2);
figure(7);imshow(I2,[]);title('Right image')


disp('Computing matching points...')
[f1n,~,f2n,~,scores] = Bmv_matchSIFT(I1,I2,1,1);
enterpause

ii = scores<3000;

f1 = f1n(:,ii);
f2 = f2n(:,ii);


n = size(f1,2);
m1 = [f1([2 1],:);ones(1,n)];
m2 = [f2([2 1],:);ones(1,n)];

disp('Computing homography using RANSAC...')
H = Bmv_homographyRANSAC(m1,m2);


disp('Computing transformed image...')
I2s = Bmv_projective2D(I2,H,size(I1),1);
figure(4);imshow(I2s,[]);title('Transformed image (Right to Left)')

I3 = (double(I2s)+double(I1))/2;
figure(5);imshow(I3,[]);title('Left image + Transformed image')

% see also Bmv_homographySIFT(I1,I2,1);


