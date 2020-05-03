%% Task T3
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