%% script mc_targ.m
%
%  generate a Monte Carlo ensemble, gather and process statistics;
%  also save data for construction of a histogram
%
%  100 Monte Carlo Trials; step = dt = 0.002 sec probably equiv to AES runs
%
%  JH Taylor - 11 Feb 1995
%
%%  Initialize problem:
clear; close all;
global Omega
Omega = 6;
t0 = 0.0; tf = 0.5; x0 = [ 0.4 ; 0.0 ]; dt = 0.002;
m0 = 0.4; sig0=0.1; Q = 0.004; trace = 0;
Ntrial = 100;
%%  Allocate arrays:
Nsteps = 1+ceil(tf/dt);
Nstates = length(x0);
sum = zeros(Nsteps,Nstates);
sumsq = zeros(Nsteps,Nstates);
msamp = zeros(Nsteps,Nstates);
vsamp = zeros(Nsteps,Nstates);
sigma = zeros(Nsteps,Nstates);
%% Also gather stats for histogram at t = 0.25
x1p25 = zeros(Ntrial,1);
sumx1p25 = 0;
sumsqx1p25 = 0;
%%  Monte Carlo trial loop:
for j = 1:Ntrial
   x0 = [ m0 + sig0*randn ; 0.0 ]; % random IC for tracking error
   [t,x] = eurand('tracker_model',t0,tf,x0,dt,Q,0);  % 'seed' = last argument; ignore
   sum = sum + x;
   sumsq = sumsq + x.*x;
   %% catch value of x(0.25 sec) and do sums for statistics
   x1p25(j) = x(126,1); %% dt = 0.002 => t(126) = 0.25 sec
   sumx1p25 = sumx1p25 + x1p25(j);
   sumsqx1p25 = sumsqx1p25 + x1p25(j)^2;
   if j < 5
      plot(t,x(:,1)); % don't want to plot all states or all trials!
   end
   if j == 1
      xlabel('time');
      ylabel('m_1(t) and \sigma_1(t)');
      title(['tracker: AES paper, Omega = ',num2str(Omega),', ',num2str(Ntrial),' trials']);
      hold on
   end
   if trace
      j, randn('seed') % debug print
   end
end
%% end of trials -- process and plot statistics:
msamp = sum/Ntrial;
m1p25 = sumx1p25/Ntrial;
vsamp = sumsq/Ntrial - msamp.*msamp;
v1p25 = sumsqx1p25/Ntrial - m1p25^2;
debias = Ntrial/(Ntrial-1);
sigma = sqrt(debias*vsamp);
sig1p25 = sqrt(debias*v1p25);
%% Note: msamp and sigma may also be obtained using 'normfit'
plot(t,msamp(:,1),'o');
plot(t,sigma(:,1),'x');
axis([0 tf 0 1.25])
text(0.05,1.20,'oooooo = sample mean')
text(0.05,1.10,'xxxxxx = sample sigma')
plot([0.05 0.08],[1.0 1.0]), text(0.09,1.0,'First five trials')
save x1p25data x1p25 m1p25 sig1p25 %% save datas for histogram generation
%% end of script tracker_MCSim.m
