close; clear;
fprintf('Lista 3. Ćwiczenie 07.\n');
%% dane
controlB=[1.26, 0.34, 0.70, 1.75, 50.57, 1.55, 0.08, 0.42, 0.50, 3.20, 0.15, 0.49, 0.95, 0.24, 1.37, 0.17, 6.98, 0.10, 0.94, 0.38];
treatmentB=[2.37, 2.16, 14.82, 1.73, 41.04, 0.23, 1.32, 2.91, 39.41, 0.11, 27.44, 4.51, 0.51, 4.50, 0.18, 14.68, 4.66, 1.30, 2.06, 1.19];
%% testowanie ttest podobieństwa rozkładów
% h0: controlB i treatmentB są z tego samego rozkładu
% h1: obie próbki zostały wygenerowane z różnych rozkładów
[H,P] = ttest2(controlB, treatmentB);
fprintf('Test TTEST2 dla controlB i treatmentB:\n');
fprintf('H = %g, P = %g\n',H,P);
fprintf('WNIOSEK: nie ma podstaw do odrzucenia hipotezy h0, rozkłady mogą być takie same.\n\n');
%% testowanie kstest podobieństwa rozkładów
[H,P,KSSTAT] = kstest2(controlB, treatmentB);
fprintf('Test KSTEST2 dla controlB i treatmentB:\n');
fprintf('H = %g, P = %g, KSSTAT = %g\n',H,P,KSSTAT);
fprintf('WNIOSEK: Przyjęto h1, P<0.05 więc nie ma ryzyka fałszywego odrzucenia prawdziwe hipotezy h0.\n\n');
%% testowanie ttest normalności rozkładów
% h0: controlB ma rozkład normalny
% h1: controlB nie ma rozkładu normalnego
[H,P,KSSTAT,CV] = kstest(controlB);
fprintf('Test KSTEST dla controlB:\n');
fprintf('H = %g, P = %g, KSSTAT = %g, CV = %g\n',H,P,KSSTAT,CV);
fprintf('WNIOSEK: Przyjęto h1, rozkład controlB nie jest normalny, P jest bardzo niskie.\n\n');

% h0: treatmentB ma rozkład normalny
% h1: treatmentB nie ma rozkładu normalnego
[H,P,KSSTAT,CV] = kstest(treatmentB);
fprintf('Test KSTEST dla treatmentB:\n');
fprintf('H = %g, P = %g, KSSTAT = %g, CV = %g\n',H,P,KSSTAT,CV);
fprintf('WNIOSEK: Przyjęto h1, rozkład treatmentB nie jest normalny, P jest bardzo niskie.\n\n');
