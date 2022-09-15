function [ADC,msd,x] = d_sim_diff(x,in,p,ts,type)
% function [ADC,msd,x] = d_sim_diff(x,in,ts,type)
%
% Simulate diffusion

x = d_x_step(x,in.dx);

persistent x_init_f x_init_h x_init_r

if ts == 1
    if strcmp(type,'free')
        x_init_f = x;
    elseif strcmp(type,'hindered')
        x_init_h = x;
    elseif strcmp(type,'restricted')
        x_init_r = x;
    end
end

if strcmp(type,'free')
    1; %no restrictions
    
elseif strcmp(type,'hindered')
    for cs = 1:size(p.r0,1) %for all individual restrictions separately
        x_all = x(:,1); y_all = x(:,2);
        x0 = p.r0(cs,1); y0 = p.r0(cs,2);
        pdx_all = x_all - x0; pdy_all = y_all - y0;
        
        dd = sqrt(pdx_all.^2 + pdy_all.^2);
        ind = find(dd < p.r);
        
        for ps = 1:numel(ind) %for all particles separately
            x0 = p.r0(cs,1); y0 = p.r0(cs,2);
            xa = x(ind(ps),1); ya = x(ind(ps),2);
            pdx = (xa-x0); pdy = (ya-y0);
            
            theta = atan2(pdy,pdx);
            ro = p.r - sqrt(pdx^2+pdy^2); %overshoot
            
            x(ind(ps),1) = xa + (2 * ro * cos(theta));
            x(ind(ps),2) = ya + (2 * ro * sin(theta));
        end
    end

elseif strcmp(type,'restricted')
    ind = find(x(:,2) > p.r);
    x(ind,2) = p.r - (x(ind,2) - p.r);
    ind = find(x(:,2) < -p.r);
    x(ind,2) = -p.r + abs(x(ind,2))-p.r;
end

if strcmp(type,'free')
    x_init = x_init_f;
elseif strcmp(type,'hindered')
    x_init = x_init_h;
elseif strcmp(type,'restricted')
    x_init = x_init_r;
end

msd = d_msd_from_x(x,x_init);
ADC = d_ADC_from_msd(msd,in.t(ts));

end

