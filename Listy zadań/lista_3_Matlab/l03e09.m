%pkg load statistics;
%pkg load nan;
disp('Lista 3. Ćwiczenie 09.');
%% dane
load('../Dane/body_men.mat');
load('../Dane/body_women.mat');
body_men = reshape(body_men(:,1),[],1);
body_women = reshape(body_women(:,1),[],1);
all=[body_men;body_women];
alfa = 0.05;
%% testowanie normalności
% h0: rozklad body_men jest normalny
% h1: rozklad body_men nie jest normalny
% H = 1, P = 0.0468918, LSTAT = 0.0575228, CV = 0.0571118
% wniosek: hipoteza h1 zostaje przyjęta, rozkład nie jest normalny
rozklad = body_men;
[H,P,LSTAT,CV] = lillietest(rozklad);
disp('body_men:');
disp(sprintf('H = %g, P = %g, LSTAT = %g, CV = %g',H,P,LSTAT,CV));


% h0: rozklad body_women jest normalny
% h1: rozklad body_women nie jest normalny
% H = 1, P = 0.001, LSTAT = 0.0929239, CV = 0.0556857
% wniosek: hipoteza h1 zostaje przyjęta, rozkład nie jest normalny
rozklad = body_women;
[H,P,LSTAT,CV] = lillietest(rozklad);
disp('body_women:');
disp(sprintf('H = %g, P = %g, LSTAT = %g, CV = %g',H,P,LSTAT,CV));

% wnioski: otrzymane wyniki różnią się od wyników kstestu, gdzie rozkład
% body_men został zaklasyfikowany jako normalny