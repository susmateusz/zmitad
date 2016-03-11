clear; close;
pkg load statistics;

mean=3;
stdev=7;
x=sqrt(stdev).*randn(100,1)+mean;

a=sum(abs(x)<2)/length(x)
%0.32

