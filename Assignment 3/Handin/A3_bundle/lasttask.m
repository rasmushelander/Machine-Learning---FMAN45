 %% train and evaluate 
%[pred_1, y_test_1] = cifar10_starter(); 
%[pred_2, y_test_2] = cifar10_mod();
%[x_train, y_train, x_test, y_test, classes] = load_cifar10(2);
% [pred_2, y_test_2] = cifar10_mod_2();
[pred_2, y_test_2] = cifar10_mod_3();
%% show misclassifications 
misses = (pred_2 ~= y_test);
idx = find(misses); 
figure(1)
t = tiledlayout(2,3); 
for i = 1:6
    nexttile
    p = pred_2(idx(i)); 
    p = classes{p};
    y = y_test(idx(i));
    y = classes{y};
    %im = reshape(x_test(:,idx(i)), 32,32, 3); 
    imagesc(x_test(:,:,:,idx(i))/255);

    %imshow(im, 'InitialMagnification','fit')
    xlabel(strcat(sprintf('Prediction: %s', p), sprintf('. True: %s', y))) 
end 

%% confusion matrix, precision and recall 
figure(4) 
y = {};
pr = {};
for i=1:length(y_test_2)
    y{i} = classes{y_test_2(i)};
    pr{i} = classes{pred_2(i)};
end
C = confusionmat(y,pr); 
cm = confusionchart(y, pr);
%cm.ClassLabels = classes;
p = zeros(1,10) ;
r = zeros(1,10) ;
for i=1:10
    p(i) = precision(i, C); 
    r(i) = recall(i,C); 
end 
%% visualize filters 
net = load('cifar10_mod_last.mat'); 
filters = net.net.layers{1, 2}.params.weights; 
figure(5) 
t = tiledlayout(4,4); 
for i = 1:16 
    nexttile
    im = filters(:,:,:,i); 
    imshow(im*10, 'InitialMagnification','fit')
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
