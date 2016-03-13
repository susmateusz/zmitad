%pkg load statistics;
%pkg load nan;
%f = figure(06);
%% wczytywanie danych
disp('Lista 3. Ćwiczenie 06.');
fd = fopen('../Dane/pacjenci.csv');
formatSpec = '%f,%f,%f,%s';
C = textscan(fd,formatSpec,'HeaderLines',1);
fclose(fd);
%% podział danych
data_length = size(C{1},1);
height_men =[];     % zeros(sum(cell2mat(C{4})=='M'),1);
height_women = [];  % zeros(sum(cell2mat(C{4})=='K'),1);
for i=1:data_length,
    if C{4}{i}=='M',
        height_men = [height_men; C{1}(i)];
    else
        height_women = [height_women; C{1}(i)];
    end
end
%% badanie podobieństwa rozkładów kstestem
% h0: wzrost mężczyzn i kobiet mają takie same rozkłady
% h1: wzrost mężczyzn i kobiet mają różne rozkłady
[H,P,KSSTAT] = kstest2(height_men, height_women);
disp(sprintf('H = %g, P = %g, KSSTAT = %g',H,P,KSSTAT));
% H = 0, P = 0.997877, KSSTAT = 0.147436
% hipoteza h0 została przyjęta