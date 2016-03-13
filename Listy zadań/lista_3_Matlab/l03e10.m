%pkg load statistics;
%pkg load nan;
disp('Lista 3. Ćwiczenie 10.');
%% dane
alfa = 0.05;
controlA=sort([0.22, -0.87, 0.87, -2.39, -1.79, 0.37, -1.54, 1.28, -0.31, -0.74, 0.74, 1.72, 0.38, -0.17, -0.62, -1.10, 1.10, 0.30, 0.15, 2.30, 0.19, -0.50, -0.09]);
treatmentA=sort([-5.13, -2.19, 2.19, -2.43, -3.83, 0.50, -3.25, 3.25, 4.32, 1.63, 5.18, -0.43, 7.11, 4.87, -3.10, -5.81, 5.81, 3.76, 6.31, 2.58, 0.07, 5.76, 3.50]);
controlB=sort([0.08, 0.10, 0.15, 0.17, 0.24, 0.34, 0.38, 0.42, 0.49, 0.50, 0.70, 0.94, 0.95, 1.26, 6, 1.37, 1.55, 1.75, 3.20, 6.98, 50.57]);
treatmentB=sort([2.37, 2.16, 14.82, 1.73, 41.04, 0.23, 1.32, 2.91, 39.41, 0.11, 27.44, 4.51,0.51, 4.50, 0.18, 14.68, 4.66, 1.30, 2.06, 1.19]);
%% testy
% h0: rozkład jest normalny
% h1: rozkład nie jest normalny
[H, pValue, W] = swtest(controlA, alfa);
disp('controlA:');
fprintf('H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.999734, W = 0.993041
% wniosek: controlA - rozklad normalny
[H, pValue, W] = swtest(treatmentA, alfa);
disp('treatmentA:');
fprintf('H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.193784, W = 0.941527
% wniosek: treatmentA - rozklad normalny
[H, pValue, W] = swtest(controlB, alfa);
disp('controlB:');
fprintf('H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 1, pValue = 7.41766e-08, W = 0.314008
% wniosek: controlB - rozklad nie jest normalny
[H, pValue, W] = swtest(treatmentB, alfa);
disp('treatmentB:');
fprintf('H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output:H = 1, pValue = 3.90165e-05, W = 0.654717
% wniosek: treatment - rozklad nie jest normalny
%% qqplot
figure(10);
subplot(221); qqplot(controlA);title('controlA'); grid on; grid minor;
subplot(222); qqplot(treatmentA);title('treatmentA'); grid on; grid minor;
subplot(223); qqplot(controlB);title('controlB'); grid on; grid minor;
subplot(224); qqplot(treatmentB);title('treatmentB'); grid on; grid minor;