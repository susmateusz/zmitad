close; clear;
fprintf('Lista 4. Cwiczenie 2.\n');
%% dane
nerwowi = [ 3, 3, 4, 5, 5];
spokojni = [ 4, 6, 7, 9, 9];
%% testowanie
% h0: �rednia ilo�� gest�w ludzi nerwowych i spokojnych jest taka sama
% h1: ludzie nerwowi wykonuj� �rednio wi�cej gest�w na minut� ni� spokojni
% sprawdzenie, czy mo�na za�o�y� r�wno�� wariancji:
% h_var0: pr�by maj� r�wne wariancje
% h_var1: pr�by maj� r�ne wariancje
h = vartest2(nerwowi, spokojni)
% output: h=0, nie ma podstaw do odrzucenia hipotezy o r�wnych wariancjach

alfa = 0.05;
[h,p,c,s] = ttest2(nerwowi, spokojni, 'Tail', 'right' ,'Alpha', alfa);
fprintf('T-TEST:\n');
fprintf('H = %g, P = %g, C = %s, tstat = %g, df = %g, sd = %g\n\n',h,p,mat2str(c),s.tstat,s.df,s.sd);
% output: H = 0, P = 0.989431, C = [-4.95031043535985 Inf], tstat = -2.86039, df = 8, sd = 1.65831
% wniosek: 
% * wariancje nie sa znaczaco rozne, mozna zastosowac ttest
% * nie ma podstaw do odrzucenia h0, nie stwierdzono, �eby ludzie
% nerwowi wykonywali wi�cej gest�w
% * P~=0.98>>alfa - prawdopodobinstwo bledu 2. rodzaju jest bardzo niskie
% * C - przedzial ufnosci jest duzy
% * tstat = -2.8
% * df=8 - stopnie swobody. jezeli "n" to licznosc, to stopnie swobody
% testu pomi�dzy dwiema probami to n1+n2-2. Liczb� stopni swobody
% pomniejszaj� wsp�lne elementy obu pr�b, np. odchylenia standardowe
% (za�o�one jako r�wne)
% * sd=1.65 za�o�one odchylenie standardowe populacji. Dla po�wnania:
% odchylenia standardowe odpowiednio spokojnych i nerwowych to 1.89 i 0.89