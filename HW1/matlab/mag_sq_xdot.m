% Shell function for fminsearch
function objective = mag_sq_xdot(x)
xdot = exo(0, x);
objective = xdot' * xdot;