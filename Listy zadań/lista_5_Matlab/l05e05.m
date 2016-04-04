close; clear;
fprintf('Lista 5. Cwiczenie 5.');
%% dane
M = csvread('../Dane/dane do list 3-5/koronografia.csv',1);
grupa1 = M(1:8,1);
grupa2 = M(9:size(M,1),1);
alfa = 0.1;
%% hipotezy
% h0: \theta == 0, czas cwiczenia zalezy od stanu zdrowia
% h1: \theta != 0, czas cwiczenia niezalezy od stanu zdrowia
%% testy graficzne
figure(5);

subplot(231);
qqplot(grupa1); grid on; grid minor;
subplot(232);
qqplot(grupa1,grupa2); grid on; grid minor;
subplot(233);
qqplot(grupa2); grid on; grid minor;

subplot(212);
boxplot(M(:,1),M(:,2)); grid on; grid minor;
%% testowanie, czy probki naleza do tego samego rozkladu
mwwtest(grupa1,grupa2);
% wniosek - nie, za�o�enie nie jest spe�nione

%% test znakow
[p,h,stats] = ranksum(grupa1,grupa2,'alpha',alfa)
% p =    0.0250
% h =     1
% stats =     ranksum: 101
% odrzucono h0, przyj�to h1, mediany czas�w �wiczenia w grupach by�y r�ne
median(grupa1)
median(grupa2)
% poprawka: za�o�enia testu nie s� spe�nione, pr�bki pochodz� z r�nych
% rozk�ad�w