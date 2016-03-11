clear; close;
pkg load statistics;

x=randn(300,1);
f = figure(1);
subplot(221);
plot(x);
title("300 elementowa probka"); grid on; grid minor;
subplot(222);
boxplot(x,1);
title("boxplot"); grid on;
subplot(223);
hist(x,20);
title("histogram - 20 prostokatow"); grid on; grid minor;
subplot(224);
hist(x,100);
title("histogram - 100 prostokatow"); grid on; grid minor;
print -depsc cw03.eps
