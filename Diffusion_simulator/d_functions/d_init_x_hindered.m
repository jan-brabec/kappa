function [x,r0] = d_init_x_hindered(h,in)
% function [x,r0] = d_init_x_hindered(h,in)
%
% Initializes particles for hindered diffusion

p    = in.p;
n_c  = h.n_c;
r    = h.r;
dist = h.dist;

x0 = (1:1:n_c)*r*dist;
y0 = (1:1:n_c)*r*dist;
c = 1;
for k = 1:numel(x0)
    for l = 1:numel(y0)
        r0(c,:) = [x0(k) y0(l)];
        c = c + 1;
    end
end
x = [unifrnd(r+r*dist*n_c/4,2*r+r*dist*n_c/2+r*dist*n_c/4,p,1), unifrnd(r+r*dist*n_c/4,2*r+r*dist*n_c/2+r*dist*n_c/4,p,1)];
for cs = 1:size(r0,1) %for all individual restrictions separately
    x_all = x(:,1); y_all = x(:,2);
    x0 = r0(cs,1); y0 = r0(cs,2);
    pdx_all = x_all - x0; pdy_all = y_all - y0;
    
    dd = sqrt(pdx_all.^2 + pdy_all.^2);
    ind = find(dd < r+r*0.25);
    x(ind,:) = [];
end




end

