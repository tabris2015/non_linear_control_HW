function xdot = exo(t, x)
% Constants and known values
alpha = 3.0e+11;
beta = 2.8e+03;
gamma = 9;
sigma = 5;
V = 1000;
% constant inputs
u1 = 50.5;
u2 = 33.794;
u3 = 19.5037;
% non linear term
R = alpha * x(1) * exp(-beta/(x(2) + 46));
% space state ODEs
xdot(1) = (u1 / V) * (u3 - x(1)) - R;
xdot(2) = (u1 / V) * (u2 - x(2)) + (gamma / sigma) * R;
xdot = xdot(:); % column vector
