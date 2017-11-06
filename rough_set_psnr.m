A = imread('test_main2.png');
%A = imnoise(A1,'salt & pepper',0.02);
%imshow('gray.png');

new_image = zeros(size(A));

for ii=1:(size(A,1)-2)
    for jj=1:(size(A,2)-2)
        count=0;
        is_safe=1;
        for x=(ii-2):(ii+2)
            for y=(jj-2):(jj+2)
                if x>=1 && y >=1
                    gray_ratio = double(A(x,y)) / double(A(ii,jj)+1);
                    if (gray_ratio>=0.9) && (gray_ratio<=1.1)
                        count = count + 1;
                    end
                else
                    is_safe=0;
                end  
            end
        end   
        %new_image(ii,jj) = A(ii,jj);
        if count > 5
            new_image(ii,jj)=A(ii,jj);
        elseif count == 5 
            if is_safe==1
                mean_of_nbrs = 0;
                diff_array = zeros(25,2);
                c=1;
                for x=(ii-2):(ii+2)
                    for y=(jj-2):(jj+2)
                        diff_array(c,1) = abs((A(x,y)-A(ii,jj)));
                        diff_array(c,2) = A(x,y);
                        c = c+ 1;
                    end
                end
                diff_array = sortrows(diff_array);
                new_image(ii,jj) = mean(diff_array(2:6));
            else
                new_image(ii,jj) = A(ii,jj);
            end
           
        else
            if is_safe==1
                sum_of_nbrs = 0;
                mean_of_nbrs = A(ii,jj);
                for x=(ii-2):(ii+2)
                    for y=(jj-2):(jj+2)
                        sum_of_nbrs = sum_of_nbrs + A(x,y);
                    end
                end
                mean_of_nbrs = sum_of_nbrs/25;  
                new_image(ii,jj) = mean_of_nbrs;
            else
                new_image(ii,jj) = A(ii,jj);
            end
            
        end
          
    end
end

% Median Filter
%B = medfilt2(A);
disp(size(A));
disp(size(new_image));


figure()
subplot(1,2,1)
imshow(A,[])
title('original image')
subplot(1,2,2)
imshow(uint8(new_image),[])
title('new image')

%subplot(1,2,2)
%imshow(B,[])
%title('Median')

peaksnr = psnr(uint8(new_image),A);
%peaksnr2 = psnr(B,A);
disp('PSNR ratio Rough set ');
disp(peaksnr);

%disp('Median Filter');
%disp(peaksnr2);

% Averaging FIlter
J = imnoise(A,'salt & pepper',0.02);
Kaverage = filter2(fspecial('average',3),J)/255;
peaksnr3 = psnr(uint8(Kaverage),A);

disp('Averaging Filter');
disp(peaksnr3);

