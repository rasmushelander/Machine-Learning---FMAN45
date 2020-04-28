%% Task T2
%maximize objective function
y = [1,-1,-1,1]';
H = y*y'.*K;
f = -[1, 1, 1, 1];
A = -eye(4,4);
b = zeros(4,1); 
Aeq = [y'; zeros(3,4)];
beq = zeros(4,1);
alpha = quadprog(H,f,A,b,Aeq,beq); 