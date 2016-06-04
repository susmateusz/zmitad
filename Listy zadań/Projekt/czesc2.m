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
%% wyrównywanie d³ugoœci
minSize = min([size(results2004,1),size(results2008,1),size(results2012,1)]);
minSize = 30;
results2004 = results2004(1:minSize);
results2008 = results2008(1:minSize);
results2012 = results2012(1:minSize);
results = [results2004, results2008, results2012];
%% ZAD2. badania parametrów rozk³adów
fprintf('**********ZAD.2.**********\n');
fprintf('MEAN for 2004, 2008, 2012:\t\t\t[%6.1f, %6.1f, %6.1f]\n',mean(results));
fprintf('STD for 2004, 2008, 2012:\t\t\t[%6.1f, %6.1f, %6.1f]\n',std(results));
fprintf('MIN for 2004, 2008, 2012:\t\t\t[%6.1f, %6.1f, %6.1f]\n',min(results));
fprintf('1.KWANTYL for 2004, 2008, 2012:\t\t[%6.1f, %6.1f, %6.1f]\n',quantile(results,0.25));
fprintf('MEDIAN for 2004, 2008, 2012:\t\t[%6.1f, %6.1f, %6.1f]\n',median(results));
fprintf('3.KWANTYL for 2004, 2008, 2012:\t\t[%6.1f, %6.1f, %6.1f]\n',quantile(results,0.75));
fprintf('MAX for 2004, 2008, 2012:\t\t\t[%6.1f, %6.1f, %6.1f]\n',max(results));
%% za³o¿enie o normalnoœci rozk³adu
fprintf('*************************************************************\n');
fprintf('Badanie normalnoœci rozk³adów.\n');
% Nie s¹ znane dok³adne wartoœci œrednich oraz odchyleñ standardowych
% populacji z jakich pochodz¹ próbki, wiêc kstest odpada.
% h0: rozk³ad jest normalny
% h1: rozk³ad nie jest normalny
% swtest - rekomendowany dla <20 elementów
[h,p] = swtest(results2004);
fprintf('SWTEST results2004: h=%d, p=%f\n',h,p);
[h,p] = swtest(results2008);
fprintf('SWTEST results2008: h=%d, p=%f\n',h,p);
[h,p] = swtest(results2012);
fprintf('SWTEST results 2012: h=%d, p=%f\n',h,p);
% lillietest - bardzo dobry dla <30 elementów
[h,p] = lillietest(results2004);
fprintf('LILLIETEST results2004: h=%d, p=%f\n',h,p);
[h,p] = lillietest(results2008);
fprintf('LILLIETEST results2008: h=%d, p=%f\n',h,p);
[h,p] = lillietest(results2012);
fprintf('LILLIETEST results2012: h=%d, p=%f\n',h,p);
% WNIOSKI: z 95% prawdopodobieñstwem rozk³ady nie s¹ normalne. Co ciekawe,
% przy odpowiednim zmniejszeniu próbek, z 30 do 20-25 rozk³ady s¹ normalne.
% Jest to o tyle ciekawe, ¿e wraz z wzrostem licznoœci prób rozk³ady
% powinny d¹¿yæ do normalnoœci. Na histogramach widaæ, ¿e rozk³ady s¹
% dodatnio skoœne, co mo¿e oznaczaæ, ¿e w trakcie zawodów osoby, które
% wiedzia³y, ¿e nie maj¹ szans na awans do fina³u, w zrezygnowaniu p³yne³y
% gorzej, zaburzaj¹c rozk³ad. Po odrzuceniu kilku najgorszych wyników
% rozk³ady s¹ normalne.
%% plotowanie histogramów i boxplotu
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
%% ZAD3. Sprawdzanie równoœci cechy we wszystkich populacjach
fprintf('**********ZAD.3.**********\n');
% poniewa¿ odrzucono hipotezy o normalnoœci rozk³adów, zastosowany zostanie
% test Kruskala-Willisa.
% h0: œrednie s¹ takie same
% h1: przynajmniej jedna œrednia odstaje od pozosta³ych
fprintf('KRUSKAL-WILLIS dla eliminacji z 3 olimpiad: %d\n',kruskalwallis(results));
% WNIOSEK: Z 95% prawdopodobieñstwem, przynajmniej jedna œrednia odstaje od
% pozosta³ych.
%% ZAD4. Porównanie cechy w populacjach
fprintf('**********ZAD.4.**********\n');
% poniewa¿ odrzucono hipotezy o normalnoœci rozk³adów, zastosowany zostanie
% test U-Manna-Whitneya. Test ten porównuje mediany, a dok³adniej
% prawdopodobieñstwo, ¿e jedna z nich jest znacz¹co wy¿sza od drugiej. Jego
% za³o¿eniem jest niezale¿noœæ badanych prób. Zbadano j¹ analizuj¹c
% przedstawione dane. Liczba zawodników, którzy wystêpowali w tej kategorii
% w ró¿nych olimpiadach jest niedluga
% h0: P(X>Y)==P(X<Y)
% h1: P(X>Y)>P(Y>X) - X wiêksze od Y
fprintf('h1: 2004 > 2008\n');
[p,h] = ranksum(results2004, results2008,'tail','right');
fprintf('RANKSUM: h=%d, p=%f\n',h,p);
fprintf('Przyjmujemy hipotezê h1.\n');
% pvalue jedno i dwustronne sa mniejsze od poziomu istotnosci 0.05, wiec
% przyjeto hipoteze h1, ze jeden z rozkladow ma wartosci wyzsze niz drugi
fprintf('h1: 2004 > 2012\n');
[p,h] = ranksum(results2004, results2012,'tail','right');
fprintf('RANKSUM: h=%d, p=%f\n',h,p);
fprintf('Przyjmujemy hipotezê h1\n');
% pvalue jedno i dwustronne sa mniejsze od poziomu istotnosci 0.05, wiec
% przyjeto hipoteze h1, ze jeden z rozkladow ma wartosci wyzsze niz drugi
fprintf('h1: 2008 > 2012\n');
[p,h] = ranksum(results2008, results2012,'tail','right');
fprintf('RANKSUM: h=%d, p=%f\n',h,p);
fprintf('Nie ma podstaw do odrzucenia h0\n');
% WNIOSKI: Najwy¿sz¹ medianê ma rok 2004, dla 2008 i 2012 s¹ one zbli¿one.

