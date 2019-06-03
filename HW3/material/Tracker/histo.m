%% script histo.m
%
% process a 100-trial Monte Carlo ensemble to inspect a histogram
% run mc_tracker first!
%
% JH Taylor - 8 Feb 2011
%
load x1p25data % data stored during a 100-trial run, Omega = 6
y1sort = sort(x1p25);
for i=1:100 xbogus(i) = i-1; end
figure; stairs(y1sort,xbogus)
title('Histogram of x_1(0.25 sec), Omega = 6, 100 trials')
ylabel('Sorted trial number')
xlabel('sorted x_1(0.25 sec)')
hold on
%%  now produce the F(x) for a Gaussian RV with the same
%%  mean and sigma to overlay; generate 401 points, from
%%  m - 3*sigma to m + 3*sigma
sqrt2 = sqrt(2);
for i = 1:601
   vmult = (i-301)/100;  % ranges from -3 to +3
   Pdf(i) = vmult*sig1p25 + m1p25; 
   Horiz(i) = 50*(1 + erf(vmult/sqrt2));
end
plot(Pdf,Horiz,'--')
legend('histogram of x_1(0.25)','F(x) for a Gaussian random variable','location','northwest')
text(0.75,30,['m_{sample} = ',num2str(m1p25)])
text(0.75,20,['\sigma_{sample} = ',num2str(sig1p25)])
