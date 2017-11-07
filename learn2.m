close all;
img1 = imread('image1.jpg');
img =  rgb2gray(img1);
img = imbinarize(img);
SE = strel('disk',5);
img = imopen(img,SE);

figure;
subplot(1,2,1);
imshow(mask);
subplot(1,2,2);
imshow(bw);
