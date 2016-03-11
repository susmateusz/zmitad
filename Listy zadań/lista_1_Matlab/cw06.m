clear; close;
pkg load statistics;

mean=3;
stdev=7;
x=sqrt(stdev).*randn(100,1)+mean;
f = figure(1);
subplot(211);
plot(x);
subplot(212);
hist(x);
print -depsc cw06.eps
