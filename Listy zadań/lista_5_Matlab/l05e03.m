close; clear;
fprintf('Lista 5. Cwiczenie 3.');
%% dane
M = csvread('../Dane/dane do list 3-5/chmiel.csv',1);
zapylone = M(:,1);
niezapylone = M(:,2);
%% hipotezy
% h0: \theta == 0, probki pochodza z rozkladow o takich samych medianach
% zapylenie nie ma wp³ywu na mase nasion
% h1: \theta != 0, probki pochodza z rozkladow o roznych medianach -
% zapylenie ma wplyw na mase nasion
%% testy graficzne
figure(2);

subplot(231);
qqplot(zapylone); grid on; grid minor;
subplot(232);
qqplot(zapylone,niezapylone); grid on; grid minor;
subplot(233);
qqplot(niezapylone); grid on; grid minor;

subplot(223);
boxplot([zapylone,niezapylone]); grid on; grid minor;
subplot(224);
boxplot(zapylone-niezapylone); grid on; grid minor;
%% ttest
%% testowanie, czy probki naleza do tego samego rozkladu
mwwtest(zapylone, niezapylone);
% wniosek - hipoteza h0 zosta³a odrzucona, probki nale¿¹ do ró¿nych
% rozk³adów

%% test znakow
[p,h,stats] = ranksum(zapylone,niezapylone,'alpha',0.05)
% p =  5.8275e-04
% h =   1
% ranksum: 77
% badane sa nie 2 testy jednej probki, ale testy 2 roznych probek. Badane
% jest to, czy rozklady ich mas maja jednakowe mediany. Hipoteza ta zostaje
% odrzucona - czyli zapylenie ma wplyw na mase
% Poprawka: za³o¿enie o próbkach z tego samego rozk³adu nie jest spe³nione,
% wyniki nie s¹ miarodajne