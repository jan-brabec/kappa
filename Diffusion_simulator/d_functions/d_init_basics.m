function [dx,t,dt,ADC,msd] = d_init_basics(in)
% [dx,t,dt,ADC,msd] = d_init_basics(in)
%   
% Initialize basics

t = linspace(0,in.T,in.no_T); %time
dt = t(2) - t(1);
msd = zeros(in.no_T,2);
ADC = zeros(in.no_T,2);

dx = sqrt(2*in.D0*dt); %stepping

end

