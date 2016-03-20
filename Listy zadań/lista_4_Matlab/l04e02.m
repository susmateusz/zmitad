close; clear;
fprintf('Lista 4. Cwiczenie 2.\n');
%% dane
nerwowi = [ 3, 3, 4, 5, 5];
spokojni = [ 4, 6, 7, 9, 9];
%% testowanie
% h0: œrednia iloœæ gestów ludzi nerwowych i spokojnych jest taka sama
% h1: ludzie nerwowi wykonuj¹ œrednio wiêcej gestów na minutê ni¿ spokojni
% sprawdzenie, czy mo¿na za³o¿yæ równoœæ wariancji:
% h_var0: próby maj¹ równe wariancje
% h_var1: próby maj¹ ró¿ne wariancje
h = vartest2(nerwowi, spokojni)
% output: h=0, nie ma podstaw do odrzucenia hipotezy o równych wariancjach

alfa = 0.05;
[h,p,c,s] = ttest2(nerwowi, spokojni, 'Tail', 'right' ,'Alpha', alfa);
fprintf('T-TEST:\n');
fprintf('H = %g, P = %g, C = %s, tstat = %g, df = %g, sd = %g\n\n',h,p,mat2str(c),s.tstat,s.df,s.sd);
% output: H = 0, P = 0.989431, C = [-4.95031043535985 Inf], tstat = -2.86039, df = 8, sd = 1.65831
% wniosek: 
% * wariancje nie sa znaczaco rozne, mozna zastosowac ttest
% * nie ma podstaw do odrzucenia h0, nie stwierdzono, ¿eby ludzie
% nerwowi wykonywali wiêcej gestów
% * P~=0.98>>alfa - prawdopodobinstwo bledu 2. rodzaju jest bardzo niskie
% * C - przedzial ufnosci jest duzy
% * tstat = -2.8
% * df=8 - stopnie swobody. jezeli "n" to licznosc, to stopnie swobody
% testu pomiêdzy dwiema probami to n1+n2-2. Liczbê stopni swobody
% pomniejszaj¹ wspólne elementy obu prób, np. odchylenia standardowe
% (za³o¿one jako równe)
% * sd=1.65 za³o¿one odchylenie standardowe populacji. Dla poównania:
% odchylenia standardowe odpowiednio spokojnych i nerwowych to 1.89 i 0.89