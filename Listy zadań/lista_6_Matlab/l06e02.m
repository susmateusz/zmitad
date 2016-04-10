close; clear;
fprintf('Lista 6. Cwiczenie 2.');
%% dane
load('../Dane/anova_data.mat');
%% testowanie za³o¿eñ o normalnoœci rozk³adów
% w zadaniu za³o¿ono normalnoœæ rozk³adów
%% testowanie za³o¿eñ o identycznoœci wariancji
% w zadaniu za³o¿ono równoœæ wariancji
%% testowanie œrednich
% h0: z 95% prawdopodobieñstwem, populacje z których pochodz¹ wszystkie
% grupy maj¹ tak¹ sam¹ œredni¹
% h1: œrednia przynajmniej jednej z populacji znacz¹co ró¿ni siê od
% pozosta³ych œrednich
p = anova1(wombats,wombat_groups);
fprintf('ANOVA dla grup wombatów:\n');
fprintf('pValue = %g\n\n',p);
% output: pValue = 0.069034
% wniosek: z 95% prawdopodobieñstwem przynajmniej jedna z grup pochodzi z
% populacji o ró¿nej œredniej od pozosta³ych