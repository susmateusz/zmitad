clear; close;
pkg load statistics;

x1=2*(randn(100,1)+1);
x2=3*(randn(100,1)-1);
z=[x1 x2];
f = figure(1);
subplot(211);
boxplot(z,1);
subplot(212);
hist(z);
print -depsc cw2.eps