function xdot = projectile_model(t,x)
    % Model constant and parameters
    global theta0;
    B = 0.01;       %N sec/m
    D = 3.0e-5;     % N sec^2/m^2
    M = 1;          % Kg
    g = 9.8;        %m/s^2
    % Compute useful values
    v = sqrt((x(2)^2) + (x(4)^2));
    theta = atan2(x(2), x(4));
    F = B*v + D*abs(v)^2;
    Fx = F * cos(theta);
    Fy = F * sin(theta);
    % State space
    xdot(1) = x(2);
    xdot(2) = -Fy - g;
    xdot(3) = x(4);
    xdot(4) = -Fx;
    % reset velocity if hit the ground
    if (x(1) <=0) && (t > 0) 
        xdot(1) = 0;
        xdot(3) = 0;
    end
    xdot = xdot(:);
end