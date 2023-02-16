num_fadings = 10000; % Number of fading realizations
SNR_dB_vec = -10:1:30; % Vector of SNR values in dB
SNR_vec = 10.^(SNR_dB_vec/10); % Vector of SNR values in linear scale
R = 2; % Target rate in bits/channel use
% Generate fading coefficients
h = sqrt(1/2)*(randn(num_fadings,1) + 1i*randn(num_fadings,1));
% Compute the ergodic capacity for each SNR value
C = zeros(length(SNR_vec),1);
for i = 1:length(SNR_vec)
   SNR = SNR_vec(i);
   C(i) = mean(log2(1 + SNR*R*abs(h).^2)); % Ergodic capacity
end
% Compute the outage probability for each SNR value
Pout = zeros(length(SNR_vec),1);
for i = 1:length(SNR_vec)
   SNR = SNR_vec(i);
   Pout(i) = mean(log2(1 + SNR*abs(h).^2) < R); % Outage probability
end
% Plot the results
figure;
subplot(2,1,1);
plot(SNR_dB_vec, C);
xlabel('SNR (dB)');
ylabel('Ergodic Capacity (bits/channel use)');
subplot(2,1,2);
semilogy(SNR_dB_vec, Pout);
xlabel('SNR (dB)');
ylabel('Outage Probability');
ylim([1e-5 1]);
