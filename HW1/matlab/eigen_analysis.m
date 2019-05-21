% Eigenvalues and eigenvectors analysis
% first equilibrium
A1 = linear_exo(xmin_eq1)
[v1 d1] = eig(A1)
% second equilibrium
A2 = linear_exo(xmin_eq2)
[v2 d2] = eig(A2)
% third equilibrium
A3 = linear_exo(xmin_eq3)
[v3 d3] = eig(A3)