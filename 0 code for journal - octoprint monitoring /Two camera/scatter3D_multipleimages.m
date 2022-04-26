% % % % %-----------------------------------------------------------------
% % %                                   Plot the 3D points of each color
% % % % % % % %-----------------------------------------------------------------

% % color image
figure; clf;
set(gcf,'color','w');
hAxes = gca;

for i= 1:10

x0 = allobjectpoint(1,:,i);
y0 = allobjectpoint(2,:,i);
z0 = allobjectpoint(3,:,i);
 
r = double(II2(:,:,i)) / 255;
g = double(II2(:,:,i+1)) / 255;
b = double(II2(:,:,i+2)) / 255;

end
mask1 = (z0(:)>=-4) & (r(:)+g(:)+b(:) > .3);  
scatter3(hAxes,x0(mask1),y0(mask1),z0(mask1),[],[r(mask1), g(mask1), b(mask1)],'.');

%Set up the view.
axis equal
xlabel(' X axis');
ylabel(' Y axis');
zlabel(' Z axis');