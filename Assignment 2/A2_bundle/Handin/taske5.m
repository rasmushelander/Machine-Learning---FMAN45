%% Task E5 
K = 100:101; 
mc_rate = zeros(1,2); 
for i = 1:2
   [y, C] = K_means_clustering(train_data_01, K(i)); 
   c = K_means_classifier(train_data_01, C);
    cluster_labels = assign_cluster_labels(c, train_labels_01); 
    y_pred_test = pred(test_data_01, C, cluster_labels); 
    mc_rate(i) = sum((test_labels_01' ~= y_pred_test))/length(test_labels_01);
end
%%
figure()
plot(K,mc_rate, "linewidth", 3)
grid on 
xlabel("Number of clusters", "FontSize", 13) 
ylabel("Misclassification rate on test set", "FontSize", 13)

function p = pred(X, C, cluster_labels)
    c = K_means_classifier(X, C);
    nsamples = size(X,2);
    p = zeros(1, nsamples);
    for i = 1:nsamples
        p(i) = cluster_labels(c(i));
    end
end
function cluster_labels = assign_cluster_labels(train_clusters, train_labels) 
    K = max(train_clusters);
    cluster_labels = zeros(1,K);
    for i=1:K
        cluster_labels(i) = mode(train_labels(train_clusters == i)); 
    end
end
function c = K_means_classifier(X, C)
    ncol = size(X,2);
    c = zeros(1,ncol);
    for i = 1:ncol
        x = X(:,i);
        d = vecnorm(x-C); 
        [~, c(i)] = min(d); 
    end
end