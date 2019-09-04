clt
fpathc = 'catddog/training_set/cats/';
fpathd = 'catddog/training_set/dogs/';
dc = dir([fpathc '*.jpg']);
dd = dir([fpathd '*.jpg']);
nc = length(dc);
nd = length(dd);

% TRAINING

% cats
CC = zeros(nc,1,32,32,'uint8');
ft = Bio_statusbar('training cats');
for i=1:nc
    ft = Bio_statusbar(i/nc,ft);
    I = imread([fpathc dc(i).name]);
    I = imresize(rgb2gray(I),[32 32]);
    CC(i  ,1,:,:) = uint8(I);
end
delete(ft);
Yc = zeros(nc,1);

% dogs
DD = zeros(nd,1,32,32,'uint8');
ft = Bio_statusbar('training dogs');
for i=1:nd
    ft = Bio_statusbar(i/nd,ft);
    I = imread([fpathd dd(i).name]);
    I = imresize(rgb2gray(I),[32 32]);
    DD(i  ,1,:,:) = uint8(I);
end
delete(ft);

Yd = ones(nd,1);



% construction of balanced dataset
n = min([nd nc]);
X_train = uint8([CC(1:n  ,1,:,:); DD(1:n  ,1,:,:)  ]); Y_train = uint8([Yc(1:n  ,1,:); Yd(1:n,:)  ]);

% TESTING

fpathc = 'test_set/cats/';
fpathd = 'test_set/dogs/';
dc = dir([fpathc '*.jpg']);
dd = dir([fpathd '*.jpg']);
nc = length(dc);
nd = length(dd);


% cats
CC = zeros(nc,1,32,32,'uint8');
ft = Bio_statusbar('testing cats');
for i=1:nc
    ft = Bio_statusbar(i/nc,ft);
    I = imread([fpathc dc(i).name]);
    I = imresize(rgb2gray(I),[32 32]);
    CC(i  ,1,:,:) = uint8(I);
end
delete(ft);
Yc = zeros(nc,1);

% dogs
DD = zeros(nd,1,32,32,'uint8');
ft = Bio_statusbar('testing dogs');
for i=1:nd
    ft = Bio_statusbar(i/nd,ft);
    I = imread([fpathd dd(i).name]);
    I = imresize(rgb2gray(I),[32 32]);
    DD(i  ,1,:,:) = uint8(I);
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

