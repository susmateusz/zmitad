clear; close;
f = figure(1);
disp('Lista 3. Ćwiczenie 01.');
% Przygotuj wykres dystrybuanty dla zbioru danych controlB. Pamiętaj, że każdy
% punkt na wykresie odpowiada pojedynczemu punktowi w zbiorze danych.
controlB=[0.08, 0.10, 0.15, 0.17, 0.24, 0.34, 0.38, 0.42, 0.49, 0.50, 0.70, 0.94, 0.95, 1.26, 1.37, 1.55, 1.75, 3.20, 6.98, 50.57];
% plotowanie dystrybuanty
cdfplot(controlB);
grid on; grid minor;
