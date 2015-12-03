%% Use polarization to improve underwaterimages
%function[PolarizedImage] = polarizeImage(I, map)

%Il = imread('LeftCameraRun2_1.png');
Il = imread('blurry.jpg');
Ir = imread('RightCameraRun2_1.png');

% Make Il and Ir histogram equal
IrNew  = imhistmatch(Ir,Il);

figure
imshowpair(Il, Ir, 'montage');
title('Original');

figure
imshowpair(Il, Ir, 'montage');
title('equalized');

Itest = rgb2gray(Il);
% test of histogram equalization
J = histeq(Itest);
figure, 
imshowpair(Itest, J, 'montage'); 
title('comparison before after histeq')

%%  Apply Contrast-Limited Adaptive Histogram Equalization to a color  photograph.
%RGB = ind2rgb(Il,map); % convert indexed image to truecolor format
RGB = Il;
cform2lab = makecform('srgb2lab');
LAB = applycform(RGB, cform2lab); %convert image to L*a*b color space
L = LAB(:,:,1); % scale the values to range from 0 to 1
LAB(:,:,1) = adapthisteq(L,'clipLimit',0.02,'Distribution','rayleigh');  %'NumTiles',[8 8],'ClipLimit',0.005)*100;
cform2srgb = makecform('lab2srgb');
J = applycform(LAB, cform2srgb); %convert back to RGB
figure
imshowpair(RGB, J, 'montage'); 
title('Contrast-Limited Adaptive Histogram Equalization to color photo')




%% make it into grayscale
I=Il;
Igray = rgb2gray(I);

% convert image to truecolor(RGB) image
RGB =  Igray;%ind2rgb(I,map);

%RGB = double(RGB);

%Perfrom CLAHE --> Contrast-limited Adaptive Histogram Equalization (CLAHE)
%LAB = adapthisteq(LAB(:,:,1),'clipLimit',0.02,'Distribution','rayleigh');
J = adapthisteq(Igray,'clipLimit',0.02,'Distribution','rayleigh');
% From matlab documentation : " For example, underwater imagery appears to 
%look more natural when the Rayleigh distribution is used."

PolarizedImage = J;

% Display
figure
imshowpair(I, PolarizedImage, 'montage');
title('Original  vs PolarizedImage');

%%


%size(I)
% make it into grayscale
%Igray = rgb2gray(I);



% convert image to truecolor(RGB) image
%RGB =  Igray;%ind2rgb(I,map);
% Convert the RGB image into L*a*b color space
%cfrom2labL=makecfrom('srgb2lab');
%LABl = applycform(RGBl,cfrom2labL);
%size(RGB)
%RGB = double(RGB);
%I = double(I);

%LAB = rgb2lab(RGB);
%size(LAB)

% scale LAB calues to range from 0 to 1
%L = LAB(:,:,1)/100;
%size(L)
%Perfrom CLAHE
%LAB = adapthisteq(LAB(:,:,1),'clipLimit',0.02,'Distribution','rayleigh');
%J = adapthisteq(Igray,'clipLimit',0.02,'Distribution','rayleigh');
%size(LAB)
% Convert image back to RGB color space
%cfrom2srgb = makecform('lab2srgb');
%Jl= applycform(LABl,cfrom2srgb);

%J = lab2rgb(LAB);
%size(J)

