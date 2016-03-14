close; clear;
disp('Lista 3. Ćwiczenie 14.');
%% wczytywanie danych
alfa = 0.05;
fd = fopen('../Dane/absolwenci.csv');
formatSpec = '%s %s %s %f %s %s';
C = textscan(fd,formatSpec,'Delimiter',';','HeaderLines',1);
fclose(fd);
%% przetwarzanie danych
data_length = size(C{1},1);
place_rolnictwo = [];
place_pedagogika = [];
for i=1:data_length,
   if strcmp(C{3}{i},'Rolnictwo'),
       place_rolnictwo = [place_rolnictwo; C{4}(i)];
   else
       place_pedagogika = [place_pedagogika; C{4}(i)];
   end
end
%% testowanie
% h0: rozkład plac rolnictwa jest normalny
% h1: rozkład plac rolnictwa nie jest normalny
[H, pValue, W] = swtest(place_rolnictwo, alfa);
disp('rolnictwo:');
fprintf('H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 1, pValue = 1.20896e-08, W = 0.957191
% wniosek: rolnictwo - place nie maja rozkladu normalnego

% h0: rozkład plac w pedagogice jest normalny
% h1: rozkład plac w pedagogice nie jest normalny
[H, pValue, W] = swtest(place_pedagogika, alfa);
disp('pedagogika:');
fprintf('H = %g, pValue = %g, W = %g\n\n',H,pValue,W);
% output: H = 1, pValue = 3.09407e-10, W = 0.966776
% wniosek: pedagogika - płace mają rozkladu normalnego