% pvalue wiêksze od poziomu istotnoœci 0.05, wiec z 95% prawdopodobieñstwem
% przyjeto hipoteze h0, ¿e prawdopodobieñstwo ¿e 1. rozk³ad ma œredni¹
% wy¿sz¹ od drugiego jest równe prawdopobieñstwu, ¿e ten drugi ma wy¿sz¹ od
% 1., czyli œrednie rozk³adów s¹ równe
%% ZAD5. Sprawdzanie testem czy mediana jest mniejsza od mediany 
fprintf('**********ZAD.5.**********\n');
% wyznaczonej w punkcie 2. + 10%. Zastosowano test znaków gdy¿ nie wymaga
% on normalnoœci rozk³adów
% m = 1.1* median(x)
% h0: median = m
% h1: median < m
[p,h] = signtest(results2004, median(results2004)*1.1,'tail','left');
fprintf('SIGNTEST: h=%d, p=%f\n',h,p);
% WNIOSEK: Przyjêto h1, mediana jest mniejsza od mediany powiêkszonej o 10%
[p,h] = signtest(results2008, median(results2008)*1.1,'tail','left');
fprintf('SIGNTEST: h=%d, p=%f\n',h,p);
% WNIOSEK: Przyjêto h1, mediana jest mniejsza od mediany powiêkszonej o 10%
[p,h] = signtest(results2012, median(results2012)*1.1,'tail','left');
fprintf('SIGNTEST: h=%d, p=%f\n',h,p);
% WNIOSEK: Przyjêto h1, mediana jest mniejsza od mediany powiêkszonej o 10%
%% ZAD6. Przedzia³ ufnoœci dla œredniej i wariancji
fprintf('**********ZAD.6.**********\n');
SEM = std(results2004)/sqrt(length(results2004));     % Standard Error
ts = tinv([0.005 0.025  0.975 0.995],length(results2004)-1);      % T-Score
CI = mean(results2004) + ts*SEM;                      % Confidence Intervals
fprintf('2004: przedzia³ ufnoœci œredniej (ze œredni¹) 95%%:\t[%4.1f, %4.1f, %4.1f]\n',CI(2),mean(results2004), CI(3));
fprintf('2004: przedzia³ ufnoœci œredniej (ze œredni¹) 99%%:\t[%4.1f, %4.1f, %4.1f]\n',CI(1),mean(results2004), CI(4));
fprintf('\n');
SEM = std(results2008)/sqrt(length(results2008));     % Standard Error
ts = tinv([0.005 0.025  0.975 0.995],length(results2008)-1);      % T-Score
CI = mean(results2008) + ts*SEM;                      % Confidence Intervals
fprintf('2008: przedzia³ ufnoœci œredniej (ze œredni¹) 95%%:\t[%4.1f, %4.1f, %4.1f]\n',CI(2),mean(results2008), CI(3));
fprintf('2008: przedzia³ ufnoœci œredniej (ze œredni¹) 99%%:\t[%4.1f, %4.1f, %4.1f]\n',CI(1),mean(results2008), CI(4));
fprintf('\n');
SEM = std(results2012)/sqrt(length(results2012));     % Standard Error
ts = tinv([0.005 0.025  0.975 0.995],length(results2012)-1);      % T-Score
CI = mean(results2012) + ts*SEM;                      % Confidence Intervals
fprintf('2012: przedzia³ ufnoœci œredniej (ze œredni¹) 95%%:\t[%4.1f, %4.1f, %4.1f]\n',CI(2),mean(results2012), CI(3));
fprintf('2012: przedzia³ ufnoœci œredniej (ze œredni¹) 99%%:\t[%4.1f, %4.1f, %4.1f]\n',CI(1),mean(results2012), CI(4));
fprintf('\n');