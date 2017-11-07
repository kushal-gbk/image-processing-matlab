im = imread('D:\image1.jpg');
background = imopen(im,strel('sphere',250)); 

im2 = im - background;
%im2 = imbinarize(I,'adaptive');
imshow(im2);
%im3 = imadjust(im2);

%level = graythresh(im2);
%bw = im2bw(im2,level);
%bw = bwareaopen(bw, 250);
im2 > 100;
imshow(im2);
%cc = bwconncomp(bw, 8)
%cc.NumObjects;