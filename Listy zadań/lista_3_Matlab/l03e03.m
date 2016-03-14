clear; close;
f = figure(03);
disp('Lista 3. Ćwiczenie 03.');
% Przygotuj wykres dystrybuanty dla zbioru danych controlB z logarytmiczną skalą
% osi oraz dystrybuanty dla zbioru danych treatmentB z logarytmiczną skalą osi X
% (przerywaną linią) - na jednym wykresie.
% zbiór danych
controlB=[0.08, 0.10, 0.15, 0.17, 0.24, 0.34, 0.38, 0.42, 0.49, 0.50, 0.70, 0.94, 0.95, 1.26, 1.37, 1.55, 1.75, 3.20, 6.98, 50.57];
treatmentB=[2.37, 2.16, 14.82, 1.73, 41.04, 0.23, 1.32, 2.91, 39.41, 0.11, 27.44, 4.51, 0.51, 4.50, 0.18, 14.68, 4.66, 1.30, 2.06, 1.19];
% plotowanie dystrybuanty
h_controlB = cdfplot(controlB); hold on;
h_treatmentB = cdfplot(treatmentB);
legend('controlB','treatmentB','location','northwest');
set(gca,'XScale','log');
grid on; grid minor;
set(h_controlB,'Color','b');
set(h_controlB,'linewidth',1);
set(h_treatmentB,'Color','r');
set(h_treatmentB,'linewidth',1);