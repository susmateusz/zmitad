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
%% testowanie hipotezy
disp('funkcja ttest');
[h, pval, ci, stats] = ttest(x,u,'alpha',0.01)
disp('funkcja tcdf');
xbar = mean(x);  % Sample mean
s = std(x);      % Sample standard deviation
t = (xbar - m)/(s/sqrt(n));
p = 1-tcdf(t,n-1)


%% Wnioski
% ttest:
% h=1 - hipoteze h0 odrzucono
% pval=3.12e-04
% tcdf:
% p=0.83 - wartosc wieksza od a, czyli duze prawdopodobienstwo
