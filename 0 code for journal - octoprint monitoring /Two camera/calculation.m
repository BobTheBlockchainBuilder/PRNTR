% Author: Siranee Nuchitprasitchai
% Last updated: December 6,2016 

function objectpoint = calculation(resultRect_left,resultRect_right,matches3Dcalculation,fa3Dcalculation,fb3Dcalculation,blockSize,disparityRange,BK)
        global pixel_size  cl f heightl widthl heightr widthr  b1 A cr angle_y picture  objectpoint 
        halfBlockSize = (blockSize-1)/2;
        I1=resultRect_left;
        I2=resultRect_right;
        heightl = size(I1,1);  
        widthl = size(I1,2);
        heightr = size(I2,1); 
        widthr = size(I2,2);
        objectpoint =zeros(heightl,widthl,3);  
         M=0;
         M = size(matches3Dcalculation,2);
         i=0; 
         ii=0;
        matched = zeros(heightl,widthl,'single');
        
        % % % %----------------------------------------Basic Block Matching

   
        tmats = cell(blockSize);

        % Initialize progress bar
        hWaitBar = waitbar(0, 'Performing basic block matching...');
       
        nRowsLeft = size(I1, 1);
        nColsLeft = size(I1, 2);
        % % check difference in x axis to identify ROI
        xl = fa3Dcalculation(1,matches3Dcalculation(1,end)) ;
        xr = fb3Dcalculation(1,matches3Dcalculation(2,end)) ;
        yl = fa3Dcalculation(2,matches3Dcalculation(1,end)) ;
        yr = fb3Dcalculation(2,matches3Dcalculation(2,end)) ;
        
        diff_x=round(xl-xr-disparityRange/2); %last matching point from above

        % coordinate matrices
        tempI1 = double(rgb2gray(I1));
        [X,Y] = meshgrid(1-xl:nColsLeft-xl,1-yl:nRowsLeft-yl);       
        tempI1 = tempI1+X +Y;

        tempI2 = double(rgb2gray(I2));
        [X,Y] = meshgrid(1-xr:nColsLeft-xr,1-yr:nRowsLeft-yr);
        tempI2 = tempI2+X + Y;

        rightimage_ROI = rgb2gray(I2);
        ROI = (rightimage_ROI<250);

        if picture == true
            figure('name','Region of Interest blocksize ','numbertitle','off'), imshow(ROI);
            title(sprintf(strcat('Region of Interest ',BK)));
        end 
        
        i=1;
        for m= 1:nRowsLeft

            % Set min/max row bounds for image block.
             minr = max(1,m-halfBlockSize);
             maxr = min(nRowsLeft,m+halfBlockSize);

            % Scan over all columns.
            for n= 1:nColsLeft 

                if matched(m,n) == 0
                    minc = max(1,n-halfBlockSize);
                    maxc = min(nColsLeft,n+halfBlockSize);
                    % Compute disparity bounds.
                    mind = max( -disparityRange, 1-minc );
                    maxd = min( disparityRange, nColsLeft-maxc );

                    % Construct template and region of interest (right image).
                    template = tempI2(minr:maxr,minc:maxc);
                    templateCenter = floor((size(template)+1)/2);
                    objcolor = double(I2(m,n,:))./255.0;

                    % % when background is white, crop only image
                     if (minc+templateCenter(2)+mind-1+diff_x <=  nColsLeft && minc+templateCenter(2)+mind-1+diff_x >=1 && (sum(objcolor)<0.5)|| (ROI(m,n) == 1))    
                        if diff_x >=0
                            roi = [min(minc+templateCenter(2)+mind-1+diff_x,  nColsLeft) ...
                                   minr+templateCenter(1)-1 ...
                                   maxd-mind+1 ...
                                   1];
                        else
                            roi = [max(minc+templateCenter(2)+mind-1+diff_x, 1) ...
                                   minr+templateCenter(1)-1 ...
                                   maxd-mind+1 ...
                                   1];
                        end

                        % Lookup proper TemplateMatcher object; create if empty.
                        % tmats is created as an empty cell array 7x7
                        % says "if the element of the cell array tmats{4,4} 
                        % (the size of the template in the row and column dimension the 
                        % first time through the for loop) is empty, place the System 
                        % object handle vision.TemplateMatcher('ROIInputPort',true) in that
                        % element of the cell array"
                        % The next time through the loop the column location changes as 
                        % explained in the demo.

                        % isempty() basically checks to see if the variable has been 
                        % assigned and has a value or not. roi means "region of interest" 
                        % and is the portion of the array to operate on.


                        if isempty(tmats{size(template,1),size(template,2)})
                            tmats{size(template,1),size(template,2)} = ...
                                vision.TemplateMatcher('ROIInputPort',true);
                        end
                        thisTemplateMatcher = tmats{size(template,1),size(template,2)};

                        % Run TemplateMatcher object.
                        % step is Finds the best template match within image
                        % LOC = step(H,I,T,ROI) computes the location of the best template 
                        % match, LOC, in the specified region of interest, ROI. This applies 
                        % when you set the OutputValue property to Best match location and
                        % the ROIInputPort property to true. The input ROI must be a four 
                        % element vector, [x y width height], where the first two elements 
                        % represent the [x y] coordinates of the upper-left corner of the rectangular ROI.

                        loc = step(thisTemplateMatcher, tempI1, template, roi);

                        xl = double(loc(1));
                        yl = double(loc(2));
                        xr = double(n);
                        yr = double(m);

                        matched(round(yr),round(xr)) = 1;

          % % matching points  

                        answer1(i,1)=xl;
                        answer1(i,2)=yl;
                        answer1(i,3)=xr;
                        answer1(i,4)=yr;
                        calculateworldpoint(xl,yl,xr,yr);
                        objectpoint_x=objectpoint(m,n,1); 
                        objectpoint_y=objectpoint(m,n,2);
                        objectpoint_z=objectpoint(m,n,3);
                        answer1(i,5)=objectpoint_x;
                        answer1(i,6)=objectpoint_y;
                        answer1(i,7)=objectpoint_z;
                        i=i+1;
       
                    else
                        objectpoint(m,n,1) = 0;
                        objectpoint(m,n,2) = 0;
                        objectpoint(m,n,3) = -1000;

                     end


                end
            end
          
            waitbar(m/nRowsLeft,hWaitBar,sprintf('Performing coordinate block matching...%3.2f%%',double(m/nRowsLeft)*100.00));
  
        end
  
        close(hWaitBar);
        tElapsed = toc(tStart);
        calculationtime=tElapsed; 
        disp(strcat('     3D calculation time = ',num2str(calculationtime),' second'));
 
end