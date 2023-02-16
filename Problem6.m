% case 1 : log2(1+SNR) is approximately equal to log2(SNR) for high SNR
clc;
snr = 0:0.1:100;
x1 = log2(1 + snr);
x2 = log2(snr);
% PLOT Function
figure(1);
plot(snr(snr>1), x1(snr>1), 'b',snr(snr>1), x2(snr>1), 'r', 'LineWidth', 2); %%(snr>1) is chosen to keep the snr positive
grid on;
legend('log2(1+snr)', 'log2(snr)');
xlabel('SNR (dB)');
ylabel('Difference');
title('Validity of Assumptions "log2(1+snr) is approximately equal to log2(snr)" for high values of snr');
% case2: log2(1+SNR) is approximately equal to snr*log2(e) for low values of SNR
snr = 0:0.1:1;
x1 = log2(1 + snr);
x3 = snr * log2(exp(1));
% PLOT Function
figure(2);
plot(snr, x1, 'b', snr, x3, 'r', 'LineWidth', 2);
grid on;
legend('log2(1+snr)', 'snr*log2(e)');
xlabel('SNR(dB)');
ylabel('Difference');
title('Validity of Assumptions "log2(1+snr) is approximately equal to SNR*log2(e)" for low values of snr');
