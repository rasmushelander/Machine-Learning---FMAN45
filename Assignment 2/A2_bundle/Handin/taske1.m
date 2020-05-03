%% Task E1
X = (train_data_01' - mean(train_data_01'))'; % centering
cov = 1/length(X)*X*X';
[w,D] = eig(cov); % columns in w are eigenvectors of unit length
X_new = w(:,1:2)'*X;%project X on first two principal components
figure(4) 
hold on 
cla
scatter(X_new(1,train_labels_01 == 0), X_new(2,train_labels_01 == 0))
scatter(X_new(1, train_labels_01 == 1), X_new(2, train_labels_01 == 1), '*')
xlabel("First principal component", "fontsize", 14)
ylabel("Second principal component", "fontsize", 14)
legend("Class 0", "Class 1","fontsize", 12)
axis tight