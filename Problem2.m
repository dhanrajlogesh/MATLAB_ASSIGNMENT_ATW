close all
clear
samples = 1e5; %MonteCarlo
SNR = 0:0.5:10; %dB
P1=zeros(1, length(SNR));
P2=zeros(1, length(SNR));
P3=zeros(1, length(SNR));
for j=1:samples
   %case 1
   for SNRi = 1:length(SNR)
       h1=(randn(1,1)+randn(1,1)*sqrt(-1))/sqrt(2);
       h2=(randn(1,1)+randn(1,1)*sqrt(-1))/sqrt(2);
       h3=(randn(1,1)+randn(1,1)*sqrt(-1))/sqrt(2);
       h4=(randn(1,1)+randn(1,1)*sqrt(-1))/sqrt(2);
        
       h = [h1 h2 h3 h4];
       if (sum(abs(h).^2)*10^(SNR(SNRi)/10)<1)
           P1(SNRi)=P1(SNRi)+1;
       end
  end
   %case 2
   for SNRi = 1:length(SNR)
       h1=(randn(1,1)+randn(1,1)*sqrt(-1))/sqrt(2);
       h4=h1*(randn(1,1)+randn(1,1)*sqrt(-1))/sqrt(2);
      
       h = [h1 h4];
       if (sum(abs(h).^2)*10^(SNR(SNRi)/10)<1)
           P2(SNRi)=P2(SNRi)+1;
       end
   end
   %case 3
   for SNRi = 1:length(SNR)
       h1=(randn(1,1)+randn(1,1)*sqrt(-1))/sqrt(2)*sqrt(10);
       h4=(h1+(randn(1,1)+randn(1,1)+randn(1,1)*sqrt(-1))/sqrt(2)*sqrt(10))/3;
      
       h = [h1 h4];
       if (sum(abs(h).^2)*10^(SNR(SNRi)/10)<1)
           P3(SNRi)=P3(SNRi)+1;
       end
   end
end
P1=P1./samples;
P2=P2./samples;
P3=P3./samples;
figure('NumberTitle','off','Name','Problem 2, case 1,2,3');
semilogy(SNR, P1);
hold on
semilogy(SNR, P2);
hold on
semilogy(SNR, P3);
ylabel('Probability of deep fade')
xlabel('SNR (dB)')
grid on;
lgd=legend('$h_2=h_4$', '$h_4=h_1 h_3$', '$h_4 =\frac{1}{3}(h_1+h_2+h_3)$');
set(lgd,'Interpreter','latex');
