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

subplot(221);
qqplot(grupa1); grid on; grid minor;
subplot(222);
qqplot(grupa2); grid on; grid minor;

subplot(212);
boxplot(M(:,1),M(:,2)); grid on; grid minor;
%% ttest
[h,p] = swtest(grupa1)  % rozk³ad jest normalny
[h,p] = swtest(grupa2)  % rozk³ad nie jest normalny
[h,p,c,s] = ttest2(grupa1,grupa2) % nie odrzucono h0, ale za³o¿enia niespe³nione

%% test znakow
[p,h,stats] = ranksum(grupa1,grupa2,'alpha',alfa)
% p =    0.0250
% h =     1
% stats =     ranksum: 101
% odrzucono h0, przyjêto h1, mediany czasów æwiczenia w grupach by³y ró¿ne
median(grupa1)
median(grupa2)