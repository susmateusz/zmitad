close; clear;
fprintf('Lista 6. Cwiczenie 1.');
%% dane
load('../Dane/anova_data.mat');
%% testowanie za³o¿eñ o normalnoœci rozk³adów
% h0: rozklad grupy 1. jest normalny
% h1: rozklad grupy 1. nie jest normalny
[H, pValue, W] = swtest(koala(:,1));
disp('Normalnosc rozkladu grupy koala nr 1:');
fprintf('H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.913768, W = 0.983736
% wniosek: Nie ma podstaw do odrzucenia hipotezy h0
% h0: rozklad grupy 2. jest normalny
% h1: rozklad grupy 2. nie jest normalny
[H, pValue, W] = swtest(koala(:,2));
disp('Normalnosc rozkladu grupy koala nr 2:');
fprintf('H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.37261, W = 0.966143
% wniosek: Nie ma podstaw do odrzucenia hipotezy h0
% h0: rozklad grupy 3. jest normalny
% h1: rozklad grupy 3. nie jest normalny
[H, pValue, W] = swtest(koala(:,3));
disp('Normalnosc rozkladu grupy koala nr 3:');
fprintf('H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 0, pValue = 0.751508, W = 0.980431
% wniosek: Nie ma podstaw do odrzucenia hipotezy h0
%% testowanie za³o¿eñ o identycznoœci wariancji
% wykorzystany zostanie vartestn, do testowania podobieñstwa wiêkszej
% iloœci wariancji
% h0: wariancje wszystkich grup s¹ podobne
% h1: wariancja przynajmniej jednej z grup odbiega od innych
p = vartestn(koala);
fprintf('Podobieñstwo wariancji grup koala:\n');
fprintf('pValue = %g\n\n',p);
% output: pValue = 0.781644
% wniosek: pValue>alfa, nie ma podstaw do odrzucenia hipotezy o
% podobieñstwie wariancji
%% testowanie œrednich (ANOVA)
% h0: z 95% prawdopodobieñstwem, populacje z których pochodz¹ wszystkie
% grupy maj¹ tak¹ sam¹ œredni¹
% h1: œrednia przynajmniej jednej z populacji znacz¹co ró¿ni siê od
% pozosta³ych œrednich
p = anova1(koala);
fprintf('ANOVA dla grup koala:\n');
fprintf('pValue = %g\n\n',p);
% output: pValue = 0.069034
% wniosek: z 95% prawdopodobieñstwem grupy pochodz¹ z populacji o takich
% samych œrednich