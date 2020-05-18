function dldx = softmaxloss_backward(x, labels)
    % Inputs:
    %    x - Features. See the reshape command below. It is reshaped as for
    %        the fully connected layer.
    %    labels - It is a vector with the correct labels. For
    %        instance if we have a batch of two where the first example is
    %        class 4 and the second example is class 7, labels is [4 7].
    %
    % Outputs:
    %    dldx - Partial derivative of L with respect to x. Remember that in
    %           the forward pass you average over the batch elements.
    labels = vec(labels);
    sz = size(x);
    batch = sz(end);
    features = prod(sz(1:end-1));

    % suitable for matrix multiplication
    x = reshape(x, [features, batch]);
    % for numerical stability. Convince yourself that the result is the same.
    x = bsxfun(@minus, x, min(x, [], 1)); 
    
    labels = double(labels); % because ind2vec does not handle uint8
    % converting labels to double is probably not a problem since a 1 GB
    % double vector (which does not put too much of a constraint om the memory)
    %has approx. 125 million elements which is far larger
    % than the size of most datasets
    labels = full(ind2vec(labels', features)); % dummy variables  where the
    % i:th column represents the i:th training example. 
    % for example: labels = [1,3] -> [1, 0;
    %                                 0, 0;
    %                                 0, 1]
          
    dldx = softmax(x)-labels; 
    dldx = dldx/batch; 
end
