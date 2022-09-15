function [x,r0] = d_init_x_restricted(r,in)
% function [x,r0] = d_init_x_restricted(r,in)
%
% Initializes particles for restricted diffusion


x = [unifrnd(r.r*10,+r.r*20,in.p,1), unifrnd(-r.r,+r.r,in.p,1)];
ind = find(abs(x(:,2)) > r.r-r.r*0.05);
x(ind,:) = [];


