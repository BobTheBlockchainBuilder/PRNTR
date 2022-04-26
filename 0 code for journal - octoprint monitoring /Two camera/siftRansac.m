
% Author: Siranee Nuchitprasitchai
% Last updated: December 6,2016 

function [matches,fa,fb] = siftRansac(leftimage, rightimage,BK, Re)
    global picture
    % % %-----------------------------------------------------  SIFT
 
    [fa,da] = vl_sift(im2single(rgb2gray(leftimage))) ;
    [fb,db] = vl_sift(im2single(rgb2gray(rightimage))) ;
 
    [matches, scores] = vl_ubcmatch(da,db) ;
    numMatches = size(matches,2) ;

    X1 = fa(1:2,matches(1,:)) ; X1(3,:) = 1 ;
    X2 = fb(1:2,matches(2,:)) ; X2(3,:) = 1 ;

    okay = ransac(numMatches, X1,X2);

    ok=okay;
    
    % ------------------------------------------------------------------------
    % remove outliner points
    matches = matches(:,ok);
    scores = scores(:,ok);

    [drop, perm] = sort(scores, 'descend') ;
    matches = matches(:, perm); 
    % S.('rescalematchdata') = matches;
    % save('rescalematchdata.mat', '-struct', 'S')  
    scores  = scores(perm) ;
    if picture == true
% % % %----- show all matching line..in one parallel figure of left and right
        M=0;
        N=0;
        M = size(matches,2);
        N = round(M/10);
        i=0;
        figure; clf;
        pairOfImages = [leftimage ,rightimage]; 
        imshow(pairOfImages);
        title(sprintf(strcat('Matching Points between left and right image',Re, BK)));
        hold on ;
        for i =  1:M % (M-N)+1:M
            xa = fa(1,matches(1,i)) ;
            xb = fb(1,matches(2,i));
            ya = fa(2,matches(1,i)) ;
            yb = fb(2,matches(2,i)) ;
            h = line([xa; xb  + size(leftimage,2)  ], [ya ; yb]); 
            set(h,'linewidth', 1, 'color', 'b') ;
            plot(xa,ya,'g.','MarkerSize',30);
            plot(xb+ size(leftimage,2) ,yb,'g.','MarkerSize',30);

        end
    end

end