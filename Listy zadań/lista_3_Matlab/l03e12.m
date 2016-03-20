close; clear;
disp('Lista 3. Ćwiczenie 12.');
%% wczytywanie danych
alfa = 0.1;
fd = fopen('../Dane/zarowki.csv');
formatSpec = '%f';
C = textscan(fd,formatSpec,'HeaderLines',1);
zarowki = C{1};
fclose(fd);
%% testowanie
% h0: rozkład jest normalny
% h1: rozkład nie jest normalny
[H, pValue, W] = swtest(zarowki, alfa);
disp('zarowki - SW:');
fprintf('H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.181652, W = 0.892661
% wniosek: zużycie ma rozklad normalny

[H, pValue] = lillietest(zarowki, alfa);
disp('zarowki - Lillieforsa:');
fprintf('H = %g, pValue = %g\n\n',H,pValue);
% output: H = 0, pValue = 0.30477
% wniosek: rozklad normalny

[H,pValue] = kstest(zarowki,'Alpha',alfa);
disp('zarowki - KS:');
fprintf('H = %g, pValue = %g\n\n',H,pValue);
% output: H = 1, pValue = 3.53451e-10
% wniosek: rozklad nie jest normalny