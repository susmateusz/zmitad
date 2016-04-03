close; clear;
fprintf('Lista 4. Cwiczenie 8.');
%% dane
data13 = [ 175.26,177.8,167.64,160.02,172.72,177.8,175.26,170.18,157.48,160.02,193.04,149.86,157.48,157.48,190.5,157.48,182.88,160.02];
data17 = [ 172.72,157.48,170.18,172.72,175.26,170.18,154.94,149.86,157.48,154.94,175.26,167.64,157.48,157.48,154.94,177.8];
%% testowanie
% h0: rozklady sa symetryczne wzgledem prawdopodobienstwa wiekszej wartosci
% jednego z nich
% h1: jeden z rozkladow ma wartosci znaczaco wyzsze od drugiego
mwwtest(data13, data17)
% ---------------------------------------------------------------------------
% 				Group 1		Group 2
% numerosity			18		16
% Sum of Ranks (W)		357.0		238.0
% Mean rank			19.8		14.9
% Test variable (U)		102.0		186.0
% ---------------------------------------------------------------------------
% Sample size is large enough to use the normal distribution approximation
% Mean					144.0
% Standard deviation corrected for ties	28.7248
% Z corrected for continuity	1.4447		1.4447
% p-value (1-tailed)			0.07426
% p-value (2-tailed)			0.14853
% ---------------------------------------------------------------------------
%  
% wnioski:
% rozmiar prob jest wystarczajacy by uzyc przyblizenia rozkladem normalnym
% pvalue jest wystarczajaco duze, wiec nie ma podstaw do odrzucenia
% hipotezy h0, prawdopodobienstwa, ze jeden z rozkladow jest wiekszy, sa
% takie same
