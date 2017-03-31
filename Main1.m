%% Apollo 13: Geospatial Software Design in Matlab
% Authors: Justin Alvey and Azalee Rafii

%% Clear Everything
clear all; close all; clc;
tic; profile on;

%% Set simulation options:
options = odeset('Events', @spacecraft_events); %, 'Reltol',1e-8);
tspan = [0 1e6]; % 1e6 is the shortest timespan that finds solution

%% Set initial conditions:
mm = 7.34767309*10^(22);
me = 5.97219*10^(24);
ms = 28833; 
rM = 1737100;
rE = 6371000;
G = 6.674*10^(-11);

% Angles
theta_s = 50; % deg
theta_m = 42.5; % deg

% Distances
d_es0 = 340000000; %m
d_em0 = 384403000; %m

% Initial Velocity Magnitudes 
Vs0 = 1000;
Vm0 = sqrt(G*me^2/((me+mm)*d_em0));

%% Define Satellite Position and Velocities
Xs0 = d_es0*cosd(theta_s);
Ys0 = d_es0*sind(theta_s);
Vsx = Vs0*cosd(theta_s);
Vsy = Vs0*sind(theta_s);

%% Define Moon Position and Velocities
Xm0 = d_em0*cosd(theta_m);
Ym0 = d_em0*sind(theta_m);
Vmx = -Vm0*sind(theta_m);
Vmy = Vm0*cosd(theta_m);

y0 = [Xs0; Ys0; Xm0; Ym0; Vsx; Vsy; Vmx; Vmy]; % Initial Conditions

% Run the simulation!
%[t,y] = ode45(@(t,y)odefuncSAT(t,y,mm,me,ms,G),tspan,y0)

%% Find smallest velocity required to ensure s/c survives
[deltaV] = fminsearch(@(dV) OptFun(dV,y0),[0,50]);
deltaV(2) % Print result

[~,y] = OptFun(deltaV,y0); % Find s/c and moon positions

%% Plot Moon and Satellite Paths
% [t,y,te,ye,ie] = ode45(@(t,y)odefuncSAT(t,y),tspan,y0,options);
figure; hold on;
plot(y(:,1),y(:,2),'r--','LineWidth',1.3,'DisplayName','Satellite Path')
plot(y(:,3),y(:,4),'b--','LineWidth',1.3,'DisplayName','Moon Path')
plot(y(1,1),y(1,2),'ro','LineWidth',2,'DisplayName','Satellite Start Loc')
plot(y(1,3),y(1,4),'bo','LineWidth',2,'DisplayName','Moon Start Loc')
plot(y(end,1),y(end,2),'rx','LineWidth',2,'DisplayName','Satellite Final Loc')
plot(y(end,3),y(end,4),'bx','LineWidth',2,'DisplayName','Moon Final Loc')
   
legend('show','Location','SouthEast')

toc; profile viewer;

