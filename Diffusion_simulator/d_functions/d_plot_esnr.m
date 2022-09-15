function  d_plot_esnr(x_f,ADC_f,x_r,ADC_r,ts,in,f,r)
% function  d_plot_esnr(x_f,ADC_f,x_r,ADC_r,ts,in,f,r)
%
% Plots for ESNR 2022 presentation

x_col = [255,197,1]./255;
y_col = [188,14,76]./255;
p_col = [53,79,96]./255;
l_width = 2;
font_size = 20;
smooth_f = 5;


subplot(1,3,1) %Particles
scatter(x_f(:,1),x_f(:,2),1,x_col);
hold on
axis equal
xlim([-25e-5 25e-5])
ylim([-25e-5 25e-5])
axis square

axis off


subplot(1,3,2)
scatter(x_r(:,1),x_r(:,2),1,y_col);
hold on
axis equal
ylim([-0.3e-4 0.7e-4])
xlim([0.5e-4 5.5e-4])
axis off


subplot(1,3,3) %ADC restricted and free
hold on
plot(in.t(1:ts)*1e3,smooth(ADC_r(1:ts,2),smooth_f)*1e9,'Color',y_col,'Linewidth',l_width)
plot(in.t(1:ts)*1e3,smooth(ADC_f(1:ts,2),smooth_f)*1e9,'Color',x_col,'Linewidth',l_width)

ylim([0 3])
xlim([0 in.T*1e3])
ax = gca; ax.FontSize = font_size;
xticks([0 250 500])
yticks([0 1 2 3])
ax.TickLength = [0.02 0.02];
set(ax,'tickdir','out'); set(ax,'linewidth',2); set(gca,'box','off')
axis square;

set(gcf,'Color','w');
drawnow;



end

