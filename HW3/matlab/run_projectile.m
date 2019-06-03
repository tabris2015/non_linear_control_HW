
tspan = [0 40]; %reasonable time for steady state
% random initial condition
m_v0 = 200;             % mean for initial velocity
sigma_v0 = 0.03;        % sigma for initial velocity
m_theta0 = deg2rad(45); % mean for initial angle (radians)
sigma_theta0 = 0.03;    % sigma for initial angle
lambda = 3;             % kurtosis (3 = gaussian)
n_sig = 1.96;           % n_sigma
% for montecarlo simulation
n_trials = 10000;        % runs
stats_idx = 1;          % index for fill in the statistics
final_d = []            % empty array
hold on;
title('ballistic trajectory problem')
xlabel('range[m]')
ylabel('height[m]')
t_1 = [0 3300]; x_1 = [0 0];
plot(t_1,x_1,'-')
for q = 1:n_trials
    % simulation parameters
    v0 = m_v0 + sigma_v0*randn;     % random initial velocity
    theta0 = m_theta0 + sigma_theta0*randn; % random initial angle
    % initial states for simulation;
    x0 = [0; v0*sin(theta0); 0; v0*cos(theta0)];    % initial states
    [t, x] = ode45('projectile_model', tspan, x0);  % simulate
    final_d = [final_d; x(length(t), 3)];           % save final distance
   
    if mod(q, 100) == 0 % every 100 trials
        % plot trajectory
        plot(x(:,3), x(:,1));
        % compute statistics
        m_hat(stats_idx) = sum(final_d) / q
        dif_sq = (final_d - m_hat(stats_idx)).^2;
        p_hat = sum(dif_sq) / (q -1);
        debias = q/(q-1);
        sigma(stats_idx) = sqrt(debias*p_hat);          % save sigma
        % confidence limits for sigma
        sigma_low(stats_idx) = sigma(stats_idx)/(1 + n_sig * sqrt((lambda -1)/q));
        sigma_high(stats_idx) = sigma(stats_idx)/(1 - n_sig * sqrt((lambda -1)/q));
        % confidence limits for m
        m_low(stats_idx) = m_hat(stats_idx) - (n_sig * sigma(stats_idx))/sqrt(q);
        m_high(stats_idx) = m_hat(stats_idx) + (n_sig * sigma(stats_idx))/sqrt(q);
        stats_idx = stats_idx + 1;
    end
end
hold off
%%
% plot statistics
% mean distance
figure
t_plot = 1:length(sigma);

plot(t_plot, m_hat, t_plot, m_high, '+', t_plot, m_low, '+')
title('mean impact distance')
xlabel('cummulative set number x100')
ylabel('mean impact distance')
% sigma
figure

plot(t_plot, sigma, t_plot, sigma_high, '+', t_plot, sigma_low, '+')
title('sigma impact distance')
xlabel('cummulative set number x100')
ylabel('sigma impact distance')


