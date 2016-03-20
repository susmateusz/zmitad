close; clear;
fprintf('Lista 4. Cwiczenie 6.');
%% dane
data17 = [ 172.72,157.48,170.18,172.72,175.26,170.18,154.94,149.86,157.48,154.94,175.26,167.64000000000001,157.48,157.48,154.94,177.8];
u = 164.1475;
%% testowanie
% h0: sredni wzrost studentow jest rowny u
% h1: sredni wzrost sudentow jest rozny od u
[h,p,c,s] = ttest(data17,u,'Tail','both','Alpha',0.05);
fprintf('T-TEST:\n');
fprintf('H = %g, P = %g, C = %s, tstat = %g, df = %g, sd = %g\n\n',h,p,mat2str(c),s.tstat,s.df,s.sd);
% output: H = 0, P = 1, C = [159.183749724248 169.111250275752], tstat = 1.22044e-14, df = 15, sd = 9.31526
% wniosek: nie ma podstaw do odrzucenia h0
% * p jest duze, wiec prawdopodobienstwo bledu drugiego rodzaju jest niskie
% * c - przedzial ufnosci dla ktorego uzyskano 95% poziom pewnosci

