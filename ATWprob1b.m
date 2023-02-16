sigma_w2 = 6;
Mont = 1e6;
SNR_max = 66;
SNR_start = -9;
SNR_step = 4;
Error_sum = zeros(1,length(SNR_start:SNR_step:SNR_max));
for i = 0:15
   const(i+1) = qammod(i,16);
end
for SNR = SNR_start:SNR_step:SNR_max
   P = 10^(SNR/10)*sigma_w2;
   % theta = 1/sqrt(10)*sqrt(P);
   theta = 1/sqrt((16^2-1)/3)*sqrt(P);
   for k = 1:Mont
       H = (randn(1,3)+1i*randn(1,3))/sqrt(2);
       s1 = const(randperm(16,1));
       s2 = const(randperm(16,1));
       s3 = const(randperm(16,1));
       xtr = theta*[s1,0,0;0,s2,0;0,0,s3];
       n = sqrt(sigma_w2)*((randn(1,3)+1i*randn(1,3))/sqrt(2));
       y = H*xtr+n;
       x1_hat = (y(1)/H(1,1))/theta;
       x2_hat = (y(2)/H(1,2))/theta;
       x3_hat = (y(3)/H(1,3))/theta;
       diff1 = abs(real(x1_hat-const(1)));
       diff2 = abs(real(x2_hat-const(1)));
       diff3 = abs(real(x3_hat-const(1)));
       idx1 = 1;
       idx2 = 1;
       idx3 = 1;
       % We are doing hard decision here. Our assumption is that this is
       % essentially the same as using the ML rule.
       for i = 2:length(const)
           if abs(real(x1_hat-const(i)))<diff1
               diff1 = abs(real(x1_hat-const(i)));
               idx1 = i;
           end
           if abs(real(x2_hat-const(i)))<diff2
               diff2 = abs(real(x2_hat-const(i)));
               idx2 = i;
           end
           if abs(real(x3_hat-const(i)))<diff3
               diff3 = abs(real(x3_hat-const(i)));
               idx3 = i;
           end
       end
       x1_hat = const(idx1);
       x2_hat = const(idx2);
       x3_hat = const(idx3);
       Error_sum((SNR-SNR_start)/SNR_step+1) = Error_sum((SNR-SNR_start)/SNR_step+1) + ((x1_hat~=s1) + (x2_hat~=s2) + (x3_hat~=s3));
   end
end
P_err = Error_sum./(2*Mont);
figure('NumberTitle','off','Name','Problem 1, 1.')
semilogy(SNR_start:SNR_step:SNR_max,P_err)
hold on
[ber,ser] = berfading((SNR_start-10*log(2):SNR_step:SNR_max-10*log(2)),'pam',16,1);
semilogy(SNR_start:SNR_step:SNR_max,ser,'r')
legend('Empirical P_{err}','Theoretical P_{err}')
xlabel('SNR [dB]')
ylabel('P_{err}')
title('Probability error Perr vs SNR for s1,s2,s3');
xlim([SNR_start SNR_max])
grid on