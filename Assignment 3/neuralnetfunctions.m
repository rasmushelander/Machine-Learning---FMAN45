%% 
function a = sigmoid(X)
    a = exp(X)/(1+exp(X));
end 

function y_hat = forward_pass(W, X, activation)
    % Inputs: 
    % X: (DxN) input matrix where D is the dimensionality and N is the
    % number of samples
    % W: (input_size[i] x output_size[i] x nlayers) 3d weight tensor where
    % input_size[i] is the number of input nodes for the i:th layer. Note
    % that input_size(1) = D
    % Outputs:
    % y_hat: (d x N) output matrix where 
    % Assumptions: 
    % All layers have the same activation function.
    [~, ~, nlayers] = size(W);
    [D, N] = size(X); 
    for i = 1:nlayers
        X_temp = (X'*W(:,:,i))'; 
        a = activation(X_temp); 
    end 
    y_hat = a; 
end 

function loss = MSE_loss(Y_true, Y_hat, lambda, W)
    [N = size(
end
