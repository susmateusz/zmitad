pkg load statistics;
m1=27.7;
s1=5.5;
n1=20;
m2=32.1;
s2=6.3;
n2=22;

x1=normrnd(m1,s1,n1,1);
x2=normrnd(m2,s2,n2,1);

[h, pval, ci, stats]=vartest2(x1,x2)
