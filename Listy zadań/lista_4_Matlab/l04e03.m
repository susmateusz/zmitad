close; clear;
fprintf('Lista 4. Cwiczenie 3.');
%% dane
mniej30 = [ 6, 7, 10, 9];
po30 = [ 5, 6, 2, 3];
%% testowanie
% testowanie normalnosci rozkladow
[h,p]=swtest(mniej30)
[h,p]=swtest(po30)
% licznosci
length(mniej30)
length(po30)
% h0: osoby <30 i >30 maja taki sam œredni wspolczynnik rozbawienia
% h1: osoby ponizej 30 maja wyzszy wspolczynnik rozbawienia 
% sprawdzenie, czy mo¿na za³o¿yæ równoœæ wariancji:
% h_var0: próby maj¹ równe wariancje
% h_var1: próby maj¹ ró¿ne wariancje
h_var = vartest2(mniej30, po30)
% output: h=0, nie ma podstaw do odrzucenia hipotezy o równych wariancjach
% mozna zastosowac ttest

alfa = 0.05;
[h,p,c,s] = ttest2(mniej30, po30, 'Tail', 'right' ,'Alpha', alfa);
fprintf('T-TEST:\n');
fprintf('H = %g, P = %g, C = %s, tstat = %g, df = %g, sd = %g\n\n',h,p,mat2str(c),s.tstat,s.df,s.sd);
% output: H = 1, P = 0.01058, C = [1.49136504496186 Inf], tstat = 3.09839, df = 6, sd = 1.82574
% wniosek: 
% * zastosowano ttest jednostronny
% * przyjêto hipoteze h1, osoby przed 30 maja wyzszy wspolczynnik rozbawienia
% * pValue jest ponizej poziomu istotnosci, nie ma prawdopodobienstwa bledu
% 1. rodzaju
% * przedzial roznic srednich probek dla ktorego hipoteza jest zgodna z
% zadanym poziomem istotniosci
% * stopien swobody to suma liczb pomiarow pomniejszona o 2 wymiary
% przypadajace na wariancje (ktore sa podobne)
% oszacowane odchylenie standardowe populacji to sd = 1.82574