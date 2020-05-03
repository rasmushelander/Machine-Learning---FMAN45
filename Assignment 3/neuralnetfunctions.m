%% test ce_loss fct
Y_true = [0, 0; 0, 0; 0, 0; 1,1] 
Y_hat = [0.25,0.06; 0.25, 0.04; 0.25, 0.1; 0.25, 0.8]
dlX = dlarray( Y_hat, 'CB')
dlx = softmax(dlX)
Y_hat = softmax(Y_hat)
crossentropy(dlx, Y_true ) 
a =CE_loss(Y_true, Y_hat)
b = sum(a, 'all') 
%% test w_init
X = rand(5,4); 
nnodes = randi([1,6], 1, 4); 
W = initialize_weights(X, nnodes);
%% test_sigmoid 
sigmoid(1)
sigmoid(2) 
sigmoid(3) 
sigmoid(4) 
sigmoid([1,2;3,4])
%% test forward pass 
X = rand(5,4);
sigmoid(X) 
nnodes = randi([1,6], 1, 10);
W = initialize_weights(X, nnodes);
forward_pass(W, X, @sigmoid)
%% test sigmoid convergence
x = rand(1,1) 
res = [];
for i=1:199
    x = sigmoid(x); 
    res(i) = x;
end
x
plot(res)
sigmoid(x) 
%%
for i = 7:-1:1 
    i
end
%% Functions 
function a = sigmoid(X)
% self explanatory
    a = exp(X)./(1+exp(X));
end 

function y_hat = forward_pass(W, X, activation)
    % Inputs: 
    % X: (DxN) input matrix where D is the dimensionality and N is the
    % number of samples
    % W: cell array of size nlayers, with entry i being the (in x out) weight matrix
    % of the i:th layer with in being the number of input nodes and out
    % being the number of output nodes
    % Outputs:
    % y_hat: (d x N) output matrix where 
    % Assumptions: 
    % All layers have the same activation function.
    nlayers = size(W, 2)
    [D, N] = size(X); 
    a = X
    for i = 1:nlayers
        X_temp = W{i}'*a; % = W{i}'*a
        a = activation(X_temp); 
    end 
    y_hat = a; 
end 

function loss = multilabel_CE_loss(Y_true, Y_hat, lambda, W)
    [~, N] = size(Y_true);
    loss = -1/N*(Y_true.*log(Y_hat) + (ones(size(Y_true))-Y_true).*(log(ones(size(Y_hat))-Y_hat)));
    loss = sum(loss, 'all');
    if nargin == 4
        loss = loss + lambda/(2*N)*sum(W.^2, 'all'); 
    end
end

function loss = CE_loss(Y_true, Y_hat, lambda, W)
    % Inputs: 
    % Y_true: (C x N) ground truth matrix (C number of classes, N number of
    % samples)
    % Y_hat: (C x N) prediction matrix
    % lambda: l2 regularization strength
    % W: weights
    [~, N] = size(Y_true);
    loss = -1/N*(Y_true.*log(Y_hat));
    loss = sum(loss, 'all');
    if nargin == 4
        loss = loss + lambda/(2*N)*sum(W.^2, 'all'); 
    end
end

function W = initialize_weights(X, nnodes)
    % Inputs: 
    % X: (D x N) input matrix (D is dimensionality of input)
    % nnodes: row vector with number of output nodes of each layer) 
    input_nodes = size(X,1); 
    nnodes = [input_nodes, nnodes];
    nlayers = size(nnodes, 2) - 1
    W = cell(1,nlayers);
    for i = 1:nlayers;
        W{i}  = normrnd(0,1, nnodes(i), nnodes(i+1)); 
    end
end 

function grad = backprop(X, X_temp, W, a)
    % first calculate the gradient of the loss with respect to the last
    % activation. then calculate gradient of last activation with respect
    % to last X_temp 
    nlayers = size(W,2);
    grad = cell(1, nlayers); 
    for i = nlayers:-1:1
        A = A.*a(i).*(1-a(i));
        grad{n-i+1} = A*a(i-1)'; % eller a'*A?
        A = W{i}'*A; 
    end
end
