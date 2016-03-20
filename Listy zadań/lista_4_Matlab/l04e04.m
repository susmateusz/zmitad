close; clear;
fprintf('Lista 4. Cwiczenie 4.\n');
%% dane
dataAfter = [ 74.86,77.4,67.24,59.62,72.32,77.4,74.86,69.78,57.08,59.62,92.64,49.46,57.08,57.08,90.1,57.08];
dataBefore = [ 72.32,57.08,69.78,72.32,74.86,69.78,54.54,49.46,57.08,54.54,74.86,67.24,57.08,57.08,54.54,77.4];
%% zalozenia dla prob niezaleznych
%% normalnosci rozkladow
[h,p] = swtest(dataAfter);   % h0 - rozklad normalny
fprintf('SWTEST dataAfter: h=%d, p=%f\n',h,p);
[h,p] = swtest(dataBefore);  % h1 - rozklad nie normalny
fprintf('SWTEST dataBefore: h=%d, p=%f\n',h,p);
[h,p] = kstest(dataAfter);   % h1 - rozklad nie normalny
fprintf('KSTEST dataAfter: h=%d, p=%f\n',h,p);
[h,p] = kstest(dataBefore);  % h1 - rozklad nie normalny
fprintf('KSTEST dataBefore: h=%d, p=%f\n',h,p);
[h,p] = swtest(sort(dataAfter)-sort(dataBefore));  % h1 - rozklad nie normalny
fprintf('SWTEST dataAfter-dataBefore: h=%d, p=%f\n',h,p);
[h,p] = kstest(sort(dataAfter)-sort(dataBefore));   % h1 - rozklad nie normalny
fprintf('KSTEST dataAfter-dataBefore: h=%d, p=%f\n',h,p);
%% liczebnosc
fprintf('podobne liczebnosci: %d == %d ?\n',length(dataAfter),length(dataBefore));
%% podobienstwo wariancji
% h0 - wariancje sa podobne
% h1 - wariancje sa niepodobne
fprintf('podobienstwo wariancji: h = %d\n',vartest2(dataAfter, dataBefore));
% WNIOSKI: zalozenia o normalnosci testow nie zostaly spelnione, pozostale,
% takie jak podobna licznosc czy podobne wariancje zostaly spelnione
%% hipotezy
% h0: srednia liczba slow na minute przed i po kursie jest taka sama
% h1: srednia szybkosc czytania po kursie jest wieksza niz przed
%% testowanie dla prob niezaleznych
[h,p,c,s] = ttest2(dataAfter, dataBefore, 'Tail', 'right');
fprintf('T-TEST - proby niezalezne:\n');
fprintf('H = %g, P = %g, C = %s, tstat = %g, df = %g, sd = %g\n\n',h,p,mat2str(c),s.tstat,s.df,s.sd);
% Zalozenia dla testow niezaleznych sa niespelnione - proby nie maja
% rozkladu normalnego
%% testowanie dla prob zaleznych
[h,p,ci,s]=ttest(dataAfter,dataBefore,'Tail','right','Alpha',0.05);
fprintf('H = %g, P = %g, C = %s, tstat = %g, df = %g, sd = %g\n\n',h,p,mat2str(c),s.tstat,s.df,s.sd);
% zalozenia dla testow zaleznych nie sa spelnione - roznice miedzy testami
% nie maja rozkladu normalnego

%% wyniki mozna poprawic wykonujac dluzsze proby, az do osiagniecia rozkladu normalnego