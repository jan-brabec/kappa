clear all; clf; addpath('d_functions')


%in contains general diffusion variables
in.T = 500*1e-3;% max time
in.no_T = 1001; %number of time points
in.D0 = 2e-9;   %bulk diffusion coefficient
in.p = 1e5;     %number of particles
[in.dx,in.t,in.dt] = d_init_basics(in);

%f contains parameters related to free diffusion
f.r = 1e-5;    %radius where to initialize particles

%h contains parameters related to hindered diffusion
h.r = 1e-5;    %radius of circular restriction
h.dist = 2.5;  %distance between restrictions ratio
h.n_c = 16;    %number of restrictions

%r contains parameters related to restricted diffusion
r.r = 2e-5; %diameter of plane restriction

%Initialize particles before simulation
x_f        = d_init_x_free(f,in);
[x_h,h.r0] = d_init_x_hindered(h,in);
x_r        = d_init_x_restricted(r,in);

for ts = 1:in.no_T
    
    [ADC_f(ts,:),msd_f(ts,:),x_f] = d_sim_diff(x_f,in,f,ts,'free');
    [ADC_r(ts,:),msd_r(ts,:),x_r] = d_sim_diff(x_r,in,r,ts,'restricted');
%     [ADC_h(ts,:),msd_h(ts,:),x_h] = d_sim_diff(x_h,in,h,ts,'hindered');

    %Plot
%     d_plot(x_f,ADC_f,msd_f,ts,in,f,'free',1,2)
%     d_plot(x_r,ADC_r,msd_r,ts,in,r,'restricted',2,2)
%     d_plot(x_h,ADC_h,msd_h,ts,in,h,'hindered',3,3)

    d_plot_esnr(x_f,ADC_f,x_r,ADC_r,ts,in,f,r)
    
    
% %     Write as gif every 6th frame
    delay_time = 0.05;
    frame = getframe(gcf);
    img =  frame2im(frame);
    [img,cmap] = rgb2ind(img,256);
    
    if ts == 1
        imwrite(img,cmap,'Sim.gif','gif','LoopCount',Inf,'DelayTime',delay_time);
    elseif mod(ts,6)==0
        imwrite(img,cmap,'Sim.gif','gif','WriteMode','append','DelayTime',delay_time);
    end
    
end




