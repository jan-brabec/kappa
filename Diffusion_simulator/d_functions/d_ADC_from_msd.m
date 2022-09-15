function ADC = d_ADC_from_msd(msd,tp)
% ADC = d_ADC_from_msd(msd,t_pt);
%
% ADC from MSD

ADC(:,1) = 1/2 * msd(:,1)/tp; %apparent diffusion coeffiecient in x
ADC(:,2) = 1/2 * msd(:,2)/tp; %apparent diffusion coeffiecient in y

end

