%% Task T1
% calculate kernel matrix 
x = [-2, -1, 1, 2]'; 
phi = @(x) [x, x.^2]'; 
k = @(phi, x, y) phi(x)'*phi(y); 
K = k(phi, x, x); 
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
%% Task T2 alt
alpha = quadprog(y*K*y',-4, -1, 0, sum(y), 0); % Using that alpha_i = alpha_j for any pair i,j
%% Plot t3
clf
figure(1) 
hold on 
grid on 
xgrid = linspace(-3,3); 
ygrid = xgrid.^2; 
plot(xgrid,ygrid) 
xlabel("x", "FontSize", 14)
ylabel("x^2", "FontSize", 14)
%posy = y(y>0); 
posx = x(y>0); 
%negy = y(y < 0); 
negx = x(y <0);
plot(posx, posx.^2, 'o', 'color', 'g',  "MarkerSize", 11, "linewidth", 3)
plot(negx, negx.^2, 'x', 'color', 'r',  "MarkerSize", 11, "linewidth", 3) 
yline(2.5) 
upr =ones(100,1)*4;
lwr = ones(100,1)*1;
xgrid2 = [xgrid, fliplr(xgrid)];
inBetween = [upr', fliplr(lwr)'];
fill(xgrid2, inBetween, 'k', "facealpha", .2);
legend("Possible points in feature space","Positive class", "Negative class", "g(x) = 0 ", "Margin", "Fontsize", 10)
%% plot t4 
xnew = [-3, -2, -1, 0, 1, 2, 4]';
ynew = [1,1,-1,-1,-1,1,1]';
clf
figure(2) 
hold on 
grid on 
xgrid = linspace(-4,5); 
ygrid = xgrid.^2; 
plot(xgrid,ygrid) 
xlabel("x", "FontSize", 14)
ylabel("x^2", "FontSize", 14)
%posy = y(y>0); 
posx = xnew(ynew>0); 
%negy = y(y < 0); 
negx = xnew(ynew <0);
plot(posx, posx.^2, 'o', 'color', 'g',  "MarkerSize", 11, "linewidth", 3)
plot(negx, negx.^2, 'x', 'color', 'r',  "MarkerSize", 11, "linewidth", 3) 
yline(2.5) 
upr =ones(100,1)*4;
lwr = ones(100,1)*1;
xgrid2 = [xgrid, fliplr(xgrid)];
inBetween = [upr', fliplr(lwr)'];
fill(xgrid2, inBetween, 'k', "facealpha", .2);
legend("Possible points in feature space","Positive class", "Negative class", "g(x) = 0 ", "Margin", "Fontsize", 10)

