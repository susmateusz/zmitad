clear; close;
pkg load statistics;

x=[randn(300,1)+1,gen1(1,300),gen2(1,300),gen3(1,300)];
f = figure(1);
subplot(221);
[NN,XX]=hist(x(:,1));
bar(XX,NN/sum(NN)); grid on;
[m,s] = stat(x(:,1));
title(['Randn. m=',num2str(m),'; s=',num2str(s)]);

subplot(222);
[NN,XX]=hist(x(:,2));
bar(XX,NN/sum(NN)); grid on;
[m,s] = stat(x(:,2));
title(['Gen1. m=',num2str(m),'; s=',num2str(s)]);

subplot(223);
[NN,XX]=hist(x(:,3));
bar(XX,NN/sum(NN)); grid on;
[m,s] = stat(x(:,3));
title(['Gen2. m=',num2str(m),'; s=',num2str(s)]);

subplot(224);
[NN,XX]=hist(x(:,4));
bar(XX,NN/sum(NN)); grid on;
[m,s] = stat(x(:,4));
title(['Gen3. m',num2str(m),'; s=',num2str(s)]);

print -depsc cw04.eps

