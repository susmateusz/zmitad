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
%% testowanie za�o�e� o normalno�ci rozk�ad�w
% h0: rozklad grupy n. jest normalny
% h1: rozklad grupy n. nie jest normalny
[H, pValue, W] = swtest(fed(0*r+1:r,1));
fprintf('Normalno�� T1 Z1: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.36699, W = 0.928744
[H, pValue, W] = swtest(fed(1*r+1:2*r,1));
fprintf('Normalno�� T1 Z2: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.357424, W = 0.927805
[H, pValue, W] = swtest(fed(2*r+1:3*r,1));
fprintf('Normalno�� T1 Z3: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.658991, W = 0.951499
[H, pValue, W] = swtest(fed(0*r+1:r,2));
fprintf('Normalno�� T2 Z1: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.94548, W = 0.973704
[H, pValue, W] = swtest(fed(1*r+1:2*r,2));
fprintf('Normalno�� T2 Z2: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.424823, W = 0.940442
[H, pValue, W] = swtest(fed(2*r+1:3*r,2));
fprintf('Normalno�� T2 Z3: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.956038, W = 0.97507
[H, pValue, W] = swtest(fed(0*r+1:r,3));
fprintf('Normalno�� T1 Z1: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.456763, W = 0.943137 
[H, pValue, W] = swtest(fed(1*r+1:2*r,3));
fprintf('Normalno�� T3 Z2: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.409575, W = 0.932697
[H, pValue, W] = swtest(fed(2*r+1:3*r,3));
fprintf('Normalno�� T3 Z3: H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.965157, W = 0.976408
% WNIOSKI: W �adnej z grup nie ma podstaw do odrzucenia hipotezy h0,
% dla ka�dej z nich mo�na uzna�, �e z 95% pewno�ci� maj� one rozk��dy
% normalne
%% testowanie za�o�e� o identyczno�ci wariancji
% wykorzystany zostanie vartestn, do testowania podobie�stwa wi�kszej
% ilo�ci wariancji
% h0: wariancje wszystkich grup s� podobne
% h1: wariancja przynajmniej jednej z grup odbiega od innych
p = vartestn([fed(1:r,:) fed(r+1:2*r,:) fed(2*r+1:3*r,:)]);
fprintf('Testowanie podobie�stwa wariancji grup:\n');
fprintf('pValue = %g\n\n',p);
% output: pValue = 0.14383
% wniosek: pValue>alfa=0.05, nie ma podstaw do odrzucenia hipotezy o
% podobie�stwie wariancji
%% testowanie za�o�e� o r�wnoliczno�ci grup
% wszystkie podgrupy maj� takie same liczno�ci, nie ma potrzeby dodatkowych
% test�w
%% testowanie �rednich (ANOVA2)
% h01: �rednia wydolno�� oddechowa pracownik�w nie jest zale�na od rodzaju
% substancji toksycznej
% h02: �rednia wydolno�� oddechowa jest taka sama dla ka�dego zak�adu pracy
% h03: rodzaj substancji i zak�ad pracy nie maj� synergicznego wp�ywu na
% �rednie wydolno�ci oddechowe
% h11: rodzaj substancji toksycznej ma wp�yw na �redni� wydolno�� oddechow�
% h12: �rednia wydolno�� oddechowa jest zale�na od zak�adu pracy
% h13: oba czynniki maj� dodatkowy wp�yw na �redni� wydolno�� oddechow�, w
% por�wnaniu z wp�ywami odobnymi
p = anova2(fed,r);
fprintf('ANOVA2 dla bada� FED:\n');
fprintf('pValue = %g\n\n',p);
% output: 
% pValue = 1.02492e-27
% pValue = 0.0033222
% pValue = 2.71002e-13
% wniosek: Z 95% prawdopodobie�stwem s� podstawy do odrzucenia hipotez h01,
% h02 i h03, a przyj�cia dla nich hipotez alternatywnych, co oznacza, �e:
% Rodzaj substancji toksycznej ma wp�yw na wydolno�� oddechow�.
% Wydolno�� oddechowa jest zale�na od zak�adu pracy.
% Oba te czynniki po��czone maj� dodatkowy wp�yw na wydolno�� oddechow�
% pracownik�w.