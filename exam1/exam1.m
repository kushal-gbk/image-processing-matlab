img = imread('image1.jpg');

gray_img = rgb2gray(img);
img2 = medfilt2(gray_img);
img2 = imgaussfilt(img2);

bin_img2 = imbinarize(img2);
SE = strel('disk',5);
bin_img3 = imopen(bin_img2,SE);
%bin_img3 = imerode(bin_img2,SE);
[L,num] = bwlabel(bin_img3);
imshow(bin_img3)
disp(num)

[r,c] = find(L==1);

disp(size(r));
disp(size(c));

CC = bwconncomp(bin_img3);
%disp(CC.PixelIdxList{2})

s = regionprops(CC,'centroid');
c1 = s(3,1).Centroid;
c2 = s(7,1).Centroid;

disp((c1 + c2)/2);



