% Imageshape funtion: to calculate the shape by suing edge detection
% from file to run one single camera
% Author: Siranee Nuchitprasitchai
% Last updated: December 6,2016 

function [minX,minXX,maxY,maxYY,sizecameraimage,sizeSCADimage]=Imageshape(result_left, result_right)
global picture;  
     I = edge(rgb2gray(result_left));
     if picture == true
         figure('Name','Image shape from camera','NumberTitle','off');
        figure; imshow(I);
        title('edge detection for camera image');
     end  
    % Find indices and values of nonzero element
    [rowY,colX] = find(I==1);
    C = [colX,rowY];   
    maxCameraimage =max(C);
    minCameraimage =min(C);
    maxX=maxCameraimage(1,1);
    maxY=maxCameraimage(1,2);
    minX=minCameraimage(1,1);
    minY=minCameraimage(1,2);

    if picture == true
        figure('Name','Image size from camera','NumberTitle','off');
        figure; imshow(result_left);
        hold on
        plot(minX,maxY, 'r*');
        plot(maxX, maxY, 'r*');
        plot(maxX, minY, 'r*');
        plot(minX,minY, 'r*');
    end

     sizecameraimage = abs(maxX-minX);   
     I1 = edge(rgb2gray(result_right));
     if picture == true
         figure('Name','Image shape from SCAD','NumberTitle','off');
        figure; imshow(I1);
        title('edge detection for SCASD image');
     end  
     % Find indices and values of nonzero element
     [rowY1,colX1] = find(I1==1);
     C1 = [colX1,rowY1];

    maximageSCAD =max(C1);
    minimageSCAD =min(C1);
    maxXX=maximageSCAD(1,1);
    maxYY=maximageSCAD(1,2);
    minXX=minimageSCAD(1,1);
    minYY=minimageSCAD(1,2);

    if picture == true
        figure('Name','Image size from SCAD','NumberTitle','off');
        figure; imshow(result_right);
        hold on
        plot(minXX,maxYY, 'r*');
        plot(maxXX,maxYY, 'r*');
        plot(maxXX,minYY, 'r*');
        plot(minXX,minYY, 'r*');
    end
     sizeSCADimage = abs(maxXX-minXX);


end