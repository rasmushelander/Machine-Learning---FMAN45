%% Task E6
clf = fitcsvm(train_data_01', train_labels_01); % train classifier 
y_pred_train = predict(clf, train_data_01'); % predictions on training data 
y_pred_test = predict(clf, test_data_01'); % prediction on test data 
cm_train = confusionmat(train_labels_01, y_pred_train); % confusion matrix for predictions on training data 
cm_test = confusionmat(test_labels_01, y_pred_test); %c onfusion matrix for prediction on test data 
N_train = length(train_labels_01); % number of training examples
N_test = length(test_labels_01); % number of test examples 