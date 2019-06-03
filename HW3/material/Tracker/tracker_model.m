function xdot = tracker(t,x,h,Q,seed)
% 
% Tracker nonlinear model, per my Trans AES paper of March 1978
%
% JH Taylor, 15 February 1995
%
A = 50.0;      % servo lag
K = 10.0;      % servo gain
Kant = 0.4;    % antenna cubic term coeff.
global Omega
%% set in macro  Omega = 6.0;   % nominal target angle rate
% random input generator:
noise = sqrt(Q/h)*randn;
xdot(1) = Omega - K*x(2);
xdot(2) = A*(noise + x(1) - Kant*x(1)*x(1)*x(1) - x(2));
