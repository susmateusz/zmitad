pkg load statistics;
% zalozona warotsc wariancji
u=1.6;
%srednia
m=100;
v = 1.5;
n = 25;
x = normrnd(m, v, n, 1);
%test
disp("poziom istotnosci: a=0.05");
[h,pval,ci,stats] = vartest(x,u,'tail','left')
disp("poziom istotnosci: a=0.01");
[h,pval,ci,stats] = vartest(x,u,'tail','left','alpha',0.1)


%Wnioski
% h0 nie zostala odrzucona, roznice poziomu istotnosci wplywaja jedynie na przedzial ufnosci,(mniejszy)
