function [ value,isterminal,direction] = spacecraft_events( t,y )
% This function will describe the 3 possible events of the spacecraft
% Event 1 = the space craft will hit the moon - the distance between the
% two is zero
% Event 2 = the spacecraft returns to Earth
% Event 3 = the spacecraft is lost to outer space

% Givens
Xe = 0;
Ye = 0;
rM = 1737100;
rE = 6371000;

% Event 1 - dms < rM -> dms - rM = 0
% calculate dms:
d_ms = sqrt((y(3)-y(1))^2 + (y(4)-y(2))^2);
value(1,1) = d_ms - rM;

% Event 2 - d_es <= rE so d_es - rE = 0
% Calculate d_es:
d_es = sqrt((Xe-y(1))^2 + (Ye-y(2))^2);
value(2,1) = d_es - rE;

% Event 3 - d_es >= 2*d_em --> d_es - 2*d_em = 0
% Calculate d_em 
d_em = sqrt((Xe-y(3))^2 + (Ye-y(4))^2);
value(3,1) = d_es - 2*d_em;

% If any of the above events occur, terminate the integration:
isterminal = [1;1;1];

% Negative direction only:
direction = [0;0;0];

end

