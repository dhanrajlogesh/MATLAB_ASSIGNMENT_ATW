close all
clear
samples = 1e5; %MonteCarlo
SNR = 0:0.5:10; %dB
P1=zeros(1, length(SNR));
P2=zeros(1, length(SNR));
P3=zeros(1, length(SNR));
P4=zeros(1, length(SNR));
%P5=zeros(1, length(SNR));
for j=1:samples
   %case 1
   for SNRi = 1:length(SNR)
       h1=(randn(1,1)+randn(1,1)*sqrt(-1))/sqrt(2);
       h2=(randn(1,1)+randn(1,1)*sqrt(-1))/sqrt(2);
        
       h = [h1 h2].';
       if (sum(abs(h).^2)*10^(SNR(SNRi)/10)<1)
           P1(SNRi)=P1(SNRi)+1;
       end
  end
   %case 2
   for SNRi = 1:length(SNR)
       h1=(randn(1,1)+randn(1,1)*sqrt(-1))/sqrt(2);
       h2=(randn(1,1)+randn(1,1)*sqrt(-1))/sqrt(2);
       h3=(randn(1,1)+randn(1,1)*sqrt(-1))/sqrt(2);
      
       h = [h1 h2 h3].';
       if (sum(abs(h).^2)*10^(SNR(SNRi)/10)<1)
           P2(SNRi)=P2(SNRi)+1;
       end
   end
   %case 3
   for SNRi = 1:length(SNR)
       h = [];
       for loop=1:5
           h = (randn(1,1)+randn(1,1)*sqrt(-1))/sqrt(2);
       end
       if (sum(abs(h).^2)*10^(SNR(SNRi)/10)<1)
           P3(SNRi)=P3(SNRi)+1;
       end
   end
   %case 4
   for SNRi = 1:length(SNR)
       h1=(randn(1,1)+randn(1,1)*sqrt(-1))/sqrt(2);
       h = [];
       for loop=1:5
           h = [h h1];
       end
       if (sum(abs(h).^2)*10^(SNR(SNRi)/10)<1)
           P4(SNRi)=P4(SNRi)+1;
       end
   end
end
P1=P1./samples;
P2=P2./samples;
P3=P3./samples;
P4=P4./samples;
%P5=P5./samples;
figure();
semilogy(SNR, P1);
hold on
semilogy(SNR, P2);
hold on
semilogy(SNR, P3);
hold on
semilogy(SNR, P4);
hold on
ylabel('Probability of deep fade');
xlabel('SNR (dB)');
grid on;
lgd=legend('2x1', '3x1', '5x1', '5x1 (all the same)');
set(lgd,'Interpreter','latex');
