close; clear;
disp('Lista 3. Ćwiczenie 11.');
%% wczytywanie danych
alfa = 0.05;
fd = fopen('../Dane/pacjenci.csv');
formatSpec = '%f,%f,%f,%s';
C = textscan(fd,formatSpec,'HeaderLines',1);
fclose(fd);
cukier = sort(C{3});
%% testowanie
% h0: rozkład jest normalny
% h1: rozkład nie jest normalny
[H, pValue, W] = swtest(cukier, alfa);
disp('cukier - SW:');
fprintf('H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.377057, W = 0.958053
% wniosek: cukier - rozklad normalny

[H, pValue] = lillietest(cukier, alfa);
disp('cukier - Lillieforsa:');
fprintf('H = %g, pValue = %g\n\n',H,pValue);
% output: H = 0, pValue = 0.26013
% wniosek: cukier - rozklad normalny

[H,pValue] = kstest(cukier);
disp('cukier - KS:');
fprintf('H = %g, pValue = %g\n\n',H,pValue);
% output: H = 1, pValue = 1.79837e-23
% wniosek: cukier - rozklad nie jest normalny
