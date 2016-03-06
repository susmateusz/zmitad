pkg load statistics;
%% funkcja testujaca hipoteze z uzyciem ttestu
%% parametry
% hipoteza sredniej - zalozona wartosc srednia rozkladu
u = 28;     
% wartosc srednia zmierzonej proby
mean_x = 31.5;
% odchylenie standardowe zmierzonej proby
s = 5;
% dlugosc zmierzonej proby
n = 100;
%% generowanie proby - normrnd( srednia, odchylenie std, rows, cols)
x = normrnd(mean_x, s, n, 1);
%% testowanie hipotezy
[h, pval, ci, stats] = ttest(x,u)


%% Wnioski
% h=1 - hipoteze h0 odrzucono
% pval=6.49e-06 - p-wartosc - miara prawdopodobienstwa odrzucenia prawdziwej hipotezy zerowej
% ci=1.44, 3.50 - przedzial ufnosci
% tstat=4.76 - wartosc testu statystycznego
% df = liczba stopni swobody (liczba niezaleznych obserwacji pomniejszona o liczbe zwiazkow
%        laczacych te obserwacje. Tutaj jest to n-1 gdyz estymujemy wartosc oczekiwana
% sd=5.29 - odchylenie standardowe probki
