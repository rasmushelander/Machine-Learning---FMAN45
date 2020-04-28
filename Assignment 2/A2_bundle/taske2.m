%% Task E2
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