close; clear;
disp('Lista 3. cwiczenie 09.');
%% dane
load('../Dane/body_men.mat');
load('../Dane/body_women.mat');
body_men = reshape(body_men(:,1),[],1);
body_women = reshape(body_women(:,1),[],1);
all=[body_men;body_women];
alfa = 0.05;
%% testowanie normalnosci rozkladow
% h0: rozklad body_men jest normalny
% h1: rozklad body_men nie jest normalny
% H = 1, P = 0.0468918, LSTAT = 0.0575228, CV = 0.0571118
% wniosek: hipoteza h1 zostaje przyjeta, rozklad nie jest normalny
rozklad = body_men;
[H,P,LSTAT,CV] = lillietest(rozklad);
disp('body_men:');
fprintf('H = %g, P = %g, LSTAT = %g, CV = %g\n',H,P,LSTAT,CV);

% h0: rozklad body_women jest normalny
% h1: rozklad body_women nie jest normalny
% H = 1, P = 0.001, LSTAT = 0.0929239, CV = 0.0556857
% wniosek: hipoteza h1 zostaje przyjeta, rozklad nie jest normalny
rozklad = body_women;
[H,P,LSTAT,CV] = lillietest(rozklad);
disp('body_women:');
fprintf('H = %g, P = %g, LSTAT = %g, CV = %g\n',H,P,LSTAT,CV);
%% wnioski:
% otrzymane wyniki roznia sie od wynikow kstestu, gdzie rozklad
% hipoteza normalnosci rozkladu body_men nie zostala odrzucona. W tym
% przypadku hipotezy h0 obu rozkladow zostaly odrzucone.  