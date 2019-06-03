%% script stats.m
%
% process a 100-trial Monte Carlo ensemble
%
% JH Taylor - 11 Feb 1995
%
load x1p25data % data stored during a 100-trial run, Omega = 6
sum = 0.0; sum2 = 0.0; sum3 = 0.0; sum4 = 0.0;
ntrial = 100;
for j = 1:ntrial
   sum = sum + x1p25(j);
   sum2 = sum2 + x1p25(j)^2;
   sum3 = sum3 + x1p25(j)^3;
   sum4 = sum4 + x1p25(j)^4;
end
mean = sum/100.; m2 = mean*mean;
var = (sum2 - 100.*m2)/99; % unbiased
%% the following is biased but that's neglected
scm4 = (sum4 - 4.0*sum3*mean + 6.0*m2*sum2)/100. - 3.*m2*m2;
lambda = scm4/(var*var);
