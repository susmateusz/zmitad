pkg load statistics;
%% funkcja testujaca hipoteze z uzyciem ttestu
%% parametry
% hipoteza sredniej - zalozona wartosc srednia rozkladu
u = 49;     
% wartosc srednia zmierzonej proby
m = 38;
% odchylenie standardowe zmierzonej proby
s = 15;
% dlugosc zmierzonej proby
n = 18;
% poziom istotnosci
a = 0.01;
%% generowanie proby - normrnd( srednia, odchylenie std, rows, cols)
x = normrnd(m, s, n, 1);
% hipoteza
% h0: u=49 - ceny gruntu wzrosly przecietnie o 49%
% h1: u!=49 - przecietny wzrost cen gruntu jest różny od 49%
% a=0.01 - poziom istotnosci
% testowanie dwustronne

%% testowanie hipotezy
disp('funkcja ttest');
[h, pval, ci, stats] = ttest(x,u,'alpha',0.01)
disp('funkcja tcdf');
xbar = mean(x);  % Sample mean
s = std(x);      % Sample standard deviation
t = (xbar - u)/(s/sqrt(n));
p = tcdf(t,n-1)
2*p

%% Wnioski
% dla obu testów wartość statystki jest taka sama
