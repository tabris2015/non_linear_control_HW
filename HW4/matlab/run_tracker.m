% script to run RIDF covariance analysis of antenna tracking
% problem, then plot results, no Monte Carlo stuff

global Kant         % cubic term coefficient for antenna NL
global Delta
tspan = [0 0.3];
x0 = [0.4 0 0.01 0 0]';     % column vector

Kant = 0;       % linear case first
[t1, x1] = ode45('tracker_ridf', tspan, x0);
subplot(211); plot(t1, x1(:,1),'-.r');ylabel('m, mean of x(1)');hold on;
subplot(212); plot(t1, sqrt(x1(:,3)),'-.r');ylabel('sigma, standard deviation of x(1)'); hold on;

Kant = 0.4;    
Delta = 0.4;
 % non linear case cubic nonlinearity
[tnl1, xnl1] = ode45('tracker_ridf', tspan, x0);
% non linear case saturation model
[tnl2, xnl2] = ode45('tracker_ridf_erf', tspan, x0);
subplot(211); plot(tnl1, xnl1(:,1), '--b'); hold on;
subplot(211); plot(tnl2, xnl2(:,1), ':k'); hold on;
%% annotate

plot([0.10 0.125], [.475 .475], '--b');
text(0.14, 0.475, 'cubic RIDF covariance solution')
plot([0.10 0.125], [.445 .445], ':k');
text(0.14, 0.445, 'saturation RIDF covariance solution')
plot([0.10 0.125], [.415 .415], '-.r');
text(0.14, 0.415, 'linearized covariance solution')

subplot(212); plot(tnl1,  sqrt(xnl1(:,3)), '--b'); hold on;
subplot(212); plot(tnl2,  sqrt(xnl2(:,3)), ':k'); hold on;
axis([0 0.3 0.08 0.35])
%% annotate
plot([0.10 0.125], [.115 .115], '--b');
text(0.14, 0.115, 'cubic RIDF covariance solution')
plot([0.10 0.125], [.1 .1], ':k');
text(0.14, 0.1, 'saturation RIDF covariance solution')
plot([0.10 0.125], [.090 .090], '-.r');
text(0.14, 0.090, 'linearized covariance solution')

