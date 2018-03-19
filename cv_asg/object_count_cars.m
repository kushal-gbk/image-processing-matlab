% Assignment 4
% Object Count Finding


img = imread('cars.png');

gray_img = rgb2gray(img);
img2 = medfilt2(gray_img);

bin_img2 = imbinarize(img2);

% Structuring Element
SE = strel('square',5);
bin_img3 = imopen(bin_img2,SE);

% In matlab 2015
% Get connected components 
[L,num] = bwlabel(bin_img3);
imshow(bin_img3)
disp(num)

% Use this to make new image with only connected components
[r,c] = find(L==1);


% In matlab 2016+
% Get connected components 
CC = bwconncomp(bin_img3);
% Use this to make new image with only connected components
% CC.PixelIdxList{2}

disp('Number of Objects');
disp(cc.NumObjects);



