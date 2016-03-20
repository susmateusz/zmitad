close; clear;
disp('Lista 3. Ćwiczenie 13.');
%% wczytywanie danych
alfa = 0.05;
fd = fopen('../Dane/kondensatory.csv');
formatSpec = '%f';
C = textscan(fd,formatSpec,'HeaderLines',1);
kondensatory = C{1};
fclose(fd);
%% testowanie
% h0: rozkład jest normalny
% h1: rozkład nie jest normalny
[H, pValue, W] = swtest(kondensatory, alfa);
disp('kondensatory - SW:');
fprintf('H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.145563, W = 0.959802
% wniosek: kondensatory - pojemność ma rozklad normalny

[H, pValue] = lillietest(kondensatory, alfa);
disp('kondensatory - Lillieforsa:');
fprintf('H = %g, pValue = %g\n\n',H,pValue);
% output: H = 0, pValue = 0.261224
% wniosek: rozklad normalny