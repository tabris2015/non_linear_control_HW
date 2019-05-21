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

subplot(1, 2, 1)
plot(t1, x1(:,1), t1, x1(:,2),'--');
title('equilibrium solution 1')
xlabel('time, t(sec)')
ylabel('normalized concentration, normalized temperature')
text(150, 60, string(xsim_eq1), 'FontSize', 14)
subplot(1, 2, 2)
plot(t2, x2(:,1), t2, x2(:,2),'--');
title('equilibrium solution 2')
xlabel('time, t(sec)')
text(150, 32, string(xsim_eq2), 'FontSize', 14)



