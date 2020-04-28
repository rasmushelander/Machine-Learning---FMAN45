function [y,C] = K_means_clustering(X,K)

% Calculating cluster centroids and cluster assignments for:
% Input:    X   DxN matrix of input data
%           K   Number of clusters
%
% Output:   y   Nx1 vector of cluster assignments
%           C   DxK matrix of cluster centroids

[D,N] = size(X);

intermax = 80;
conv_tol = 1e-6;
% Initialize
C = repmat(mean(X,2),1,K) + repmat(std(X,[],2),1,K).*randn(D,K);
y = zeros(N,1);
Cold = C;

for kiter = 1:intermax

    % Step 1: Assign to clusters
    y = step_assign_cluster(X,C);
    
    % Step 2: Assign new clusters
    C = step_compute_mean(X, y, K, C);
        
    if fcdist(C,Cold) < conv_tol
        disp('converged') 
        disp(kiter)
        return
    end
    Cold = C;
    if kiter == intermax 
        disp('Did not converge') 
    end
end

end

function d = fxdist(X,C)
    K = size(C);
    K = K(2); 
    [~, N] = size(X); 
    %xmat = x*ones(1, length(C)); 
    d = zeros(K,N); 
    for i = 1:K
        d(i,:) =  vecnorm(C(:,i)-X);
    end
    %d = vecnorm(xmat - C);
    %Xhat = repmat(X, K ,1);
    %Xhat = reshape(Xhat, D, K, N); %3d array 
    %d = vecnorm(Xhat - C); % l2 norm 
    %d = reshape(d, K, N); % KxN matrix with distances to each cluster for every point  
end

function d = fcdist(C1,C2)
    d = max(vecnorm(C1-C2)); %l2 norm, only stores the longest distance that a centroid moved
end

function c = step_assign_cluster(X, C)
    [~, c] = min(fxdist(X, C)); % 1xN array with closest cluster for each point (chooses lower index if equally close to one or more clusters) 
end

function C = step_compute_mean(X, c, K, oldC)  
    dummies = (c == (1:K)')'; % dummy variables for assigned clusters
    C = X*dummies./sum(dummies);  
    nan_idx = isnan(C); 
    C(nan_idx) = oldC(nan_idx);
end
