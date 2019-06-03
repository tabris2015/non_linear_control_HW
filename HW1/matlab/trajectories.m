% limits for initial conditions
tspan = [0 30];
x1_min = -10;
x1_max = 45;
x2_min = 20;
x2_max = 80;
t_span = [0 10];
% plot eigen vectors
hold on;
grid('on')
xlabel('x1');
ylabel('x2');
title('trajectories simulation')
xlim([-5 25])
ylim([30 75])
% random initial conditions
for i=1:200
    random_x = [((x1_max - x1_min).*rand(1,1) + x1_min); ((x2_max - x2_min).*rand(1,1) + x2_min)];
    % plot simulation
    [t, x] = ode45('exo', tspan, random_x);
    plot(x(:,1), x(:,2), 'g');
end
% draw eigenvectors at equilibria
quiver(xmin_eq1(1), xmin_eq1(2), v1(1,1),v1(2,1),6*d1(1,1), 'k', 'LineWidth',3);
quiver(xmin_eq1(1), xmin_eq1(2), v1(1,2),v1(2,2),6*d1(2,2), 'k', 'LineWidth',3);

quiver(xmin_eq2(1), xmin_eq2(2), v2(1,1),v2(2,1),6*d2(1,1), 'b', 'LineWidth',3);
quiver(xmin_eq2(1), xmin_eq2(2), v2(2,1),v2(2,2),6*d2(2,2), 'b', 'LineWidth',3);

quiver(xmin_eq3(1), xmin_eq3(2), v3(1,1),v3(2,1),6*d3(1,1), 'r', 'LineWidth',3);
quiver(xmin_eq3(1), xmin_eq3(2), v3(1,2),v3(2,2),6*d3(2,2), 'r', 'LineWidth',3);

hold off;

