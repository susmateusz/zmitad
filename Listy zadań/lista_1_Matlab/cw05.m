 DATA = load("-ascii", "dane/iris_repaired.txt");
 SL = DATA(:,1);
 SW = DATA(:,2);
 PL = DATA(:,3);
 PW = DATA(:,4);
 subplot(221);
 hist(SL,sqrt(length(SL)));
 title('SL');
 subplot(222);
 hist(SW,sqrt(length(SW)));
 title('SW');
 subplot(223);
 hist(PL,sqrt(length(PL)));
 title('PL');
 subplot(224);
 hist(PW,sqrt(length(PW)));
 title('PW');
 
 print -depsc cw05.eps
 
