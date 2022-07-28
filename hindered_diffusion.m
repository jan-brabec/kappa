clear


%Parameters
r = 1e-5; %radius of circular restriction
dist = 2.5; %distance from restrictions
n_c = 16; %number of restrictions

D0 = 2e-9;   %bulk diffusion coefficient
p = 1e5;     %number of particles
T = 500*1e-3;% max time
no_T = 1001;

%Init time
t = linspace(0,T,no_T); %time
dt = t(2) - t(1);
n = round(T / dt);
msd_x = zeros(no_T,1);
msd_y = zeros(no_T,1);
ADC_x = zeros(no_T,1);
ADC_y = zeros(no_T,1);

dx = sqrt(2*D0*dt); %stepping

%Init restriction
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



for ts = 1:n
    x = x + randn(size(x,1),2) * dx; %Simulation step
    
    if ts == 1
        x_init = x(:,1); %record initial position along x
        y_init = x(:,2); %record initial position along y
    end
    
    %     Restrictions
    for cs = 1:size(r0,1) %for all individual restrictions separately
        x_all = x(:,1); y_all = x(:,2);
        x0 = r0(cs,1); y0 = r0(cs,2);
        pdx_all = x_all - x0; pdy_all = y_all - y0;
        
        dd = sqrt(pdx_all.^2 + pdy_all.^2);
        ind = find(dd < r);
        
        for ps = 1:numel(ind) %for all particles separately
            x0 = r0(cs,1); y0 = r0(cs,2);
            xa = x(ind(ps),1); ya = x(ind(ps),2);
            pdx = (xa-x0); pdy = (ya-y0);
            
            theta = atan2(pdy,pdx);
            ro = r - sqrt(pdx^2+pdy^2); %overshoot
            
            x(ind(ps),1) = xa + (2 * ro * cos(theta));
            x(ind(ps),2) = ya + (2 * ro * sin(theta));
        end
    end
    
    msd_x(ts) = mean((x(:,1)-x_init).^2); %mean square displacement in x
    msd_y(ts) = mean((x(:,2)-y_init).^2); %mean square displacement in y
    ADC_x(ts) = 1/2 * msd_x(ts)/t(ts); %apparent diffusion coeffiecient in x
    ADC_y(ts) = 1/2 * msd_y(ts)/t(ts); %apparent diffusion coeffiecient in y
        
    if (0)
        %PLOT
        clf;

        x_col = [255,197,1]./255;
        y_col = [188,14,76]./255;
        p_col = [53,79,96]./255;
        l_width = 2;
        font_size = 20;
        smooth_f = 5;
        
        subplot(1,3,1) %particles
        hold on;
        %Cicles
        for k = 1:size(r0,1)
            pos = [([r0(k,1) r0(k,2)]-r) 2*r 2*r];
            rect = rectangle('Position',pos,'Curvature',[1 1], 'FaceColor', 'none', 'Edgecolor','black');
        end
        scatter(x(:,1),x(:,2),1.5,p_col);
        axis equal
        axis off
        
        subplot(1,3,2) %msd
        hold on
        plot(t(1:ts)*1e3,msd_x(1:ts)*1e12,'Color',x_col,'Linewidth',l_width)
        plot(t(1:ts)*1e3,msd_y(1:ts)*1e12,'Color',y_col,'Linewidth',l_width)
        ylim([0 2000])
        xlim([0 T*1e3])
        ax = gca; ax.FontSize = font_size;
        xticks([0 250 500])
        yticks([0 1000 2000])
        ax.TickLength = [0.02 0.02];
        set(ax,'tickdir','out'); set(ax,'linewidth',2); set(gca,'box','off')
        axis square;        
                
        subplot(1,3,3) %ADC
        hold on
        plot(t(1:ts)*1e3,smooth(ADC_x(1:ts),smooth_f)*1e9,'Color',x_col,'Linewidth',l_width)
        plot(t(1:ts)*1e3,smooth(ADC_y(1:ts),smooth_f)*1e9,'Color',y_col,'Linewidth',l_width)
        ylim([0 3])
        xlim([0 T*1e3])
        ax = gca; ax.FontSize = font_size;
        xticks([0 250 500])
        yticks([0 1 2 3])
        ax.TickLength = [0.02 0.02];
        set(ax,'tickdir','out'); set(ax,'linewidth',2); set(gca,'box','off')
        axis square;        
        
        drawnow;
        hold off
    end
end