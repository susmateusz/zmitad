clear; close;
%% wczytywanie danych
disp('Projekt');
fileID = fopen('Dane/2004_Women_200_metre_freestyle.csv');
%fileID = fopen('Dane/2004_Men_200_metre_freestyle.csv');
results2004data = textscan(fileID,'%s%s%f','delimiter',',');
results2004 = results2004data{3}(:);
fclose(fileID);
fileID = fopen('Dane/2008_Women_200_metre_freestyle.csv');
%fileID = fopen('Dane/2008_Men_200_metre_freestyle.csv');
results2008data = textscan(fileID,'%s%s%f','delimiter',',');
results2008 = results2008data{3}(:);
fclose(fileID);
fileID = fopen('Dane/2012_Women_200_metre_freestyle.csv');
%fileID = fopen('Dane/2012_Men_200_metre_freestyle.csv');
results2012data = textscan(fileID,'%s%s%f','delimiter',',');
results2012 = results2012data{3}(:);
fclose(fileID);
%% wyr�wnywanie d�ugo�ci
minSize = min([size(results2004,1),size(results2008,1),size(results2012,1)]);
minSize = 30;
results2004 = results2004(1:minSize);
results2008 = results2008(1:minSize);
results2012 = results2012(1:minSize);
results = [results2004, results2008, results2012];
%% ZAD2. badania parametr�w rozk�ad�w
fprintf('**********ZAD.2.**********\n');
fprintf('MEAN for 2004, 2008, 2012:\t\t\t[%6.1f, %6.1f, %6.1f]\n',mean(results));
fprintf('STD for 2004, 2008, 2012:\t\t\t[%6.1f, %6.1f, %6.1f]\n',std(results));
fprintf('MIN for 2004, 2008, 2012:\t\t\t[%6.1f, %6.1f, %6.1f]\n',min(results));
fprintf('1.KWANTYL for 2004, 2008, 2012:\t\t[%6.1f, %6.1f, %6.1f]\n',quantile(results,0.25));
fprintf('MEDIAN for 2004, 2008, 2012:\t\t[%6.1f, %6.1f, %6.1f]\n',median(results));
fprintf('3.KWANTYL for 2004, 2008, 2012:\t\t[%6.1f, %6.1f, %6.1f]\n',quantile(results,0.75));
fprintf('MAX for 2004, 2008, 2012:\t\t\t[%6.1f, %6.1f, %6.1f]\n',max(results));
%% za�o�enie o normalno�ci rozk�adu
fprintf('*************************************************************\n');
fprintf('Badanie normalno�ci rozk�ad�w.\n');
% Nie s� znane dok�adne warto�ci �rednich oraz odchyle� standardowych
% populacji z jakich pochodz� pr�bki, wi�c kstest odpada.
% h0: rozk�ad jest normalny
% h1: rozk�ad nie jest normalny
% swtest - rekomendowany dla <20 element�w
[h,p] = swtest(results2004);
fprintf('SWTEST results2004: h=%d, p=%f\n',h,p);
[h,p] = swtest(results2008);
fprintf('SWTEST results2008: h=%d, p=%f\n',h,p);
[h,p] = swtest(results2012);
fprintf('SWTEST results 2012: h=%d, p=%f\n',h,p);
% lillietest - bardzo dobry dla <30 element�w
[h,p] = lillietest(results2004);
fprintf('LILLIETEST results2004: h=%d, p=%f\n',h,p);
[h,p] = lillietest(results2008);
fprintf('LILLIETEST results2008: h=%d, p=%f\n',h,p);
[h,p] = lillietest(results2012);
fprintf('LILLIETEST results2012: h=%d, p=%f\n',h,p);
% WNIOSKI: z 95% prawdopodobie�stwem rozk�ady nie s� normalne. Co ciekawe,
% przy odpowiednim zmniejszeniu pr�bek, z 30 do 20-25 rozk�ady s� normalne.
% Jest to o tyle ciekawe, �e wraz z wzrostem liczno�ci pr�b rozk�ady
% powinny d��y� do normalno�ci. Na histogramach wida�, �e rozk�ady s�
% dodatnio sko�ne, co mo�e oznacza�, �e w trakcie zawod�w osoby, kt�re
% wiedzia�y, �e nie maj� szans na awans do fina�u, w zrezygnowaniu p�yne�y
% gorzej, zaburzaj�c rozk�ad. Po odrzuceniu kilku najgorszych wynik�w
% rozk�ady s� normalne.
%% plotowanie histogram�w i boxplotu
figure(1);
subplot(231); histogram(results2004);
title('2004'); xlabel('miejsce w eliminacjach'); ylabel('t[s]');
grid on; grid minor;
subplot(232); histogram(results2008);
title('2008'); xlabel('miejsce w eliminacjach'); ylabel('t[s]');
grid on; grid minor;
subplot(233); histogram(results2012);
title('2012'); xlabel('miejsce w eliminacjach'); ylabel('t[s]');
grid on; grid minor;
subplot(234);
boxplot([results2004,results2008,results2012],'Labels',{'2004','2008','2012'});
title('Wyniki eliminacji'); grid on; grid minor;
%% ZAD3. Sprawdzanie r�wno�ci cechy we wszystkich populacjach
fprintf('**********ZAD.3.**********\n');
% poniewa� odrzucono hipotezy o normalno�ci rozk�ad�w, zastosowany zostanie
% test Kruskala-Willisa.
% h0: �rednie s� takie same
% h1: przynajmniej jedna �rednia odstaje od pozosta�ych
fprintf('KRUSKAL-WILLIS dla eliminacji z 3 olimpiad: %d\n',kruskalwallis(results));
% WNIOSEK: Z 95% prawdopodobie�stwem, przynajmniej jedna �rednia odstaje od
% pozosta�ych.
%% ZAD4. Por�wnanie cechy w populacjach
fprintf('**********ZAD.4.**********\n');
% poniewa� odrzucono hipotezy o normalno�ci rozk�ad�w, zastosowany zostanie
% test U-Manna-Whitneya. Test ten por�wnuje mediany, a dok�adniej
% prawdopodobie�stwo, �e jedna z nich jest znacz�co wy�sza od drugiej. Jego
% za�o�eniem jest niezale�no�� badanych pr�b. Zbadano j� analizuj�c
% przedstawione dane. Liczba zawodnik�w, kt�rzy wyst�powali w tej kategorii
% w r�nych olimpiadach jest niedluga
% h0: P(X>Y)==P(X<Y)
% h1: P(X>Y)>P(Y>X) - X wi�ksze od Y
fprintf('h1: 2004 > 2008\n');
[p,h] = ranksum(results2004, results2008,'tail','right');
fprintf('RANKSUM: h=%d, p=%f\n',h,p);
fprintf('Przyjmujemy hipotez� h1.\n');
% pvalue jedno i dwustronne sa mniejsze od poziomu istotnosci 0.05, wiec
% przyjeto hipoteze h1, ze jeden z rozkladow ma wartosci wyzsze niz drugi
fprintf('h1: 2004 > 2012\n');
[p,h] = ranksum(results2004, results2012,'tail','right');
fprintf('RANKSUM: h=%d, p=%f\n',h,p);
fprintf('Przyjmujemy hipotez� h1\n');
% pvalue jedno i dwustronne sa mniejsze od poziomu istotnosci 0.05, wiec
% przyjeto hipoteze h1, ze jeden z rozkladow ma wartosci wyzsze niz drugi
fprintf('h1: 2008 > 2012\n');
[p,h] = ranksum(results2008, results2012,'tail','right');
fprintf('RANKSUM: h=%d, p=%f\n',h,p);
fprintf('Nie ma podstaw do odrzucenia h0\n');
% WNIOSKI: Najwy�sz� median� ma rok 2004, dla 2008 i 2012 s� one zbli�one.

