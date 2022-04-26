% imageRectification function
% Author: Siranee Nuchitprasitchai
% Last updated: December 6,2016 

function [rectify_cameraimage2]=imageRectification(minX_Cameraimage,minXX_SCADimage,maxY_Cameraimage,maxYY_SCADimage,cameraImage,SCADImage)

    global picture ;
        

    cameraImage1=cameraImage;
    %y-axis is going down
    diff_y= maxY_Cameraimage-maxYY_SCADimage;
    diff_x= minX_Cameraimage-minXX_SCADimage;

    rectify_cameraimage1=ones(size(cameraImage1),'uint8').*255;
    rectify_cameraimage2=ones(size(cameraImage1),'uint8').*255;

    if diff_y >= 0 
            %camera image is lower
            rectify_cameraimage1(1:end-diff_y,:,:) = cameraImage1(diff_y+1 :end,:,:);                     
    else
            %camera image is higher
            rectify_cameraimage1(1-diff_y:end,:,:) = cameraImage1(1 :end+diff_y,:,:); 
    end

    if diff_x >= 0            
            rectify_cameraimage2(:,1:end-diff_x,:) = rectify_cameraimage1(:,diff_x+1 :end,:);
        else
            %rectify_image(diff_y+1:end,:) = I1(1 :end-diff_y,:);
            rectify_cameraimage2(:,1-diff_x:end,:) = rectify_cameraimage1(:,1:end+diff_x,:);
    end
    if picture == true
    
        % % % %-------------------------------------------------------------------
        % % % %                   show image after rectification in 2 parallel figure
        % % % % %-----------------------------------------------------------------
        
        figure('Name','Image rectification','NumberTitle','off');
        subplot(1,3,1) ;
        imshow(cameraImage);
        title('camera image before Rectification');

        subplot(1,3,2) ;
        imshow(rectify_cameraimage2);
        title('camera image after Rectification');

        subplot(1,3,3) ;
        imshow(SCADImage);
        title('SCAD image');

        
    end
end