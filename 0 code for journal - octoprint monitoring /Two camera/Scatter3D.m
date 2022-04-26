function Scatter3D(objectpoint, BK,resultRect_right,color)

    % % % % %-----------------------------------------------------------------
    % % %                                   Plot the 3D points of each color
    % % % % % % % %-----------------------------------------------------------------
    if color == true
    % % color image
         
        name = strcat(' 3D reconstruction ', BK);
        figure('name',name,'numbertitle','off'); clf; 
        set(gcf,'color','w');
        %whitebg('white');
        %fig.Color = [1 1 1];
        I2=resultRect_right;
        hAxes = gca;
        x1 = objectpoint(:,:,1);
        y1 = objectpoint(:,:,2);
        z1 = objectpoint(:,:,3);
        r = double(I2(:,:,1)) / 255;
        g = double(I2(:,:,2)) / 255;
        b = double(I2(:,:,3)) / 255;
        mask1 = (z1(:)>=-4) & (r(:)+g(:)+b(:) > .3);  
        scatter3(hAxes,x1(mask1),y1(mask1),z1(mask1),[],[r(mask1), g(mask1), b(mask1)],'.');

        %Set up the view.
        axis equal
        xlabel(' X axis');
        ylabel(' Y axis');
        zlabel(' Z axis');

        %set(gcf,'color','w');
    else

    % % % -------------------------------------------------------
    % % gray image

        figure; clf;
         set(gcf,'color','w');

        hAxes = gca;
        x1 = objectpoint(:,:,1);
        y1 = objectpoint(:,:,2);
        z1 = objectpoint(:,:,3);
        r = double(I2(:,:)) / 255;
        g = double(I2(:,:)) / 255;
        b = double(I2(:,:)) / 255;
        % white =1 , black =0
        mask1 = (z1(:)>=-4) & (r(:)+g(:)+b(:) > .3);  
        scatter3(hAxes,x1(mask1),y1(mask1),z1(mask1),[],[r(mask1), g(mask1), b(mask1)],'.');

        %Set up the view.
        axis equal
        xlabel(' X axis');
        ylabel(' Y axis');
        zlabel(' Z axis');


        % % % -------------------------------------------------------
        % figure;
        % hAxes = gca;
        % x1 = objectpoint(:,:,1); x1 = x1(:);
        % y1 = objectpoint(:,:,2); y1 = y1(:);
        % z1 = objectpoint(:,:,3); z1 = z1(:);
        % r = double(I2(:,:,1)) / 255; r = r(:);
        % g = double(I2(:,:,2)) / 255; g = g(:);
        % b = double(I2(:,:,3)) / 255; b = b(:);
        % %mask2 = (z1(:)>=-2) & (r(:)+g(:)+b(:) > .3);  
        % color = [r g b];
        % scatter3(x1,y1,z1,'.','MarkerEdgeColor',[0 0 0]);
    end

end





