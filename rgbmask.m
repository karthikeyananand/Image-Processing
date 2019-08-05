function Amasked = rgbmask(A,mask)
Amasked(:,:,1) = double(A(:,:,1)).*mask;
Amasked(:,:,2) = double(A(:,:,2)).*mask;
Amasked(:,:,3) = double(A(:,:,3)).*mask;