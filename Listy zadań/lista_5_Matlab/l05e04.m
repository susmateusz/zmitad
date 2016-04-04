close; clear;
fprintf('Lista 5. Cwiczenie 4.');
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
[p,h,stats] = ranksum(przed,po)
% p =    0.4666
% h =     0
% zval: 0.7280
% ranksum: 1696
% Nie ma powodów do odrzucenia h0, nie da siê stwierdziæ, ¿e mediany s¹
% ró¿ne
%% test znakow
% h1: \theta > 0, zatrudnienie powoduje zmniejszenie czytelnictwa
[p,h,stats] = ranksum(przed,po,'tail','right')
% p = 0.2333
% h = 0
% zval: 0.7280
% ranksum: 1696
% Nie mo¿na przyj¹æ, ¿e mediana przed rozpoczêciem pracy jest wy¿sza od
% mediany po rozpoczêciu pracy

%% test znakow
% h1: \theta < 0, zatrudnienie powoduje zwiêkszenie czytelnictwa
[p,h,stats] = ranksum(przed,po,'tail','left')
% p =  0.7696
% h = 0
% zval: 0.7280
% ranksum: 1696
% Nie mo¿na powiedzieæ, ¿e mediana przed rozpoczêciem pracy jest ni¿sza od
% mediany po rozpoczêciu pracy