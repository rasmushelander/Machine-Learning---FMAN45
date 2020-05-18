%% train and evaluate 
[pred, y_test] = mnist_starter();
x_test = loadMNISTImages('data/mnist/t10k-images.idx3-ubyte');
y_test_2 = loadMNISTLabels('data/mnist/t10k-labels.idx1-ubyte');
%% show misclassifications 
misses = (pred ~= y_test);
idx = find(misses); 
figure(1)
t = tiledlayout(2,3); 
for i = 1:6
    nexttile
    p = pred(idx(i)); 
    y = y_test(idx(i)); 
    im = reshape(x_test(:,idx(i)), 28,28); 
    imshow(im, 'InitialMagnification','fit')
    xlabel(sprintf('Prediction: %d', p))
end 

%% confusion matrix, precision and recall 
figure(2) 
C = confusionmat(y_test, pred); 
confusionchart(C) 
p = zeros(1,10) ;
r = zeros(1,10) ;
for i=1:10
    p(i) = precision(i, C); 
    r(i) = recall(i,C); 
end 
%% visualize filters 
net = load('network_trained_with_momentum.mat'); 
filters = net.net.layers{1, 2}.params.weights; 
figure(3) 
t = tiledlayout(4,4); 
for i = 1:16 
    nexttile
    im = filters(:,:,1,i); 
    imshow(im, 'InitialMagnification','fit')
    xlabel(sprintf('Filter %d', i))
end
%% functions for precision and recall 
function p = precision(class, confusion_matrix) 
    tp = confusion_matrix(class, class); 
    predicted = sum(confusion_matrix(:,class));
    p = tp/predicted;
end
function r = recall(class, confusion_matrix)
    tp = confusion_matrix(class, class) ;
    true = sum(confusion_matrix(class, :));
    r = tp/true; 
end