% pvalue wi�ksze od poziomu istotno�ci 0.05, wiec z 95% prawdopodobie�stwem
% przyjeto hipoteze h0, �e prawdopodobie�stwo �e 1. rozk�ad ma �redni�
% wy�sz� od drugiego jest r�wne prawdopobie�stwu, �e ten drugi ma wy�sz� od
% 1., czyli �rednie rozk�ad�w s� r�wne
%% ZAD5. Sprawdzanie testem czy mediana jest mniejsza od mediany 
fprintf('**********ZAD.5.**********\n');
% wyznaczonej w punkcie 2. + 10%. Zastosowano test znak�w gdy� nie wymaga
% on normalno�ci rozk�ad�w
% m = 1.1* median(x)
% h0: median = m
% h1: median < m
[p,h] = signtest(results2004, median(results2004)*1.1,'tail','left');
fprintf('SIGNTEST: h=%d, p=%f\n',h,p);
% WNIOSEK: Przyj�to h1, mediana jest mniejsza od mediany powi�kszonej o 10%
[p,h] = signtest(results2008, median(results2008)*1.1,'tail','left');
fprintf('SIGNTEST: h=%d, p=%f\n',h,p);
% WNIOSEK: Przyj�to h1, mediana jest mniejsza od mediany powi�kszonej o 10%
[p,h] = signtest(results2012, median(results2012)*1.1,'tail','left');
fprintf('SIGNTEST: h=%d, p=%f\n',h,p);
% WNIOSEK: Przyj�to h1, mediana jest mniejsza od mediany powi�kszonej o 10%
%% ZAD6. Przedzia� ufno�ci dla �redniej i wariancji
fprintf('**********ZAD.6.**********\n');
SEM = std(results2004)/sqrt(length(results2004));     % Standard Error
ts = tinv([0.005 0.025  0.975 0.995],length(results2004)-1);      % T-Score
CI = mean(results2004) + ts*SEM;                      % Confidence Intervals
fprintf('2004: przedzia� ufno�ci �redniej (ze �redni�) 95%%:\t[%4.1f, %4.1f, %4.1f]\n',CI(2),mean(results2004), CI(3));
fprintf('2004: przedzia� ufno�ci �redniej (ze �redni�) 99%%:\t[%4.1f, %4.1f, %4.1f]\n',CI(1),mean(results2004), CI(4));
fprintf('\n');
SEM = std(results2008)/sqrt(length(results2008));     % Standard Error
ts = tinv([0.005 0.025  0.975 0.995],length(results2008)-1);      % T-Score
CI = mean(results2008) + ts*SEM;                      % Confidence Intervals
fprintf('2008: przedzia� ufno�ci �redniej (ze �redni�) 95%%:\t[%4.1f, %4.1f, %4.1f]\n',CI(2),mean(results2008), CI(3));
fprintf('2008: przedzia� ufno�ci �redniej (ze �redni�) 99%%:\t[%4.1f, %4.1f, %4.1f]\n',CI(1),mean(results2008), CI(4));
fprintf('\n');
SEM = std(results2012)/sqrt(length(results2012));     % Standard Error
ts = tinv([0.005 0.025  0.975 0.995],length(results2012)-1);      % T-Score
CI = mean(results2012) + ts*SEM;                      % Confidence Intervals
fprintf('2012: przedzia� ufno�ci �redniej (ze �redni�) 95%%:\t[%4.1f, %4.1f, %4.1f]\n',CI(2),mean(results2012), CI(3));
fprintf('2012: przedzia� ufno�ci �redniej (ze �redni�) 99%%:\t[%4.1f, %4.1f, %4.1f]\n',CI(1),mean(results2012), CI(4));
fprintf('\n');