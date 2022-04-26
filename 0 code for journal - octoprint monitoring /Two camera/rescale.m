% Author: Siranee Nuchitprasitchai
% Last updated: December 6,2016 

function [I1, I2]=rescale(matches,fa,fb,result_left, result_right,BK)

        global picture
        M=0;
        N=0;
        M = size(matches,2);
        N = round(M/10);
        NN = mod(N,2);
        N = N-NN;
        sumlefthigh=0;
        sumrighthigh=0;
        k=0;
        
        for i = (M-N)+1:2:M  
             % fa(2,matches(1,i))  means the value of y from matiching points 
             ya1 = fa(2,matches(1,i)) ;
             yb1 = fb(2,matches(2,i)) ;
             ya2 = fa(2,matches(1,i+1)); 
             yb2 = fb(2,matches(2,i+1)) ;
             lefthigh = abs(ya2-ya1);
             sumlefthigh = sumlefthigh+lefthigh;
             righthigh = abs(yb2-yb1);
             sumrighthigh = sumrighthigh+righthigh;
             k=k+1; 
             
           if   picture == true
             
            figure; clf;
            ya1 = fa(2,matches(1,i)) ;
            yb1 = fb(2,matches(2,i)) ;
            xl1 = fa(1,matches(1,i)) ;
            xr1 = fb(1,matches(2,i)) ;
            ya2 = fa(2,matches(1,i+1)) ;
            yb2 = fb(2,matches(2,i+1));
            xl2 = fa(1,matches(1,i+1)) ;
            xr2 = fb(1,matches(2,i+1)) ;
            pairOfImages = [result_left,result_right ]; 
            imshow(pairOfImages);
            title(sprintf('Matching Points for Rescale'));

            hold on ;
            h = line([xl1; xr1  + size(result_left,2)  ], [ya1 ; yb1]) ;
            set(h,'linewidth', 1, 'color', 'b') ;
            plot(xl1,ya1,'g.','MarkerSize',20);
            plot(xr1+ size(result_left,2) ,yb1,'g.','MarkerSize',20);

            hold on ;
            h = line([xl2; xr2  + size(result_left,2)  ], [ya2 ; yb2]) ;
            set(h,'linewidth', 1, 'color', 'b') ;
            plot(xl2,ya2,'g.','MarkerSize',20);
            plot(xr2+ size(result_left,2) ,yb2,'g.','MarkerSize',20); 
            
           end
        end
                
        lefthigh = sumlefthigh;
        righthigh = sumrighthigh;
        % % % % % %--------------------------------------Raito Calculation
       if lefthigh > righthigh 
            
           ratio=righthigh/lefthigh;
           fprintf('left bigger %3f', ratio);
         
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
            I2 = result_right;

            if picture == true
            % % % %--------------------show image after Rescale in 1 figure
                 figure, clf;
                imshowpair(result_left,I1,'ColorChannels','red-cyan'), axis image;
                title(strcat('Rescale (original=red, new=cyan)',BK));


            % % % %-------------------show image after Rescale in 2 parallel figure
                figure; clf;
                pairOfImages = [result_left,I1 ]; 
                imshow(pairOfImages);
                title(strcat('Before Rescale     (left omage)                   After Rescale ',BK));
            end
        elseif lefthigh < righthigh 
           ratio=lefthigh/righthigh;
           fprintf('right bigger %3f', ratio);
         
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
                % % % %-------------------------------show image after Rescale in 1 figure
                    figure, clf;
                    imshowpair(result_right,I2,'ColorChannels','red-cyan'), axis image;
                    title(strcat('Rescale (original=red, new=cyan)',BK));


                % % % %---------------------------show image after Rescale in 2 parallel figure
                     figure; clf;
                    pairOfImages = [result_right,I2 ]; 
                    imshow(pairOfImages);
                    title(strcat('Before Rescale    (right image)                    After Rescale ', BK));
            end
        else
            disp('both equal');
            I1= result_left;
            I2= result_right;
            ratio=1;
        end
        
        % % -------------------------------- Show images

        if picture == true
            figure ; clf ;
            suptitle(sprintf('Rescale Images with Ratio = %.3f ', ratio)) ;
            subplot(1,2,1) ;
            imshow(I1);
            subplot(1,2,2) ;
            imshow(I2);
        end
end