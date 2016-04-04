close; clear;
fprintf('Lista 5. Cwiczenie 2.');
%% dane
M = csvread('../Dane/dane do list 3-5/czytelnictwo.csv',1);
przed = M(:,1);
po = M(:,2);
%% hipotezy
% h0: \theta == 0, zatrudnienie nie powoduje zmian w czytelnictwie
% h1: \theta != 0, zatrudnienie powoduje zmiany w czytelnictwie
%% testy graficzne
figure(2);

subplot(311);
signs = (przed-po)./abs(przed-po);
signs(isnan(signs))=0;
stairs(cumsum(signs));
grid on; grid minor;

subplot(334);
qqplot(przed); grid on; grid minor;
subplot(335);
qqplot(przed,po); grid on; grid minor;
subplot(336);
qqplot(po); grid on; grid minor;

subplot(325);
boxplot([przed,po]); grid on; grid minor;
subplot(326);
boxplot(przed-po); grid on; grid minor;
%% testowanie, czy probki naleza do tego samego rozkladu
mwwtest(przed,po);
% wniosek - tak, zalozenie jest spelnione

%% test znakow
% h1: \theta != 0, zatrudnienie powoduje zmiany w czytelnictwie
[p,h,stats] = signtest(przed,po)
% p =    5.8084e-05
% h =     1
% stats = zval: NaN; sign: 31
% Przyjêto hipotezê h1, zatrudnienie ma wp³yw na czytelnictwo.

%% test znakow
% h1: \theta > 0, zatrudnienie powoduje zmniejszenie czytelnictwa
[p,h,stats] = signtest(przed,po,'tail','right')
% p = 1.1617e-04
% h = 1
% stats = zval: NaN; sign: 31
% Przyjêto hipotezê h1, mediana rozk³adu przed rozpoczêciem pracy jest
% wy¿sza od tego po

%% test znakow
% h1: \theta < 0, zatrudnienie powoduje zwiêkszenie czytelnictwa
[p,h,stats] = signtest(przed,po,'tail','left')
% p = 1.0000
% h = 0
% stats = zval: NaN; sign: 31
% Nie mo¿na odrzuciæ h0, ale te¿ nie ma podstaw do przyjêcia h1, ¿e mediana
% po rozpoczêciu pracy jest wy¿sza od mediany przed rozpoczêciem pracy