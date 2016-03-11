x=[8.5 7.6 9.3 5.5 11.4 6.9 6.5 12.9 8.7 4.8 4.2 8.1 6.5 5.8 6.7 2.4 11.1 7.1 8.8 7.2];
subplot(211)
boxplot(x); grid on;
m = sum(x)/length(x) %7.5000
md = median(x) %7.1500
s = std(x) %2.5068
subplot(212)
hist(x); grid on;
title(['mean=',num2str(m),' median=',num2str(md),' std=',num2str(s)]);

print -depsc cw08.eps
