%% Gaussian kernel SVM 
misclassification_rate = @(y_true, y_pred) sum(y_true ~= y_pred)/length(y_true); % help function for misclassification rate 
betas = linspace(1, 25); % hyperparameter search grid
rates = []; 
for beta = betas % for each value of the hyperparameter, train model and calculate misclassification rate on test set
    clf = fitcsvm(train_data_01', train_labels_01, 'KernelFunction', 'gaussian', 'KernelScale', beta); 
    y_pred_test = predict(clf, test_data_01'); % prediction on test data 
    rate = misclassification_rate(test_labels_01, y_pred_test);
    rates = [rates rate];
end 
[~, opt_index] = max(rates); % index of best beta parameter
beta_opt = betas(opt_index); % value of best beta parameter 
clf = fitcsvm(train_data_01', train_labels_01, 'KernelFunction', 'gaussian', 'KernelScale', beta_opt); % refit svm using optimal beta parameter
y_pred_train = predict(clf, train_data_01'); % predictions on training data 
y_pred_test = predict(clf, test_data_01'); % prediction on test data 
cm_train = confusionmat(train_labels_01, y_pred_train); % confusion matrix for predictions on training data 
cm_test = confusionmat(test_labels_01, y_pred_test); %confusion matrix for prediction on test data 
N_train = length(train_labels_01); % number of training examples
N_test = length(test_labels_01); % number of test examples 

%% Plot hyperparameter search
figure(1) 
cla
hold on 
grid on 
plot(betas,1-rates, "linewidth", 2)
xline(beta_opt, 'linewidth', 2, 'color', 'r'); 
axis tight
legend('Misclassification rate', 'Optimal \beta', 'fontsize', 12) 
xlabel('\beta', 'fontsize', 12)
ylabel('Misclassification rate', 'fontsize', 12) 

