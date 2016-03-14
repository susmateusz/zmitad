close; clear;
disp('Lista 3. Ćwiczenie 15.');
%% dane
alfa=0.05;
%lek
xi=log([0.135, 23, 0.38, 106, 0.3, 106.2, 52.6, 1.9, 19.5, 5.8, 6.4]);
%placebo
yi=log([1.55, 1.15, 0.27, 0.64, 0.125, 105, 25, 0.8, 3.9, 1.2, 0.145]);
%% testowanie
% h0: wyniki z uzyciem leku/placebo ma rozkład normalny
% h1: wyniki z uzyciem leku/placebo nie ma rozkładu normalnego
%% testy Kołogomorowa-Smirnowa
[H,P,KSSTAT,CV] = kstest(xi);
fprintf('KSTEST dla leku:\n');
fprintf('H = %g, P = %g, KSSTAT = %g, CV = %g\n',H,P,KSSTAT,CV);
% output: H = 1, P = 0.000283619, KSSTAT = 0.596978, CV = 0.39122
% wniosek: Rozkład nie jest normalny

[H,P,KSSTAT,CV] = kstest(yi);
fprintf('KSTEST dla placebo:\n');
fprintf('H = %g, P = %g, KSSTAT = %g, CV = %g\n',H,P,KSSTAT,CV);
% output: H = 0, P = 0.777556, KSSTAT = 0.185967, CV = 0.39122
% wniosek: hipoteza o normalności rozkładu nie została odrzucona
%% testy Lillieforsa
[H,P,LSTAT,CV] = lillietest(xi);
fprintf('LILLIETEST dla leku:\n');
fprintf('H = %g, P = %g, LSTAT = %g, CV = %g\n',H,P,LSTAT,CV);
% output: H = 0, P = 0.5, LSTAT = 0.147622, CV = 0.2515
% wniosek: hipoteza o normalności rozkładu nie została odrzucona

[H,P,LSTAT,CV] = lillietest(yi);
fprintf('LILLIETEST dla placebo:\n');
fprintf('H = %g, P = %g, LSTAT = %g, CV = %g\n',H,P,LSTAT,CV);
% output: H = 0, P = 0.5, LSTAT = 0.147622, CV = 0.2515
% wniosek: hipoteza o normalności rozkładu nie została odrzucona
%% testy Shapiro-Wilka
[H, pValue, W] = swtest(xi, alfa);
fprintf('SWTEST dla leku:\n');
fprintf('H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.344267, W = 0.922982
% wniosek: hipoteza o normalności rozkładu nie została odrzucona

[H, pValue, W] = swtest(yi, alfa);
fprintf('SWTEST dla placebo:\n');
fprintf('H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.253474, W = 0.911416
% wniosek: hipoteza o normalności rozkładu nie została odrzucona
%% testy TTEST
[H,P] = ttest(xi, mean(xi));
fprintf('TTEST dla leku:\n');
fprintf('H = %g, P = %g\n',H,P);
% output: H = 0, P = 1
% wniosek: hipoteza o normalności rozkładu nie została odrzucona

[H,P] = ttest(yi, mean(yi));
fprintf('TTEST dla leku:\n');
fprintf('H = %g, P = %g\n',H,P);
% output: H = 0, P = 1
% wniosek: hipoteza o normalności rozkładu nie została odrzucona
%% wnioski:
% Dla wszystkich prób prócz kstestu dla leku hipotezy h0 nie zostały
% odrzucone. p-value znacząco się różniły. Skala logarytmiczna
% prawdopodobnie nie ma wpływu negatywnego na wyniki badań, w przypadku
% logarytmicznego charakteru badanego zjawiska pozwala ona na wykonywanie
% badań przy mniejszej i bardziej miarodajnej wariancji.