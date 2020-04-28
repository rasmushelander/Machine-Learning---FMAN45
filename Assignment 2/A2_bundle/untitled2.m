%% 3d array test 
c1 = [1,0]';
c2 = [0,1]';
c3 = [-1,0]';
c4 = [0,-1]';
C = [c3, c1, c4, c2];
K = length(C); 
a = [1,2]'; 
b = [3,4]';
c = [5,6]'; 
d = [1,0]';
e = [0,0]'; 
f = [-2, 0]';
X = [a,b,c, d, e, f]; 
[D, N] = size(X); 
Xhat = repmat(X, K ,1);
Xhat = reshape(Xhat, D, K, N); 
d = vecnorm(Xhat- C); 
d = reshape(d, K, N); 
[~, c] = min(d); 
dummies = dummyvar(c); % dummy variables for assigned clusters
dummies2 = (c == (1:K)')'; 
oldC = C; 
tempmat(isnan(tempmat)) = 0;
C = X*dummies./sum(dummies);
C2 = X*dummies2./sum(dummies2); 
nan_idx = isnan(C2); 
C2(nan_idx) = oldC(nan_idx) 

%% K-means clustering test 
cla
X1 = rand(2,100); 
X1 = X1 + [1,2]';
X2 = rand(2,34); 
X2 = X2 + [-4, 5]';
X = [X1, X2]; 
K = 5;
%C = repmat(mean(X,2),1,K) + repmat(std(X,[],2),1,K).*randn(D,K);
%scatter(C(1,:), C(2,:), 'g')
hold on 
%scatter(X(1,:), X(2,:))
[y, C] = K_means_clustering(X, K); 
for i = 1:K
    scatter(X(1, y == i), X(2, y == i))
end
%scatter(X(1, y == 1), X(2, y == 1), 'g')
%scatter(X(1, y == 2), X(2, y == 2), 'r')
scatter(C(1,:), C(2,:), 75, '*','r')
%%
c1 = [1,0]';
c2 = [0,1]';
c3 = [-1,0]';
c4 = [0,-1]';
C = [c3, c1, c4, c2];
K = length(C); 
a = [1,2]'; 
b = [3,4]';
c = [5,6]'; 
d = [1,0]';
e = [0,0]'; 
f = [-2, 0]';
X = [a,b,c, d, e, f]; 
K = length(C); 
[~, N] = size(X); 
d = zeros(K,N); 
    for i = 1:K
        d(i,:) = vecnorm(C(:,i)-X);
    end
%% Task E2 + E
K = [2 5];
for i = 1:2
    [y, C] = K_means_clustering(train_data_01, K(i));
    figure(i) 
    cla
    hold on 
    legends = [];
    for j = 1:K(i)
        scatter(X_new(1, y == j), X_new(2, y == j)); 
        legends = [legends, sprintf("Cluster %d", j)];
    end
    legend(legends, "fontsize", 13)
    xlabel("First principal component", "fontsize", 14)
    ylabel("Second principal component", "fontsize", 14)
    axis tight 
    C = reshape(C, 28,28,K(i)); 
    figure(i + 2)
    cla 
    t = tiledlayout(2,3); 

    for j = 1:K(i)
        nexttile
        imshow(C(:,:,j),'InitialMagnification','fit' )
        xlabel(sprintf("Cluster %d", j))
    end 

end
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


%% Task E4 + E5 
K = 2:30; 
mc_rate = zeros(1,29); 
for i = 1:29
   [y, C] = K_means_clustering(train_data_01, K(i)); 
   c = K_means_classifier(train_data_01, C);
    cluster_labels = assign_cluster_labels(c, train_labels_01); 
    y_pred_test = pred(test_data_01, C, cluster_labels); 
    mc_rate(i) = sum((test_labels_01' ~= y_pred_test))/length(test_labels_01);
end
plot(K,mc_rate)

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