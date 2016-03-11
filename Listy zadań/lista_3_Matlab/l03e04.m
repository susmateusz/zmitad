#!/usr/bin/env octave
function l03e04
pkg load statistics;
pkg load nan;
f = figure(04);
disp("Lista 3. Ćwiczenie 04.");
% W analogiczny sposób przeprowadź rozumowanie dla grupy kontrolnej A oraz grupy
% poddanej terapii A:
% controlA={0.22, -0.87, -2.39, -1.79, 0.37, -1.54, 1.28, -0.31, -0.74, 1.72,
% 0.38, -0.17, -0.62, -1.10, 0.30, 0.15, 2.30, 0.19, -0.50, -0.09}
% treatmentA={-5.13, -2.19, -2.43, -3.83, 0.50, -3.25, 4.32, 1.63, 5.18, -0.43,
% 7.11, 4.87, -3.10, -5.81, 3.76, 6.31, 2.58, 0.07, 5.76, 3.50}
% Sprawdź czy twój wynik zgadza się z: <wykres>
% zbiór danych
controlA=[0.22, -0.87, -2.39, -1.79, 0.37, -1.54, 1.28, -0.31, -0.74, 1.72, 0.38, -0.17, -0.62,-1.10, 0.30, 0.15, 2.30, 0.19, -0.50, -0.09];
treatmentA=[-5.13, -2.19, -2.43, -3.83, 0.50, -3.25, 4.32, 1.63, 5.18, -0.43, 7.11, 4.87, -3.10, -5.81, 3.76, 6.31, 2.58, 0.07, 5.76, 3.50];
% plotowanie dystrybuanty
cdfplot(controlA,'b','linewidth',1); hold on;
cdfplot(treatmentA,'r','linewidth',1);
grid on; grid minor;
legend('controlB','treatmentB','location','northwest');
waitfor(f);