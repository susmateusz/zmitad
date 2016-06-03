clear; close;
%% wczytywanie danych
disp('Projekt');
fileID = fopen('Dane/2004_Women_200_metre_freestyle.csv');
men2004freestyle200 = textscan(fileID,'%s%s%f','delimiter',',');
men2004freestyle200times = men2004freestyle200{3}(:);
fclose(fileID);
fileID = fopen('Dane/2008_Women_200_metre_freestyle.csv');
men2008freestyle200 = textscan(fileID,'%s%s%f','delimiter',',');
men2008freestyle200times = men2008freestyle200{3}(:);
fclose(fileID);
fileID = fopen('Dane/2012_Women_200_metre_freestyle.csv');
men2012freestyle200 = textscan(fileID,'%s%s%f','delimiter',',');
men2012freestyle200times = men2012freestyle200{3}(:);
fclose(fileID);
%% badania rozk³adów
[h,p] = swtest(men2004freestyle200times);
fprintf('SWTEST: h=%d, p=%f\n',h,p);
[h,p] = swtest(men2008freestyle200times);
fprintf('SWTEST: h=%d, p=%f\n',h,p);
[h,p] = swtest(men2012freestyle200times);
fprintf('SWTEST: h=%d, p=%f\n',h,p);

minSize = min([size(men2004freestyle200times,1),size(men2008freestyle200times,1),size(men2012freestyle200times,1)])
min(men2004freestyle200times)
max(men2004freestyle200times)
min(men2008freestyle200times)
max(men2008freestyle200times)
min(men2012freestyle200times)
max(men2012freestyle200times)
subplot(231); histogram(men2004freestyle200times);
subplot(232); histogram(men2008freestyle200times);
subplot(233); histogram(men2012freestyle200times);
subplot(234); boxplot([men2004freestyle200times(1:minSize),men2008freestyle200times(1:minSize),men2012freestyle200times(1:minSize)]);