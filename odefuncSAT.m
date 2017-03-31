function dydt = odefuncSAT(t,y)
  dydt = zeros(8,1);

  % y = [Xs;Ys;Xm;Ym;Vsx;Vsy;Vmx;Vmy]
  % Mass and Radii
  mm = 7.34767309*10^(22);
  me = 5.97219*10^(24);
  ms = 28833; 
  rM = 1737100;
  rE = 6371000;
  G = 6.674*10^(-11);
  
  % Define Earth's position (ALWAYS zero in this frame...)
  Xe = 0;
  Ye = 0;
  
  % Assign velocities to the output vector
  dydt(1) = y(5);  % Vsx
  dydt(2) = y(6);  % Vsy
  dydt(3) = y(7);  % Vmx
  dydt(4) = y(8); % Vmy

  
  % Calculate orbital distances with respect to the Earth - So the Earth is
  % always at the origin...
  d_em = sqrt((Xe-y(3))^2 + (Ye-y(4))^2);
  d_ms = sqrt((y(3)-y(1))^2 + (y(4)-y(2))^2);
  d_es = sqrt((Xe-y(1))^2 + (Ye-y(2))^2);
  
  % Calculate forces between celestial bodies
  FEMx = G*me*mm*(Xe-y(3))/(d_em^3);
  FEMy = G*me*mm*(Ye-y(4))/(d_em^3);
  FMSx = G*mm*ms*(y(3)-y(1))/(d_ms^3);
  FMSy = G*mm*ms*(y(4)-y(2))/(d_ms^3);
  FESx = G*me*ms*(Xe-y(1))/(d_es^3);
  FESy = G*me*ms*(Ye-y(2))/(d_es^3);
  
  %dydt(6) and dydt(2) is really wrong...
  
  % Assign accelerations to be integrated
  dydt(5) = (FMSx + FESx)/ms; % Calculate as_x
  dydt(6) = (FMSy + FESy)/ms; % Calculate as_y
  dydt(7) = (FEMx - FMSx)/mm; % Calculate am_x
  dydt(8) = (FEMy - FMSy)/mm; % Calculate am_y

end

