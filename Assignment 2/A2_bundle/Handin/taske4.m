%% Task E4
K = 2; 
[y, C] = K_means_clustering(train_data_01, K);
c = K_means_classifier(train_data_01, C);
cluster_labels = assign_cluster_labels(c, train_labels_01); 
y_pred_train = pred(train_data_01, C, cluster_labels); 
y_pred_test = pred(test_data_01, C, cluster_labels); 
cm_train = confusionmat(train_labels_01, y_pred_train);
cm_test = confusionmat(test_labels_01, y_pred_test);
mc_rate_train = sum((train_labels_01' ~= y_pred_train))/length(train_labels_01);
mc_rate_test = sum((test_labels_01' ~= y_pred_test))/length(test_labels_01);
