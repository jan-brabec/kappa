%run setup paths
clear; clf;

gwf_name = 'LTE';
% gwf_name = 'STE_CFC'; %or STE

%times
echo_time = 80e-3;
rf_time = 8e-3;
time_from_end_diff_to_echo = 10e-3;
diff_time = echo_time - 2*rf_time - time_from_end_diff_to_echo;


gwf_A = cell2mat(readcell(strcat(gwf_name,'_A.txt'))); %before 180
gwf_B = cell2mat(readcell(strcat(gwf_name,'_B.txt'))); %after 180

dt =  diff_time/size(cat(1,gwf_A,gwf_B),1);
% dt = dt *0.9; %tweak for STE

rf1 = zeros(round(rf_time/dt),3);
rf2 = zeros(round(rf_time/dt),3);
until_echo = zeros(round(time_from_end_diff_to_echo/dt),3);
gwf = cat(1,rf1,gwf_A,rf2,gwf_B,until_echo);
sz = size(cat(1,rf1,gwf_A,rf2,gwf_B,until_echo),1);
rf = ones(sz,1);
rf(size(cat(1,rf1,gwf_A,rf2),1):end) = -1;

% rf = 0.071 * rf; %for ste_CFC
rf = 0.0408* rf; %for LTE

opt = gwf_opt();
opt.gwf.gwf_linew = 1;
opt.gwf.plot_gmax = 90e-3;
opt.gwf.plot_t_rf_ex = [0; rf_time];
% opt.gwf.edge_col{1} = 'black';
% opt.gwf.edge_col{2} = 'black';
% opt.gwf.edge_col{3} = 'black';
opt.gwf.plot_t_rf_echo = [rf_time+diff_time/2; rf_time+diff_time/2+rf_time];
% opt.gwf.plot_t_te = echo_time;




% PLOT

% gwf_plot_all(gwf, rf, dt, opt) %this to check b-value
gwf_plot(gwf.*rf, rf, dt, opt);
ylim([- 60 60])
hold on
plot([-10 1000],[0 0],'Color','black','Linewidth',opt.gwf.gwf_linew)

ax = gca;
yticks([-60 -30 0 30 60])
xticks([0 20 40 60 80])
ax.FontSize = 15;
ax.TickLength = [0.01 0.01];
ax.FontWeight = 'normal';
ax.FontName  = 'Times';
xlabel('')
ylabel('')
xlim([0 85])
title('')
set(ax,'tickdir','out');
set(ax,'linewidth',1);
box off
legend off
% legend boxoff
% legend('g_x','g_y','g_z')
% legend('g_x')


print(gcf,'GWF.png','-dpng','-r500'); 
