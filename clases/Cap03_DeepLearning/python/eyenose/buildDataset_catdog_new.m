% dataset can be downloaded from
% https://www.dropbox.com/sh/5ovb01dw0z2gd3g/AABqt0R3PB4hIaVevThDJHfJa?dl=0

clt
fpathc = 'catdog_images/training_set/cats/';
fpathd = 'catdog_images/training_set/dogs/';
dc = dir([fpathc '*.jpg']);
dd = dir([fpathd '*.jpg']);
nc = length(dc);
nd = length(dd);


N = input('Output resolution? (eg 64)');
C = input('Channels? (eg 1 for grayscale, 3 for RGB)');

% TRAINING

% cats



CC = zeros(nc,C,N,N,'uint8');
ft = Bio_statusbar('training cats');
for i=1:nc
    ft = Bio_statusbar(i/nc,ft);
    I = imread([fpathc dc(i).name]);
    if C == 1
        I = uint8(imresize(rgb2gray(I),[N N]));
        CC(i  ,1,:,:) = I;
    else
        I = uint8(imresize(I,[N N]));
        CC(i  ,1,:,:) = I(:,:,1);
        CC(i  ,2,:,:) = I(:,:,2);
        CC(i  ,3,:,:) = I(:,:,3);
    end
end
delete(ft);
Yc = zeros(nc,1);

% dogs
DD = zeros(nd,C,N,N,'uint8');
ft = Bio_statusbar('training dogs');
for i=1:nd
    ft = Bio_statusbar(i/nd,ft);
    I = imread([fpathd dd(i).name]);
    if C == 1
        I = uint8(imresize(rgb2gray(I),[N N]));
        DD(i  ,1,:,:) = I;
    else
        I = uint8(imresize(I,[N N]));
        DD(i  ,1,:,:) = I(:,:,1);
        DD(i  ,2,:,:) = I(:,:,2);
        DD(i  ,3,:,:) = I(:,:,3);
    end
end
delete(ft);

Yd = ones(nd,1);



% construction of balanced dataset
n = min([nd nc]);
X_train = uint8([CC(1:n  ,:,:,:); DD(1:n  ,:,:,:)  ]); Y_train = uint8([Yc(1:n  ,1,:); Yd(1:n,:)  ]);

% TESTING

fpathc = 'catdog_images/test_set/cats/';
fpathd = 'catdog_images/test_set/dogs/';
dc = dir([fpathc '*.jpg']);
dd = dir([fpathd '*.jpg']);
nc = length(dc);
nd = length(dd);


% cats
CC = zeros(nc,C,N,N,'uint8');
ft = Bio_statusbar('testing cats');
for i=1:nc
    ft = Bio_statusbar(i/nc,ft);
    I = imread([fpathc dc(i).name]);
    if C == 1
        I = uint8(imresize(rgb2gray(I),[N N]));
        CC(i  ,1,:,:) = I;
    else
        I = uint8(imresize(I,[N N]));
        CC(i  ,1,:,:) = I(:,:,1);
        CC(i  ,2,:,:) = I(:,:,2);
        CC(i  ,3,:,:) = I(:,:,3);
    end
end
delete(ft);
Yc = zeros(nc,1);

% dogs
DD = zeros(nd,C,N,N,'uint8');
ft = Bio_statusbar('testing dogs');
for i=1:nd
    ft = Bio_statusbar(i/nd,ft);
    I = imread([fpathd dd(i).name]);
    if C == 1
        I = uint8(imresize(rgb2gray(I),[N N]));
        DD(i  ,1,:,:) = I;
    else
        I = uint8(imresize(I,[N N]));
        DD(i  ,1,:,:) = I(:,:,1);
        DD(i  ,2,:,:) = I(:,:,2);
        DD(i  ,3,:,:) = I(:,:,3);
    end
end
delete(ft);

Yd = ones(nd,1);



% construction of dataset
n = min([nd nc]);
%X_test = uint8([CC(1:n  ,1,:,:); DD(1:n  ,1,:,:)  ]); Y_test = uint8([Yc(1:n  ,1,:); Yd(1:n,:)  ]);
X_test = uint8([CC; DD ]); Y_test = uint8([Yc; Yd ]);
fprintf('Dataset with %d cats and %d dogs\n',n,n);
disp('saving catdog.mat...');
save catdog X_train Y_train X_test Y_test

