close; clear;
fprintf('Lista 4. Cwiczenie 1.');
%% dane
data13=[175.26,177.8,167.64000000000001,160.02,172.72,177.8,175.26,170.18,157.48,160.02,193.04,149.86,157.48,157.48,190.5,157.48,182.88,160.02];
data17=[172.72,157.48,170.18,172.72,175.26,170.18,154.94,149.86,157.48,154.94,175.26,167.64000000000001,157.48,157.48,154.94,177.8];
%% testowanie dla domyslnych parametrow
% h0: wzrost studentów obu grup nie jest znacz¹co rózny
% h1: wzrost studentów obu grup jest znacz¹co rózny
[h,p,c,s] = ttest2(data13,data17);
fprintf('T-TEST dla domyslnych parametrow:\n');
fprintf('H = %g, P = %g, C = %g, tstat = %g, df = %g, sd = %g\n\n',h,p,c,s.tstat,s.df,s.sd);
% output: H = 0, P = 0.2067, C = -2.84636, tstat = 12.6536, df = 1.28882, sd = 32
% wniosek: Nie ma podstaw do odrzucenia h0

%% testowanie dla alfa=0.01
% h0: wzrost studentów obu grup nie jest znacz¹co rózny
% h1: wzrost studentów obu grup jest znacz¹co rózny
alfa = 0.01;
[h,p,c,s] = ttest2(data13,data17,'Alpha',alfa);
fprintf('T-TEST dla alfa=0.01:\n');
fprintf('H = %g, P = %g, C = %g, tstat = %g, df = %g, sd = %g\n\n',h,p,c,s.tstat,s.df,s.sd);
% output:H = 0, P = 0.2067, C = -5.51556, tstat = 15.3228, df = 1.28882, sd = 32
% wniosek: Nie ma podstaw do odrzucenia h0

%% testowanie dla 'tail' = 'right'
% h0: wzrost studentów obu grup nie jest znacz¹co rózny
% h1: wzrost studentów grupy 1. jest œrednio wy¿szy od tych z grupy 2.
tail='right';
alfa = 0.11;
[h,p,c,s] = ttest2(data13,data17,'Tail',tail,'Alpha',alfa);
fprintf('T-TEST dla tail=right:\n');
fprintf('H = %g, P = %g, C = %g, tstat = %g, df = %g, sd = %g\n',h,p,c,s.tstat,s.df,s.sd);
fprintf('mean(data13)= %g, mean(data13)= %g\n\n',mean(data13),mean(data17));
% output: H = 1, P = 0.10335, C = 0.14386, tstat = Inf, df = 1.28882, sd = 32
% wniosek: Na poziomie ufnoœci 0.11 odrzucono h0 i przyjêto h1, czyli ¿e
% œredni wzrost grupy 1, jest wy¿szy od tych z grupy 2.
% pValue jest o okolo polowe mniejsza (rozklad byl symetryczny)

%% testowanie dla takich samych lub roznych wariancji
% h0: wzrost studentów obu grup nie jest znacz¹co rózny
% h1: wzrost studentów obu grup jest znacz¹co rózny
% domyslnie: unequal
vartype = 'unequal';
[h,p,c,s] = ttest2(data13,data17,'Vartype',vartype);
fprintf('T-TEST dla vartype=unequal:\n');
fprintf('H = %g, P = %g, C = %g, tstat = %g, df = %g, sd = %g\n\n',h,p,c,s.tstat,s.df,s.sd);
% output: H = 0, P = 0.199471, C = -2.72382, tstat = 12.531, df = 1.31089, sd = 31.1753
% wniosek: Nie ma podstaw do odrzucenia h0, ale pValue jest nieco mniejsze
% niz dla zalozenia takich samych wariancji
