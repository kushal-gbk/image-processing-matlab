% Exam 2
% Display White Squares and Gray Squares separately
% Display Different sized squares in separate figures


close all;
img = imread('squares.jpg');
imgb = imbinarize(img);

%SE = strel('square',5);
%imgb = imerode(imgb,SE);

thresh = multithresh(img,2);
thresh_low = thresh(1,1);
thresh_high = thresh(1,2);
disp(thresh_low);
disp(thresh_high);
%seg_I = imquantize(img,thresh);

%darkBlobs = (img > thresh_low);  % Find dark things.
%labeledDark = bwlabel(darkBlobs);
dark_squares_img = zeros(size(img));
[r,c] = size(img);
for i=1:r
    for j=1:c
        if img(i,j)>thresh_low && img(i,j)<thresh_high
            dark_squares_img(i,j) = 255;
        else
            dark_squares_img(i,j) = 0;
        end
    end
end

dark_squares_img = imbinarize(dark_squares_img);
darkMeasurements = regionprops(dark_squares_img, 'Area', 'Perimeter');
dcc_main = bwconncomp(dark_squares_img);
disp('Number of dark Objects');
disp(dcc_main.NumObjects);

dark_areas = darkMeasurements.Area;

brightBlobs = img > thresh_high; % Find bright things.
labeledBright = bwlabel(brightBlobs);
brightMeasurements = regionprops(labeledBright, 'Area', 'Perimeter');

bcc_main = bwconncomp(labeledBright);
disp('Number of dark Objects');
disp(bcc_main.NumObjects);

bright_areas =  brightMeasurements.Area;
disp(bright_areas);

large_bright_squares = bwareafilt(imbinarize(labeledBright),3,'largest');
lbs = bwconncomp(large_bright_squares);
disp(lbs.NumObjects);
small_bright_squares = bwareafilt(imbinarize(labeledBright),7,'smallest');
lbs = bwconncomp(small_bright_squares);
disp(lbs.NumObjects);
medium_bright_squares = imbinarize(labeledBright) - small_bright_squares -large_bright_squares;
lbs = bwconncomp(medium_bright_squares);
disp(lbs.NumObjects);

medium_dark_squares = bwareafilt(dark_squares_img,9,'largest');
lbs = bwconncomp(medium_dark_squares);
disp(lbs.NumObjects);
small_dark_squares = bwareafilt(dark_squares_img,13,'smallest');
lbs = bwconncomp(small_dark_squares);
disp(lbs.NumObjects);

figure;
subplot(3,3,1);
imshow(img);
title('original Image');

subplot(3,3,2);
imshow(dark_squares_img);
title('Dark Squares');

subplot(3,3,3);
imshow(labeledBright);
title('Bright Squares');

subplot(3,3,4);
imshow(large_bright_squares);
title('Large Brught Squares');

subplot(3,3,5);
imshow(small_bright_squares);
title('Small Bright Squares');

subplot(3,3,6);
imshow(medium_bright_squares);
title('Medium Bright Squares');

subplot(3,3,7);
imshow(medium_dark_squares);
title('Medium Dark Squares');

subplot(3,3,8);
imshow(small_dark_squares);
title('Small Dark Squares');

impixelinfo;