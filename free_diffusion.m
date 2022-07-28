clear
clf

%Parameters
r = 1e-5; %radius of circular restriction

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

x = [unifrnd(-r,+r,p,1), unifrnd(-r,+r,p,1)];
dd = sqrt(x(:,1).^2 + x(:,2).^2);
ind = find(dd > r-r*0.05);
x(ind,:) = [];



for ts = 1:n
    x = x + randn(size(x,1),2) * dx; %Simulation step
    
    if ts == 1
        x_init = x(:,1); %record initial position along x
        y_init = x(:,2); %record initial position along y
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
        scatter(x(:,1),x(:,2),1,p_col);
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