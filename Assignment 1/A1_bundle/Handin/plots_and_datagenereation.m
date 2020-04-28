%% Task 4 
clf
figure(1)  
hold on 
lambdas = [0.1, 2, 10];
colors = ['r', 'm', 'b'];
i = 1;
num_non_zero = [];
for lambda = lambdas
    w = skeleton_lasso_ccd(t, X,lambda);
    plot(ninterp, Xinterp*w, 'linewidth', 3, 'Color', colors(i))
    plot(n, X*w, 'o', 'HandleVisibility','off', 'MarkerSize', 11, 'Color', colors(i))
    num_non_zero(i) = sum(abs(w) > 0); 
    i = i + 1;
end
plot(n, t, 'o','MarkerFaceColor', 'black', 'MarkerSize', 9) 
legend({'\lambda = 0.1', '\lambda = 2', '\lambda = 10','Measured outputs (t)'}, 'FontSize', 14) 
grid on
xlabel('time')
%% Task 5 (K-fold cv) 
lambdamin = 0.01;
lambdamax = 10;
lambdavec = exp(linspace(log(lambdamin), log(lambdamax)));
[wopt,lambdaopt,RMSEval,RMSEest] = skeleton_lasso_cv(t,X,lambdavec,10);
figure(2)
clf
hold on 
grid on 
axis tight
plot(log(lambdavec), RMSEval, 'linewidth', 3) 
plot(log(lambdavec), RMSEest, 'linewidth', 3)
xline(log(lambdaopt),'--',  'color' , 'r' , 'linewidth', 2)
legend('validation RMSE', 'training RMSE', 'optimal \lambda', 'FontSize', 14, 'location', 'northwest')
xlabel('ln(\lambda)', 'FontSize', 14)
figure(3) 
clf
hold on
grid on
plot(n, t, 'o','MarkerFaceColor', 'black', 'MarkerSize', 9) 
plot(ninterp, Xinterp*wopt, 'linewidth', 3)
legend({'Measured outputs (t)', 'Fitted line'}, 'FontSize', 14) 
xlabel('time', 'fontsize', 14) 
%% Task 6
lambdamin = 0.001;
lambdamax = 0.015;
lambdavec = exp(linspace(log(lambdamin), log(lambdamax), 50));
[wopt,lambdaopt,RMSEval,RMSEest] = skeleton_multiframe_lasso_cv(Ttrain, Xaudio,lambdavec,10);
figure(4)
clf
hold on 
grid on 
axis tight
plot(log(lambdavec), RMSEval, 'linewidth', 3) 
plot(log(lambdavec), RMSEest, 'linewidth', 3)
xline(log(lambdaopt),'--',  'color' , 'r' , 'linewidth', 2)
legend('validation RMSE', 'training RMSE', 'optimal \lambda', 'FontSize', 14, 'location', 'northwest')
xlabel('ln(\lambda)', 'FontSize', 14)
%% Task 7 
Ytest = lasso_denoise(Ttest, Xaudio, lambdaopt);
soundsc(Ytest, fs)
