% main file for two camera experiment
% Author: Siranee Nuchitprasitchai
% Last updated: December 6,2016 

 close all;
 clear all;
 clc;


% start time for total calculation time
tStart = tic;
% % % %-----------------------------------------------------------------
% %                                                   Camera parameters
% % % %-----------------------------------------------------------------

global pixel_size cl cr f b1 A angle_y blockSize picture
   
% % % %----------------------------Need to be edited
pixel_size=6e-6;
f = 0.016; % focal length
% % % % Left camera position 
% In stereoParamsRadial2coeff.mat - - > from TranslationOfCamera2 
 cl = [-0.0448702 0 0];
% % % % Right camera position (reference camera)
cr = [0 0 0];
% % % % block matching parameters
halfBlockSize = 33;
blockSize = 2*halfBlockSize+1;
disparityRange = 5; % search region
% information for saving output file
BK = ' with block matching size 67 and search region 10_';
Re = ' for Rescale';
Rec = ' for Rectification';
picture=true; % show figures for each step = true
color = true; % plot color image = true, plot gray image = false

%  % % % %---------------------------------Left Camera Rotation
% from stereoParams Calibration, RotationofCamera2 
RotationofCamera2= [ 0.9999        0.0101         0.0084
                    -0.0099        0.9996         -0.252
                    -0.0087        0.0251         0.9996];

angle_y = -1*(atan2(-1*(RotationofCamera2(3,1)),sqrt((RotationofCamera2(3,2))^2+(RotationofCamera2(3,3))^2)));

% translate Cl to origin point Cr
translation1=[1 0 -cl(1)
              0 1 -cl(3)
              0 0 1];
% assume object is on XY-plane
% then rotate z axis  
% it is opposite with MATlab axis

rotation = [ cos(angle_y)  sin(angle_y)   0
             -sin(angle_y)   cos(angle_y)   0
                   0             0         1 ];
               
% translate from origin to new Cl point               
translation2=[1 0 cl(1)
              0 1 cl(3)
              0 0 1];
          
NewClposition = translation2*rotation*translation1*[cl(1); cr(3); 1];
cl(1)=NewClposition(1);
cl(3)=NewClposition(2);
% % % % %-----------------------------------------------------------------

base = cr-cl; 
b1=norm(base);
b2=abs(cl(1));
A = abs(cr(3)-cl(3));



% % % %-----------------------------------------------------------------
% % % %-------------------------------input Images
% % % %---------------------------------------------------  Left image


image_folder ='./path folder/';
% % % % file name result
name =strcat( 'result_fulltriangle ', BK);

disp(strcat('full triangle  ', BK));
result_left= imread(strcat(image_folder,'orangelastl.png'));  
im1=result_left;
if picture == true
    figure('Name','Original Right Image','NumberTitle','off');
    imshow(result_left);
    title('Original Right Image');
end


% % %----------------------------------------------------  Right image

result_right = imread(strcat(image_folder,'orangelastr.png'));  
im2=result_right;

if picture == true
    figure('Name','Original Right Image','NumberTitle','off');
    imshow(result_right);
    title('Original Right Image');
end

 % % %------------------------------camera Calibration

load stereoParamsRadial2coeff.mat

result_left = undistortImage(result_left, stereoParams20161021.CameraParameters2);
result_right = undistortImage(result_right, stereoParams20161021.CameraParameters1);

result_left1 = undistortImage(im1, stereoParams20161021.CameraParameters2, 'OutputView','full');
result_right1 = undistortImage(im2, stereoParams20161021.CameraParameters1, 'OutputView','full');


if picture == true
    figure('Name','Left Image Calibration','NumberTitle','off');
    subplot(1,3,1) ;
    imshow(im1);
    title('Original left image');

    subplot(1,3,2) ;
    imshow(result_left1);
    title('left image Distortion');

    subplot(1,3,3) ;
    imshow(result_left);
    title('left image Undistortion');

    figure('Name','Right Image Calibration','NumberTitle','off');
    subplot(1,3,1) ;
    imshow(im2);
    title('Original right image');

    subplot(1,3,2) ;
    imshow(result_right1);
    title('Right image Distortion');

    subplot(1,3,3) ;
    imshow(result_right);
    title('Right image Undistortion');
    
   
end


% % %----------------------------- Sift and Ransac For Rectification
[matchesRect,faRect,fbRect] = siftRansac(result_left, result_right,BK,Rec);


% % % % % % %------------------------ Rectification
[resultRect_left0,resultRect_right0] = rectification(result_left, result_right,faRect,fbRect,matchesRect,BK);


% % % %------------------------------ Sift and Ransac For Rescale
 [matchesRescale,faRescale,fbRescale] = siftRansac(resultRect_left0,resultRect_right0,BK,Re);
 
% % % %--------------------------------Rescale
 [resultRescale_left, resultRescale_right]=rescale(matchesRescale,faRescale,fbRescale,resultRect_left0,resultRect_right0,BK);


% % %------------------------------ Sift and Ransac For Rectification
[matchesRect,faRect,fbRect] = siftRansac(resultRescale_left, resultRescale_right,BK,Rec);


% % % % % % %---------------------------Rectification
[resultRect_left,resultRect_right] = rectification(resultRescale_left, resultRescale_right,faRect,fbRect,matchesRect,BK);

% % %-----------------------------------Sift and Ransac For 3D calcualtion
[matches3Dcalculation,fa3Dcalculation,fb3Dcalculation] = siftRansac(resultRect_left, resultRect_right,BK,Rec);

% % %-------------------------------- 3-D reconstruciton calculation
objectpoint = calculation(resultRect_left,resultRect_right,matches3Dcalculation,fa3Dcalculation,fb3Dcalculation,blockSize,disparityRange,BK);

% % %-------------------------------- Plot 3-D reconstruciton
Scatter3D(objectpoint, BK,resultRect_right,color);

% % %------------------------------------ Total Calculation Time 
tElapsed = toc(tStart);
Calculation_3D_calculationtimes=tElapsed; % in second

% % %------------------------------------save all workspace variables to .mat file
% % %get date and time
dt = fix(clock);
%set up file name 'year-month-date_hour-minute'
filename = [name,num2str(dt(1)),'-',num2str(dt(2)),'-',num2str(dt(3)),'_',num2str(dt(4)),'-',num2str(dt(5)),'.mat'];
save(filename);




