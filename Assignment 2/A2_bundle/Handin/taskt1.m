%% Task T1
% calculate kernel matrix 
x = [-2, -1, 1, 2]'; 
phi = @(x) [x, x.^2]'; 
k = @(phi, x, y) phi(x)'*phi(y); 
K = k(phi, x, x); 