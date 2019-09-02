% function J = projective2D(I,H,SJ,show)
%
% Toolbox Vision
%
% PROJECTIVE2D 2D proyective transformation.
%
% J = projective2D(I,H,SJ,show) returns a new image J that is computed
%    from the 2D projective transformation H of I.
%
%   SJ is [NJ MJ] the size of the transformed image J. The
%   default of SJ is [NJ,MJ] = size(I).
%
%   show = 1 displays images I and J.
%
%   The coordinates of I are (xp,yp) (from x',y'), and the 
%   coordinates of J are (x,y). The relation between both
%   coordinate systems is: mp = H*m, where mp = [xp yp 1]'
%   and m = [x y 1]'.

function J = projective2D(I,H,SJ,show)

I = double(I);

[NI,MI] = size(I);

if ~exist('SJ')
    [NJ,MJ] = size(I);
else
    NJ = SJ(1);
    MJ = SJ(2);
end

if ~exist('show')
    show = 1;
end


if (show)
    figure(1)
    imshow(I,[])
    title('image original')
    axis on
end


J = zeros(NJ,MJ);

X = [1:NJ]'*ones(1,MJ);
Y = ones(NJ,1)*[1:MJ];

x = X(:);
y = Y(:);
m = [x'; y'; ones(1,NJ*MJ)];
mp = H*m;
mp = mp./(ones(3,1)*mp(3,:));
mp = fix(mp + [0.5 0.5 0]'*ones(1,NJ*MJ));
mm = [mp(1:2,:); x'; y'];
mm = mm(:,find(mm(1,:)>0));
mm = mm(:,find(mm(2,:)>0));
mm = mm(:,find(mm(1,:)<=NI));
mm = mm(:,find(mm(2,:)<=MI));
xp = mm(1,:);
yp = mm(2,:);
x  = mm(3,:);
y  = mm(4,:);

i  = xp + (yp-1)*NI;
j  = x  + (y-1)*NJ;

J(j) = I(i);

if (show)
    figure(2)
    imshow(J,[])
    axis on
    title('transformed image')
end

