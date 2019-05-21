% small signal linearization of the system
function A = linear_exo(x)
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
% small signal linearization for operating point x
f11 = -(u1/V) - alpha * exp((-beta)/(x(2) + 46));
f12 = -(alpha * beta * x(1) * exp((-beta)/(x(2) + 46))) / ((x(2) + 46)^2);
f21 = (gamma * alpha * exp((-beta)/(x(2) + 46))) / sigma;
f22 = -(u1/V) + (alpha * beta * gamma * x(1) * exp((-beta)/(x(2) + 46))) / (sigma * (x(2) + 46)^2);
% A matrix for our system
A = [f11 f12; f21 f22];
