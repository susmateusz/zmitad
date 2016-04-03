close; clear;
fprintf('Lista 5. Cwiczenie 1.');
%% dane
w1 = [88 69 86 59 57 82 94 93 64 91 86 59 91 60 57 92 70 88 70 85];
w2 = [73 68 75 54 53 84 84 86 66 84 78 58 91 57 59 88 71 84 64 85];
%% hipotezy
% h0: \theta == 0, dieta nie powoduje zmiany masy cia³a
% h1: \theta > 0, dieta powoduje zmniejszenie masy cia³a, czyli w1>w2 
%% testy graficzne
figure(1);
subplot(411);
plot(w1); hold on;
plot(w2); grid on; grid minor;
legend('w1','w2');

subplot(412);
signs = (w1-w2)./abs(w1-w2);
signs(isnan(signs))=0;
stairs(cumsum(signs));
%ylim([-1.5 1.5]);
grid on; grid minor;

subplot(425);
qqplot(w1); grid on; grid minor;
subplot(426);
qqplot(w2); grid on; grid minor;

subplot(427);
boxplot([w1',w2']); grid on; grid minor;
subplot(428);
boxplot(w1-w2); grid on; grid minor;
%% ttest
[h,p] = swtest(w1)  % rozk³ad nie jest normalny
[h,p] = swtest(w2)  % rozk³ad normalny

%% test znaków
[p,h,stats] = signtest(w1,w2,'tail','right')
% p = 0.0154; h = 1; stats = zval: NaN sign: 14
% Hipoteza H0 zostaje odrzucona, przyjêta zostaje hipoteza H1, co oznacza,
% ¿e dieta powoduje spadek wagi.