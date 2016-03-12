function l03e05
%pkg load statistics;
%pkg load nan;
f = figure(5);
disp('Lista 3. Ćwiczenie 05.');
%% dane
load('../Dane/body_men.mat');
load('../Dane/body_women.mat');
body_men = reshape(body_men(:,1),[],1);
body_women = reshape(body_women(:,1),[],1);
all=[body_men;body_women];
alfa = 0.05;
%% rozkłady 'teoretyczne'
all_t = normrnd(mean(all),std(all,1),100000,1);
men_t = normrnd(mean(body_men),std(body_men,1),100000,1);
women_t = normrnd(mean(body_women),std(body_women,1),100000,1);
%% plotowanie dystrybuanty
subplot(211);
h_all = cdfplot(all); hold on;
h_all_t = cdfplot(all_t);
grid on; grid minor;
legend('all - empiryczny','all - teoretyczny','location','northwest');
subplot(212);
h_men = cdfplot(body_men); hold on;
h_men_t = cdfplot(men_t); hold on;
h_women = cdfplot(body_women); hold on;
h_women_t = cdfplot(women_t);
grid on; grid minor;
legend('men - empiryczny','men - teoretyczny','women - empiryczny','women - teoretyczny','location','northwest');
%% testowanie normalności rozkładów
% h0: rozklad all jest normalny
% h1: rozklad all nie jest normalny
% output: H = 1, P = 0.0312727, KSSTAT = 0.0636941, CV = 0.0599766
% wniosek: hipoteza h0 została odrzucona, rozkład nie jest normalny
rozklad = all;
CDFall = normcdf(rozklad,mean(rozklad),std(rozklad,1));
[H,P,KSSTAT,CV] = kstest(rozklad,[rozklad,CDFall],alfa);
disp('all:');
disp(sprintf('H = %g, P = %g, KSSTAT = %g, CV = %g',H,P,KSSTAT,CV));
% h0: rozklad body_men jest normalny
% h1: rozklad body_men nie jest normalny
% output: H = 0, P = 0.369189, KSSTAT = 0.0577061, CV = 0.0857101
% wniosek: ksstat > cv nie jest spełnione, a p>alfa, wiec można potwierdzić
% h0
rozklad = body_men;
CDFall = normcdf(rozklad,mean(rozklad),std(rozklad,1));
[H,P,KSSTAT,CV] = kstest(rozklad,[rozklad,CDFall],alfa);
disp('body_men:');
disp(sprintf('H = %g, P = %g, KSSTAT = %g, CV = %g',H,P,KSSTAT,CV));
% h0: rozklad body_women jest normalny
% h1: rozklad body_women nie jest normalny
% output: H = 1, P = 0.0214595, KSSTAT = 0.0926953, CV = 0.0835579
% wniosek: hipoteza h0 została odrzucona, rozkład nie jest normalny
rozklad = body_women;
CDFall = normcdf(rozklad,mean(rozklad),std(rozklad,1));
[H,P,KSSTAT,CV] = kstest(rozklad,[rozklad,CDFall],alfa);
disp('body_women:');
disp(sprintf('H = %g, P = %g, KSSTAT = %g, CV = %g',H,P,KSSTAT,CV));
%% testowanie, czy rozkłady men i women są z tej samej dystrybucji
[H,P,KSSTAT] = kstest2(body_men, body_women);
disp('kstest2(men, women):');
disp(sprintf('H = %g, P = %g, KSSTAT = %g',H,P,KSSTAT));
%% wyglądy wykresu
set(h_all,'Color','b');
set(h_all,'linewidth',1);
set(h_men,'Color','b');
set(h_men,'linewidth',1);
set(h_women,'Color','c');
set(h_women,'linewidth',1);

set(h_all_t,'Color','m');
set(h_all_t,'linewidth',1);
set(h_men_t,'Color','m');
set(h_men_t,'linewidth',1);
set(h_women_t,'Color','m');
set(h_women_t,'linewidth',1);