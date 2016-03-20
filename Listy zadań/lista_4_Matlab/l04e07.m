close; clear;
fprintf('Lista 4. Cwiczenie 7.');
%% dane
%% dane
nerwowi = [ 3, 3, 4, 5, 5];
spokojni = [ 4, 6, 7, 9, 9];
%% testowanie
% h0: rozklady sa symetryczne wzgledem prawdopodobienstwa wiekszej wartosci
% jednego z nich
% h1: jeden z rozkladow ma wartosci znaczaco wyzsze od drugiego
mwwtest(nerwowi, spokojni)
% ---------------------------------------------------------------------------
% 				Group 1		Group 2
% numerosity			5		5
% Sum of Ranks (W)		17.5		37.5
% Mean rank			3.5		7.5
% Test variable (U)		22.5		2.5
% ---------------------------------------------------------------------------
% Sample size is small enough to use the exact Mann-Whitney-Wilcoxon distribution
% Test variable (W)			17.5
% p-value (1-tailed)			0.01984
% p-value (2-tailed)			0.03968
% ---------------------------------------------------------------------------
% wnioski:
% Liczba probek jest wystarczajaco niska, zeby uzyc test Manna-Whitneya
% pvalue jedno i dwustronne sa mniejsze od poziomu istotnosci 0.05, wiec
% przyjeto hipoteze h1, ze jeden z rozkladow ma wartosci wyzsze niz drugi
