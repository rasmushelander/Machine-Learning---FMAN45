function dldx = relu_backward(x, dldy)
    dldx = (x > 0).*dldy;
end
