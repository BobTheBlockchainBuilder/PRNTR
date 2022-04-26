% main file for the single camera experiment
% Author: Siranee Nuchitprasitchai
% Last updated: December 6,2016 

% Need to run mainSTLImage.m first to creat STLImage from stlfiles


 close all;
 clear all;
 clc;

 global BK blockSize picture

 % start time 
tStart = tic;
% -------------------------------------------- block matching parameters
halfBlockSize = 33;
blockSize = 2*halfBlockSize+1;
disparityRange = 5; % search region
% --------------------------------------------information to save the file
BK = 'blockmatching size is 67 and searchRegion size is 10 ';
Re = ' for Rescale';
Rec = ' for Rectification';

picture=false; % true;  % show figures for each step = true
color = true; % plot color image = true, plot gray image = false
% % % % file name result
name =strcat( 'result_square ', BK);

fprintf(strcat('square \n'));
fprintf(BK);
fprintf('\n');

% % % %-----------------------------------------------------------------
% % %                                           Input Data
% % % %-----------------------------------------------------------------
% % % %-------------------------------------------------- Camera image

image_folder ='./input_CameraImage path/';

% image from the right camera
cameraImage= imread(strcat(image_folder,'CameraImage file'));  
im1=cameraImage;
if picture == true
    figure('Name','Original Image from camera','NumberTitle','off');
    imshow(cameraImage);
    title('Original Image taken from camera');
end

% % %------------------------------------------------ STLimage

image_folder1 ='./iinput_STLImage path/';
% image from stl file
SCADImage1 = imread(strcat(image_folder1,'STLImage file'));
% rescale the stl file to cameraimage size
SCADImage = imresize(SCADImage1, [480 640]);
result_right=SCADImage;

if picture == true
    figure('Name','Original Image from SCAD','NumberTitle','off');
    imshow(result_right);
    title('Original Image from SCAD');
end

% % %--------------------------------camera Calibration from cameraImage
load onecameraParams.mat
cameraImage = undistortImage(cameraImage, onecameraParams);
cameraImage1 = undistortImage(im1, onecameraParams, 'OutputView','full');
if picture == true
    figure('Name','Image Calibration','NumberTitle','off');
    subplot(1,3,1) ;
    imshow(im1);
    title('Original image from camera');

    subplot(1,3,2) ;
    imshow(cameraImage1);
    title('image Distortion');

    subplot(1,3,3) ;
    imshow(cameraImage);
    title('image Undistortion');
end

% % %------------------------------ ROI for cameraImage
cameraImage = ROIforCameraImage(cameraImage);

% % %---------------------------- checking the shape of Object
[~,~,~,~,sizecameraimage,sizeSCADimage]=Imageshape(cameraImage, SCADImage);

% % %-------------------------- rescale SCAD image
[cameraImage1, SCADImage1]=rescaleSCADimage(sizecameraimage,sizeSCADimage,cameraImage, SCADImage);

% % %---------------------- checking the shape of Object for rectification
[minX_Cameraimage,minXX_SCADimage,maxY_Cameraimage,maxYY_SCADimage,~,~]=Imageshape(cameraImage1, SCADImage1);


% % %---------------------------- image rectification
rectify_cameraimage =imageRectification(minX_Cameraimage,minXX_SCADimage,maxY_Cameraimage,maxYY_SCADimage,cameraImage1, SCADImage1);


% % %---------------------------- detect error
errorDetection(rectify_cameraimage, SCADImage1);

% % %--------------------------------Total  calculation Time 
tElapsed = toc(tStart);
disp(strcat(' Total calculation time = ',num2str(tElapsed),' second'));

% % %----------------------------  save all workspace variables to .mat file
% % %get date and time
dt = fix(clock);
%set up file name 'year-month-date_hour-minute'
filename = [name,'-',num2str(dt(1)),'-',num2str(dt(2)),'-',num2str(dt(3)),'_',num2str(dt(4)),'-',num2str(dt(5)),'.mat'];
% save .mat files into specific folder
foldername=['/ folder path /', filename];
save(foldername,'filename');





