% Author: Siranee Nuchitprasitchai
% Last updated: December 6,2016 

function calculateworldpoint(xl,yl,xr,yr)
  
  global pixel_size  cl f heightl widthl heightr widthr  b1 objectpoint A cr angle_y
  
% % % % % % %------------------------  horizontal angle of view
  %  left camera
  dl=(xl-(widthl/2))*pixel_size;
  phee_l = atan(dl/f);
  phi_l=(pi/2)-phee_l+angle_y;

  %  rignt camera
  dr=((widthr/2)-xr)*pixel_size;
  phee_r = atan(dr/f);
  phi_r=(pi/2)-phee_r;

  % % small angel in triangle
  omega=asin(A/b1);
  betal=phi_l+omega;
  betar=phi_r-omega;
 
  zeta= pi-betal-betar;
  D1= b1*(sin(betar)/sin(zeta));
  D2= b1*(sin(betal)/sin(zeta));

  [sol_x,sol_z] =solveXZ(D1,cl(1),cl(3),D2,cr(1),cr(3));

  if ~isempty(sol_x)
     sol_x = double(sol_x);
     sol_z = double(sol_z);
     validIndx = sol_x <= 30.00001 & sol_z <= 0.00001;
     indy = round(yr);
     indx = round(xr);
     % x postion
     xtemp2 = sol_x(validIndx);
     objectpoint(indy,indx,1) =  xtemp2;
     %  z position
     ztemp2 = sol_z(validIndx);
     objectpoint(indy,indx,3) =  ztemp2;
     
     %  y_pos
     y1=(yl-(heightl/2))*pixel_size;
     Y_l=(y1/f)*ztemp2;
     y2=(yr-(heightr/2))*pixel_size;
     Y_r=(y2/f)*ztemp2;      
     y2 = (Y_l+ Y_r)/2;
     objectpoint(indy,indx,2) =  (Y_l+ Y_r)/2;
 end
end