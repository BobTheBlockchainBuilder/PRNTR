% Author: Siranee Nuchitprasitchai
% Last updated: December 6,2016 

function [resultRect_left,resultRect_right] = rectification(resultRescale_left, resultRescale_right,faRect,fbRect,matchesRect,BK)

    global picture
    left= resultRescale_left;
    resultRect_right=resultRescale_right;
   
    ya =  faRect(2,matchesRect(1,end));
    yb =  fbRect(2,matchesRect(2,end)); 
    diff_y=round(ya-yb);
    % pad white to the background
    rectify_image=ones(size(left),'uint8').*255;
    if diff_y >= 0 
        rectify_image(1:end-diff_y,:) = left(diff_y+1 :end,:);
    else
        rectify_image(1-diff_y:end,:) = left(1 :end+diff_y,:);
    end
    resultRect_left=rectify_image;
    
    if picture == true
    
        % % % %---- show image after rectification in 2 parallel figure
       figure; clf;
        pairOfImages = [left,resultRescale_right ]; 
        imshow(pairOfImages);
        title('                       Before rectification');

        figure; clf;
        pairOfImages = [resultRescale_left,resultRescale_right ]; 
        imshow(pairOfImages);
        title(strcat('                       After rectification ', BK));
    end
end