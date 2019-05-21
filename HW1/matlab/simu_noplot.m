tspan = [0 250]; %reasonable time for steady state
% from slide 37 we choose some initial conditions 
xeq1 = [5; 67];     % close to one equilibrium
xeq2 = [18; 30];    % close to another
% first equilibrium point
[t1, x1] = ode45('exo', tspan, xeq1);
% steady state value
xsim_eq1 = x1(length(t1), :)
% second equilibrium point
[t2, x2] = ode45('exo', tspan, xeq2);
% steady state value
xsim_eq2 = x2(length(t2), :)