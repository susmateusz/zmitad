pkg load statistics;
% zalozona warotsc wariancji
u=1.6;
%srednia
m=100;
v = 1.5;
n = 25;
x = normrnd(m, v, n, 1);
% hipotezy
% h0: u<1.6 - wariancja rozkladu czasu montowania elementow jest mniejsza od 1.6 minuty
% h1: u>=1.6 - wariancja rozkladu czasu montowania elementow jest niemniejsza od 1.6 minuty
% a1=0.05 - poziom istotnosci 1. testu
% a2=0.1 - poziom istotnosci 2. testu
% testowanie jednostronne - parametr 'left', bo test sprawdza, czy wariancja jest mniejsza
%test
disp("poziom istotnosci: a=0.05");
[h,pval,ci,stats] = vartest(x,u,'tail','left')
disp("poziom istotnosci: a=0.01");
[h,pval,ci,stats] = vartest(x,u,'tail','left','alpha',0.1)


%Wnioski
% h0 nie zostala odrzucona nie ma podstaw do sadzenia, ze wariancja nie jest mniejsza od 1.6
% roznice poziomu istotnosci wplywaja jedynie na przedzial ufnosci,(mniejszy)
