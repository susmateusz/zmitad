function l03e05
%pkg load statistics;
%pkg load nan;
f = figure(5);
disp('Lista 3. Ćwiczenie 05.');
%% dane
load('../Dane/body_men.mat',body_men);
load('../Dane/body_women.mat');
all=[body_men;body_women];
%% plotowanie dystrybuanty
subplot(211);
CDFall = normcdf(all,mean(all), std(all,1));
[H,P,KSSTAT,CV] = kstest(all,[all,CDFall],0.05);
%cdfplot(all(:,1),'r','linewidth',1);
grid on; grid minor;
subplot(212);
cdfplot(body_men(:,1),'b','linewidth',1); hold on;
cdfplot(body_women(:,1),'r','linewidth',1);
grid on; grid minor;
waitfor(f);