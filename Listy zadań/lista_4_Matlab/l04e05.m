close; clear;
fprintf('Lista 4. Cwiczenie 5.');
%% dane
data13 = [ 175.26,177.8,167.64000000000001,160.02,172.72,177.8,175.26,170.18,157.48,160.02,193.04,149.86,157.48,157.48,190.5,157.48,182.88,160.02];
u = 169.051;
%% testowanie
% h0: sredni wzrost studentow jest rowny u
% h1: sredni wzrost sudentow jest rozny od u
[h,p,c,s] = ttest(data13,u,'Tail','both','Alpha',0.05);
fprintf('T-TEST:\n');
fprintf('H = %g, P = %g, C = %s, tstat = %g, df = %g, sd = %g\n\n',h,p,mat2str(c),s.tstat,s.df,s.sd);
% output: H = 0, P = 0.99997, C = [162.874957432182 175.22726479004], tstat = 3.79563e-05, df = 17, sd = 12.4197
% wniosek: nie ma podstaw do odrzucenia h0
% * p jest duze, wiec prawdopodobienstwo bledu drugiego rodzaju jest niskie
% * c - przedzial ufnosci dla ktorego uzyskano 95% poziom pewnosci

