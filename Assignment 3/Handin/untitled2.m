%%
x = [1,2;2,4]; 
sz = size(x);
p_i = 1; 
p_j = 1;
sz(1) = sz(1) + 2*p_i;
sz(2) = sz(2) + 2*p_j;

x_new = zeros(sz);
x_new(1+p_i:sz(1)-p_i, 1+p_j:sz(2)-p_j,:,:) = x