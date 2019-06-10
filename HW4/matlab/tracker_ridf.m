function xdot = tracker_ridf(t,x)
% RIDF m-dot P-dot model for antenna trackign problem
% "states" are m1, m2m p11, p12, p22
A = 50;         % sec^{-1}
K = 10;         % sec^{-1}
global Kant     % global variable
Omega = 5;      % deg/sec LOS angle rate
q = 0.004;        % dec^2

% case in paper _. x(0) = [0.4 0 0.01 0 0]
fhat = x(1) - Kant*x(1)*(x(1)*x(1) + 3*x(3));
Nr = 1 - 3*Kant*(x(1)*x(1) + x(3));
xdot(1) = -K*x(2) + Omega;
xdot(2) = A*(fhat - x(2));
P = [ x(3) x(4); x(4) x(5) ];
% test P stays positive semi-definite
T1 = P(1,1); T2 = det(P);
if T1 < 0, error('P(1,1) negative - bummer!'); return; end
if T2 < 0, error('P negative-def. - bummer!'); return; end
NR = [0 -K; A*Nr -A];
Q = [0 0; 0 A*A*q];
Pdot = NR*P + P*(NR') + Q;
xdot(3) = Pdot(1,1);
xdot(4) = (Pdot(1,2) + Pdot(2,1))/2;    % p simmetric
xdot(5) = Pdot(2,2);
xdot = xdot(:);