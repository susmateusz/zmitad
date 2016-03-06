pkg load statistics;
%% funkcja testujaca hipoteze z uzyciem ttestu
% parametry
% zalozony sredni czas dostarczenia przesylki
m = 3;
% wylosowana proba
x = [1,1,1,2,2,2,2,3,3,3,4,4,4,4,4,5,5,6,6,6,7,7];
% dlugosc wylosowanej probki
n = 22;
% ttest
[h, pval, ci, stats] = ttest(x,m)


%% Wnioski
% h=0 - hipoteza zostala przyjeta
% pval=0.088 > a=0.05 czyli nie ma podstaw do uznania bledow pierwszego rodzaju
% ci=-0.11, 1.57 - przedzial ufnosci 
% tstat=1.78
% df=21 stopni swobody
% sd=1.90 odchylenie standardowe probki
% 
% 
