function stlPlot(v, f, name)
%STLPLOT is an easy way to plot an STL object
%V is the Nx3 array of vertices
%F is the Mx3 array of faces
%NAME is the name of the object, that will be displayed as a title



figure;

% % I added Oct 20
% % change figure size
% % Units can be
% %[ inches | centimeters | normalized | points | {pixels} | characters ]
% x0=10;
% y0=10;
% width=550;
% height=400;
% set(gcf,'units','points ','position',[x0,y0,width,height])

% nov 6 add these codes 
% remove z axis
  bg_color = get(gca,'Color');
  set(gca,'XColor',bg_color,'XTick',[])
  set(gca,'YColor',bg_color,'YTick',[])
  set(gca,'ZColor',bg_color,'ZTick',[])
% I added Oct 20
% change the background color from gray to white
set(gcf,'color','white');

set(gca,'XTick',[]) % Remove the ticks in the x axis! 
set(gca,'YTick',[]) % Remove the ticks in the y axis 
set(gca,'ZTick',[]) % Remove the ticks in the y axis 
% set(gca,'Position',[0 0 1 1]) % Make the axes occupy the hole figure
object.vertices = v;
object.faces = f;

% I added Oct 20
% change object color to black by using [0,0,0]
patch(object,'FaceColor',       [0 0 0], ...  % [0.8 0.8 1.0],
         'EdgeColor',       'none',        ...
         'FaceLighting',    'gouraud',     ...
         'AmbientStrength', 0.15);

% Add a camera light, and tone down the specular highlighting
camlight('headlight');
material('dull');

% Fix the axes scaling, and set a nice view angle
 axis('image');

% % I added Oct19
%  view([x,y,z]) sets the view direction to the Cartesian coordinates 
%  x, y, and z. The magnitude of (x,y,z) is ignored.
% view([-135 35]);
%campos([111.41, -527, 30]);
%view([0 0]);

% for other model
% view([0 1.5]);  
% for cylinder model
view([0 5.5]);  

grid on;
%title(name);


% % I added Oct19
% this will remove labels/title as well
     set(gca,'visible','off');
     %pause;
     set(gca,'visible','on');


% this will remove the lines/tick marks
     box off;
     set(gca,'xcolor',get(gcf,'color'));
     set(gca,'xtick',[]);
