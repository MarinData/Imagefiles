%% Use polarization to improve underwaterimages
function[PolarizedImage] = polarizeImage(I, map)
%%  Apply Contrast-Limited Adaptive Histogram Equalization to a color  photograph.
RGB = I;
cform2lab = makecform('srgb2lab');
LAB = applycform(RGB, cform2lab); %convert image to L*a*b color space
L = LAB(:,:,1); % scale the values to range from 0 to 1
LAB(:,:,1) = adapthisteq(L,'clipLimit',0.02,'Distribution','rayleigh');  %'NumTiles',[8 8],'ClipLimit',0.005)*100;
cform2srgb = makecform('lab2srgb');
J = applycform(LAB, cform2srgb); %convert back to RGB
% Display comparison figure
figure
imshowpair(RGB, J, 'montage'); 
title('Contrast-Limited Adaptive Histogram Equalization to color photo')

PolarizedImage = J;
