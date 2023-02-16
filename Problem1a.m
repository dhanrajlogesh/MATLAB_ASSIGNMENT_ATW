PAM = [-15,-13,-11,-9,-7,-5,-3,-1,1,3,5,7,9,11,13,15];
Total_error = 0;
samples = 100000;
counter = 0;
mu = 0;
sigma = 1;
for s = (5:4:80)
Total_error = 0;
for i = (0:samples)
x1 = PAM(randi(numel(PAM)));
x2 = PAM(randi(numel(PAM)));
x3 = PAM(randi(numel(PAM)));
h1 = (sigma.*randn(1)+mu)+ 1i*(sigma.*randn(1)+mu);
h2 = (sigma.*randn(1)+mu)+ 1i*(sigma.*randn(1)+mu);
h3 = (sigma.*randn(1)+mu)+ 1i*(sigma.*randn(1)+mu);
w1 = (sigma.*randn(1)+mu)+ 1i*(sigma.*randn(1)+mu);
w2 = (sigma.*randn(1)+mu)+ 1i*(sigma.*randn(1)+mu);
w3 = (sigma.*randn(1)+mu)+ 1i*(sigma.*randn(1)+mu);
x = [x1,0,0;0,x2,0;0,0,x3];
h = [h1,h2,h3];
w = [w1,w2,w3];
theta = sqrt(1/5 * db2mag(s));
y = theta*h*x + w;
minerr = intmax;
detectPAM = 0;
for j = (1:16)
dist = norm(y - theta*h*PAM(j));
if dist < minerr
minerr = dist;
detectedPAM = j;
end
end
if x ~= PAM(detectedPAM)
Total_error = Total_error +1;
end
end
counter = counter +1;
Perror(counter) = Total_error / samples;
end
semilogy(5:4:80, Perror);
title('Monte-Carlo Simulations')
xlabel('SNR')
ylabel('Probability of error')
