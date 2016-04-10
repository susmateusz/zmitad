close; clear;
fprintf('Lista 6. Cwiczenie 2.');
%% dane
load('../Dane/anova_data.mat');
%% testowanie za�o�e� o normalno�ci rozk�ad�w
% w zadaniu za�o�ono normalno�� rozk�ad�w
%% testowanie za�o�e� o identyczno�ci wariancji
% w zadaniu za�o�ono r�wno�� wariancji
%% testowanie �rednich
% h0: z 95% prawdopodobie�stwem, populacje z kt�rych pochodz� wszystkie
% grupy maj� tak� sam� �redni�
% h1: �rednia przynajmniej jednej z populacji znacz�co r�ni si� od
% pozosta�ych �rednich
p = anova1(wombats,wombat_groups);
fprintf('ANOVA dla grup wombat�w:\n');
fprintf('pValue = %g\n\n',p);
% output: pValue = 0.069034
% wniosek: z 95% prawdopodobie�stwem przynajmniej jedna z grup pochodzi z
% populacji o r�nej �redniej od pozosta�ych