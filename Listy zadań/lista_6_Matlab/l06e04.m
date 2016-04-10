close; clear;
fprintf('Lista 6. Cwiczenie 4.\n');
%% dane
fed = [
    4.64	3.21	3.75;
5.92	3.17	2.5;
5.25	3.88	2.65;
6.17	3.5	2.84;
4.2	2.47	3.09;
5.9	4.12	2.9;
5.07	3.51	2.62;
4.13	3.85	2.75;
4.07	4.22	3.1;
5.3	3.07	1.99;
4.37	3.62	2.42;
3.76	2.95	2.37;
5.12	3.92	2.95;
6.1	3.75	3.21;
4.85	4.01	3.15;
4.72	4.64	3.25;
5.36	3.63	2.3;
5.41	3.46	2.76;
5.31	4.01	3.01;
4.78	3.39	2.31;
5.08	3.78	2.5;
4.97	3.51	2.02;
5.85	3.19	2.64;
5.26	4.04	2.27;
4.64	4.95	2.95;
4.32	5.22	2.8;
4.13	5.16	3.63;
5.17	5.35	3.85;
3.77	4.35	2.19;
3.85	4.89	3.32;
4.12	5.61	2.68;
5.07	4.98	3.35;
3.25	5.77	3.12;
3.49	5.23	4.11;
3.65	4.76	2.9;
4.1	5.15	2.75];
r = 12;
%% testowanie za³o¿eñ o normalnoœci rozk³adów
% h0: rozklad grupy n. jest normalny
% h1: rozklad grupy n. nie jest normalny
[H, pValue, W] = swtest(fed(0*r+1:r,1));
fprintf('Normalnoœæ T1 Z1: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.36699, W = 0.928744
[H, pValue, W] = swtest(fed(1*r+1:2*r,1));
fprintf('Normalnoœæ T1 Z2: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.357424, W = 0.927805
[H, pValue, W] = swtest(fed(2*r+1:3*r,1));
fprintf('Normalnoœæ T1 Z3: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.658991, W = 0.951499
[H, pValue, W] = swtest(fed(0*r+1:r,2));
fprintf('Normalnoœæ T2 Z1: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.94548, W = 0.973704
[H, pValue, W] = swtest(fed(1*r+1:2*r,2));
fprintf('Normalnoœæ T2 Z2: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.424823, W = 0.940442
[H, pValue, W] = swtest(fed(2*r+1:3*r,2));
fprintf('Normalnoœæ T2 Z3: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.956038, W = 0.97507
[H, pValue, W] = swtest(fed(0*r+1:r,3));
fprintf('Normalnoœæ T1 Z1: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.456763, W = 0.943137 
[H, pValue, W] = swtest(fed(1*r+1:2*r,3));
fprintf('Normalnoœæ T3 Z2: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.409575, W = 0.932697
[H, pValue, W] = swtest(fed(2*r+1:3*r,3));
fprintf('Normalnoœæ T3 Z3: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.965157, W = 0.976408
% WNIOSKI: W ¿adnej z grup nie ma podstaw do odrzucenia hipotezy h0,
% dla ka¿dej z nich mo¿na uznaæ, ¿e z 95% pewnoœci¹ maj¹ one rozk³¹dy
% normalne
%% testowanie za³o¿eñ o identycznoœci wariancji
% wykorzystany zostanie vartestn, do testowania podobieñstwa wiêkszej
% iloœci wariancji
% h0: wariancje wszystkich grup s¹ podobne
% h1: wariancja przynajmniej jednej z grup odbiega od innych
p = vartestn([fed(1:r,:) fed(r+1:2*r,:) fed(2*r+1:3*r,:)]);
fprintf('Testowanie podobieñstwa wariancji grup:\n');
fprintf('pValue = %g\n\n',p);
% output: pValue = 0.14383
% wniosek: pValue>alfa=0.05, nie ma podstaw do odrzucenia hipotezy o
% podobieñstwie wariancji
%% testowanie za³o¿eñ o równolicznoœci grup
% wszystkie podgrupy maj¹ takie same licznoœci, nie ma potrzeby dodatkowych
% testów
%% testowanie œrednich (ANOVA2)
% h01: œrednia wydolnoœæ oddechowa pracowników nie jest zale¿na od rodzaju
% substancji toksycznej
% h02: œrednia wydolnoœæ oddechowa jest taka sama dla ka¿dego zak³adu pracy
% h03: rodzaj substancji i zak³ad pracy nie maj¹ synergicznego wp³ywu na
% œrednie wydolnoœci oddechowe
% h11: rodzaj substancji toksycznej ma wp³yw na œredni¹ wydolnoœæ oddechow¹
% h12: œrednia wydolnoœæ oddechowa jest zale¿na od zak³adu pracy
% h13: oba czynniki maj¹ dodatkowy wp³yw na œredni¹ wydolnoœæ oddechow¹, w
% porównaniu z wp³ywami odobnymi
p = anova2(fed,r);
fprintf('ANOVA2 dla badañ FED:\n');
fprintf('pValue = %g\n\n',p);
% output: 
% pValue = 1.02492e-27
% pValue = 0.0033222
% pValue = 2.71002e-13
% wniosek: Z 95% prawdopodobieñstwem s¹ podstawy do odrzucenia hipotez h01,
% h02 i h03, a przyjêcia dla nich hipotez alternatywnych, co oznacza, ¿e:
% Rodzaj substancji toksycznej ma wp³yw na wydolnoœæ oddechow¹.
% Wydolnoœæ oddechowa jest zale¿na od zak³adu pracy.
% Oba te czynniki po³¹czone maj¹ dodatkowy wp³yw na wydolnoœæ oddechow¹
% pracowników.