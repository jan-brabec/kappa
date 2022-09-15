function x = d_init_x_circle(pp,r)
% function x = d_init_x_circle(p)
%   
% Initialize particles in a circle

x = [unifrnd(-r,+r,pp,1), unifrnd(-r,+r,pp,1)];
dd = sqrt(x(:,1).^2 + x(:,2).^2);
ind = find(dd > r-r*0.05);
x(ind,:) = [];

end

