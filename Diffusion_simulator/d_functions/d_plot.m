function  d_plot(x,ADC,msd,ts,in,p,type,row,max_rows)
% function  d_plot(x,ADC,msd,p)
%
% Plots in a standard way

x_col = [255,197,1]./255;
y_col = [188,14,76]./255;
p_col = [53,79,96]./255;
l_width = 2;
font_size = 20;
smooth_f = 5;


if row == 1
    no = [1,2,3];
elseif row == 2
    no = [4,5,6];
elseif row == 3
    no = [7,8,9];
end

subplot(max_rows,3,no(1)) %Particles
scatter(x(:,1),x(:,2),1,p_col);
if strcmp(type,'free')
    hold on
    axis equal
    xlim([-50e-6 50e-6])
    ylim([-50e-6 50e-6])
    axis square

    axis off
    
elseif strcmp(type, 'hindered')
    hold on;
    for k = 1:size(p.r0,1) %Plot cicles as restrictions
        pos = [([p.r0(k,1) p.r0(k,2)]-p.r) 2*p.r 2*p.r];
        rect = rectangle('Position',pos,'Curvature',[1 1], 'FaceColor', 'none', 'Edgecolor','black');
    end
    axis equal
    axis off
    
elseif strcmp(type,'restricted')
    hold on
    
    axis equal
    ylim([-0.3e-4 0.7e-4])
    xlim([0.5e-4 5.5e-4])
    axis off
end


subplot(max_rows,3,no(2)) %MSD
hold on
plot(in.t(1:ts)*1e3,msd(1:ts,1)*1e12,'Color',x_col,'Linewidth',l_width)
plot(in.t(1:ts)*1e3,msd(1:ts,2)*1e12,'Color',y_col,'Linewidth',l_width)

ylim([0 2000])
xlim([0 in.T*1e3])
ax = gca; ax.FontSize = font_size;
xticks([0 250 500])
yticks([0 1000 2000])
ax.TickLength = [0.02 0.02];
set(ax,'tickdir','out'); set(ax,'linewidth',2); set(gca,'box','off')
axis square;


subplot(max_rows,3,no(3)) %ADC
hold on
plot(in.t(1:ts)*1e3,smooth(ADC(1:ts,1),smooth_f)*1e9,'Color',x_col,'Linewidth',l_width)
plot(in.t(1:ts)*1e3,smooth(ADC(1:ts,2),smooth_f)*1e9,'Color',y_col,'Linewidth',l_width)

ylim([0 3])
xlim([0 in.T*1e3])
ax = gca; ax.FontSize = font_size;
xticks([0 250 500])
yticks([0 1 2 3])
ax.TickLength = [0.02 0.02];
set(ax,'tickdir','out'); set(ax,'linewidth',2); set(gca,'box','off')
axis square;


drawnow;



end

