load('Undulation_data.mat')


c_1_harm = [14,167,181]./255;
c_n_harm = [255,190,79]./255;
c_stocha = [232,112,42]./255;

clf;
figure(10)
plot([0 100],[0 100],'--','Color',pl_color('line'),'Linewidth',10,'HandleVisibility','off')
hold on
plot(f_delta_pred_1_harm,f_delta_est_1_harm,'.','Markersize',80,'Color',c_1_harm);
plot(f_delta_pred_n_harm,f_delta_est_n_harm,'.','Markersize',80,'Color',c_n_harm);
plot(f_delta_pred_stoch,f_delta_est_stoch,'.','Markersize',80,'Color',c_stocha);

xlim([0 100])
ylim([0 100])
yticks([0 50 100])
xticks([0 50 100])

ylabel('Estimated {\itf}_{\Delta}')
xlabel('Predicted {\itf}_{\Delta}')

plot_set_1x3;
legend({'1-harmonic','n-harmomic','stochastic'},'location','southeast','Fontsize',30)
hold on

figure(20)
plot([0 1.1],[0 1.1],'--','Color',pl_color('line'),'Linewidth',10)
hold on
plot(D_hi_pred*1e9,D_hi_est*1e9,'.','Markersize',80,'Color',c_1_harm)
plot(D_hi_pred_n_harm*1e9,D_hi_est_n_harm*1e9,'.','Markersize',80,'Color',c_n_harm)
plot(D_hi_pred_stoch*1e9,D_hi_est_stoch*1e9,'.','Markersize',80,'Color',c_stocha)

xlim([0 1.1])
ylim([0 1.1])
yticks([0 0.5 1])
xticks([0 0.5 1])

ylabel('Estimated {\itD}_{hi} [μm^2/ms]')
xlabel('Predicted {\itD}_{hi} [μm^2/ms]')

plot_set_1x3;
legend off;



