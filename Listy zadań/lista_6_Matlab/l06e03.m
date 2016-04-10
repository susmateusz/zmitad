close; clear;
fprintf('Lista 6. Cwiczenie 3.');
%% dane
sprzedaz = [
    3415 4556 5772 5432;
    1593 1937 2242 2794;
    1976 2056 2240 2085;
    1526 1594 1644 1705;
    1538 1634 1866 1769;
     983 1086 1135 1177;
    1050 1209 1245  977;
    1861 2087 2054 2018;
    1714 2415 2361 2424;
    1320 1621 1624 1551;
    1276 1377 1522 1412;
    1263 1279 1350 1490;
    1271 1417 1583 1513;
    1436 1310 1357 1468];
%% testowanie z u¿yciem Kruskala-Wallisa
% h0: mediana ceny batona nie zmieni³a siê znacz¹co
% h1: przynajmniej w jednym kwartale mediana ceny batona znacz¹co siê
% ró¿ni³a
p = kruskalwallis(sprzedaz);
fprintf('Kruskal-Wallis dla sprzeda¿y batonika:\n');
fprintf('pValue = %g\n\n',p);
% output: pValue = 0.440629
% wniosek: nie ma podstaw do odrzucenia h0, czyli kampania reklamowa nie
% wp³yne³a znacz¹co na sprzeda¿ batona w ¿adnym kwartale