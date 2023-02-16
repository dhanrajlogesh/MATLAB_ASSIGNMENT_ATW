clc
clear
nFading = 100;
% Define SNR in dB and in linear scale
snrdB = -10:1:30;
snr = 10.^(snrdB/10);
% Defining the fading coefficient with mean 0 and variance 1/2
h = (randn(nFading, 1) + 1i * randn(nFading, 1))*(sqrt(2));
% Calculating the instantaneous capacity from the formula
C = log2(1+abs(h).^2*snr);
% Plotting of C vs SNR
figure(1)
plot(snrdB, C);
title('Instantaneous capacity for different values of SNR and 100 fading realizations');
xlabel('SNR [dB]');
ylabel('Capacity [bits/channel use]');
