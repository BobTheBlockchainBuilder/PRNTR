% rescaleSCADimage function
% Author: Siranee Nuchitprasitchai
% Last updated: December 6,2016 

function [I1, I2]=rescaleSCADimage(sizecameraimage,sizeSCADimage,result_left, result_right)

        global picture  BK;

        % % % % % %-------------------------------------------------------------------
        % % % % % %                                                Calculate ratio
        % % % % % % %-----------------------------------------------------------------
        if sizecameraimage > sizeSCADimage
            
           ratio=sizeSCADimage/sizecameraimage;
           fprintf('     For rescaling, camera image is bigger %3f \n', ratio);
         
           %get the original size of image
           [orowsize, ocolumnsize,ochannel] = size(result_left);
           B = imresize(result_left, ratio);
           
           %get the new size of image
           [nrowsize, ncolumnsize,nchannel] = size(B);

            %pad white to the image
            newimage = ones(orowsize,ocolumnsize,ochannel,'uint8').*255;

            %find position of resized image in newiimage
            drow = round(abs(orowsize - nrowsize)/2);
            dcolumn = round(abs(ocolumnsize - ncolumnsize)/2);
            if drow==0, drow=1; end
            if dcolumn==0, dcolumn=1; end

            %insert resized image to new image
            newimage(drow:nrowsize+drow-1,dcolumn:ncolumnsize+dcolumn-1,:) = B(:,:,:);
            
            %replace original image with newimage
            I1 = newimage; 
            %I2=new_rface;
            I2 = result_right;

            if picture == true
            % % % %---------------------- show image after Rescale in 1 figure
                figure, clf;
                imshowpair(result_left,I1,'ColorChannels','red-cyan'), axis image;
                title(strcat('Rescale (original=red, new=cyan)',BK));


            % % % %------------------- show image after Rescale in 2 parallel figure 
                figure; clf;
                pairOfImages = [result_left,I1 ]; 
                imshow(pairOfImages);
                title(strcat('Before Rescale     (left omage)                   After Rescale ',BK));
            end
        elseif sizecameraimage < sizeSCADimage
            
           ratio=sizecameraimage/sizeSCADimage;
           fprintf('     For rescaling, SCAD image is bigger %3f \n', ratio);
         
              %get the original size of image
           [orowsize, ocolumnsize,ochannel] = size(result_right);
           B = imresize(result_right, ratio);
           %get the new size of image
           [nrowsize, ncolumnsize,nchannel] = size(B);
            %pad white to the image
            newimage = ones(orowsize,ocolumnsize,ochannel,'uint8').*255;

            %find position of resized image in newiimage
            drow = round(abs(orowsize - nrowsize)/2);
            dcolumn = round(abs(ocolumnsize - ncolumnsize)/2);
            if drow==0, drow=1; end
            if dcolumn==0, dcolumn=1; end

            %insert resized image to new image
            newimage(drow:nrowsize+drow-1,dcolumn:ncolumnsize+dcolumn-1,:) = B(:,:,:);

            %replace original image with newimage
            I1 = result_left;
            I2 = newimage;
            if picture ==true
             % %-------------------------------show image after Rescale in 1 figure
                    figure, clf;
                    imshowpair(result_right,I2,'ColorChannels','red-cyan'), axis image;
                    title(strcat('Rescale (original=red, new=cyan)',BK));
          % % %------------------------------show image after Rescale in 2 parallel figure
                    figure; clf;
                    pairOfImages = [result_right,I2 ]; 
                    imshow(pairOfImages);
                    title(strcat('Before Rescale    (right image)                    After Rescale ', BK));
            end
        else
            fprintf('both equal');
            I1= result_left;
            I2= result_right;
            ratio=1;
        end
        
        % % ------------------------------------------------- Show images

        if picture == true
            figure ; clf ;
            suptitle(sprintf('Rescale Images with Ratio = %.3f ', ratio)) ;
            subplot(1,2,1) ;
            imshow(I1);
            subplot(1,2,2) ;
            imshow(I2);
        end
end