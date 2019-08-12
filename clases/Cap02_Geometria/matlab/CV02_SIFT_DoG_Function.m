% Example:
%
% DoG function used by CV03_SIFT_DoG_Keypoints.m
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl

function J = CV03_SIFT_DoG_Function(I,s1,s2,show)

if ~exist('show','var')
    show = 0;
end


if s1<s2
    s0 = s1;
    s1 = s2;
    s2 = s0;
end

% s1 is greater than s2

m   = 2*fix(8.5*s1/2)+1;
G1  = fspecial('gaussian',m,s1);
G2  = fspecial('gaussian',m,s2);
DoG = G1-G2;
J   = conv2(I,DoG,'same');

if show
    figure(10)
    imshow(I,[])
    title('original')
    figure(11)
    imshow(abs(conv2(I,G1,'same')),[])
    title('H1=I**G1: Filtered using first gaussian')
    figure(12)
    imshow(abs(conv2(I,G2,'same')),[])
    title('H2=I**G2: Filtered using second gaussian')
    figure(13)
    imshow(abs(J),[])
    title('DoG: (H1-H2)')
    drawnow;
end