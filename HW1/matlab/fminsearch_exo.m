% equilibrium by fminsearch
% from slide 37 we choose some initial conditions 
xeq1 = [1 70];
xmin_eq1 = fminsearch('mag_sq_xdot' , xeq1)

xeq2 = [20 30];
xmin_eq2 = fminsearch('mag_sq_xdot' , xeq2)

xeq3 = [10 49];
xmin_eq3 = fminsearch('mag_sq_xdot' , xeq3)
