clear all
clc
close all

A = imread('5.jpg');
figure(1)
imshow(A)
title('Input Image')
h = imfreehand;
position = wait(h);
e = impoly(gca,position);
BW = createMask(e);
BW = 1-BW;

figure(2)
imshow(1-BW)
title('Mask')
ROI=uint8(rgbmask(A,BW));
figure(3)
imshow(ROI,[]);
title('Input with mask')
ROI1 = ROI;

[r,c]=find(BW<1);

d = 2;

for z = 1:1:length(r)
    irow = r(z)-d/2:1:r(z)+d/2;
    icol = c(z)-d/2:1:c(z)+d/2;
    for i = irow(1):1:irow(end)
        for j = icol(1):1:icol(end)
            rm(i-irow(1)+1,j-icol(1)+1)=A(i,j,1);
            gm(i-irow(1)+1,j-icol(1)+1)=A(i,j,2);
            bm(i-irow(1)+1,j-icol(1)+1)=A(i,j,3);
        end
    end
    rmed(z,1) = median(median(rm));
    gmed(z,1) = median(median(gm));
    bmed(z,1) = median(median(bm));
    ROI1(r(z),c(z),1) = rmed(z,1);
    ROI1(r(z),c(z),2) = gmed(z,1);
    ROI1(r(z),c(z),3) = bmed(z,1);
end

figure(4)
imshow(ROI1)
title('Output Image')
rmse = immse(A,ROI1);
psnr = 20*log10(255/rmse);
fprintf('The PSNR for the following image is =%3.4f dB',psnr);