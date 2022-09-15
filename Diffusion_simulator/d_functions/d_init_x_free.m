function x = d_init_x_free(p,in)
% function x = d_init_x_free(p,in)
%
% Initializes free diffusion

x = [unifrnd(-p.r,+p.r,in.p,1), unifrnd(-p.r,+p.r,in.p,1)];
dd = sqrt(x(:,1).^2 + x(:,2).^2);
ind = find(dd > p.r-p.r*0.05);
x(ind,:) = [];

end

