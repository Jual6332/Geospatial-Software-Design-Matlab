function [deltaV, y] = OptFun(dV,y0)
% The purpose of this function is to find the smallest delta V required to
% miss the moon and return to Earth. 
options = odeset('Events', @spacecraft_events,'Reltol',1e-11);
tspan = [0 1e6]; % 1e6 is the shortest timespan

y0(5) = y0(5) + dV(1); % Increment Sat x-pos by dV
y0(6) = y0(6) + dV(2); % Increment Sat y-pos by dV

[t,y,te,ye,ie] = ode45(@(t,y)odefuncSAT(t,y),tspan,y0,options);

if ie == 2
    deltaV = norm(dV);
else
    deltaV = 10^9; % A large number, since dv = 0 is results in collision
end
%deltaV = sqrt((y(1) - y(3))^2 + (y(2)-y(4))^2);

end

