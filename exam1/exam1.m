% Exam 1
% Detect tablets 
% Find centroid of the missing tablet 


img = imread('tablets.jpg');

gray_img = rgb2gray(img);
img2 = medfilt2(gray_img);

bin_img2 = imbinarize(img2);

% Structuring Element
SE = strel('disk',5);
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

% Centroid of missing tablet is the middle point 
% between adjacent tablets to left and right
s = regionprops(CC,'centroid');
c1 = s(3,1).Centroid;
c2 = s(7,1).Centroid;

disp((c1 + c2)/2);



