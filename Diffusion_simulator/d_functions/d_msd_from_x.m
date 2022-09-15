function msd = d_msd_from_x(x,x_init)
% function msd = d_msd_from_x(x,x_init)
%   
% Mean squared displacement

msd(:,1) = mean((x(:,1)-x_init(:,1)).^2); %mean square displacement in x
msd(:,2) = mean((x(:,2)-x_init(:,2)).^2); %mean square displacement in y

end

