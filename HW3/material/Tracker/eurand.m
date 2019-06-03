function [tout, yout] = eurand(dyfun, t0, tfinal, y0, step, Q, seed, trace)
%EURAND	Solve differential equations, first-order method, stochastic processes.
%	EURAND integrates a system of ordinary differential equations using
%	the most elementary Euler algorithm.
%
%	INPUT:
%	dyfun - String containing name of user-supplied problem description.
%	        Call: ydot = fun(t,y) where dyfun = 'fun'.
%	        t     - Time (scalar).
%	        y     - Solution column-vector.
%	        ydot  - Returned derivative column-vector; ydot(i) = dy(i)/dt.
%	t0    - Initial value of t.
%	tfinal- Final value of t.
%	y0    - Initial value column-vector.
%   	step  - The specified integration step. (Default: step = 1.e-2).
%	q     - White noise spectral density
%	seed  - Seed to start 'randn' noise generator (to get repeatability)
%	trace - If nonzero, each step is printed. (Default: trace = 0).
%
%	OUTPUT:
%	T  - Returned integration time points (column-vector).
%	Y  - Returned solution, one solution column-vector per tout-value.
%	The result can be displayed by: plot(tout, yout).

%% Initialization - default input values, etc.
if nargin < 5, step = 1.e-2; end
if nargin < 6, Q = 1.0; end
if nargin < 7, seed = 0; end
if nargin < 8, trace = 0; end
t = t0;
h = step;
y = y0(:);
k = 1;
tout(k) = t;
yout(k,:) = y.';
if trace
   clc, t, h, y
end
%% The main loop
while (t < tfinal) 
   if t + h > tfinal, h = tfinal - t; end
   % Compute y-dot; has provision for random number generator!
   ydot = feval(dyfun, t, y, h, Q, seed); ydot = ydot(:);
   % Update the solution (with no check on error)
   t = t + h;
   y = y + h*ydot;
   %% Update solution
   k = k+1;
   tout(k) = t;
   yout(k,:) = y.';
   if trace
      home, t, h, y
   end
end
%% basic error handling
if (t < tfinal)
   disp('Singularity or model error likely.')
   t
end
tout = tout(1:k);
yout = yout(1:k,:);
%% end of routine eurand
