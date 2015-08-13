function mynnchecknumgrad(nn, x, y, dW)
    epsilon = 1e-6;
    er = 1e-5;
    n = nn.n;
    for l = 1 : n 
        l
        for i = 1 : size(nn.W{l}, 1)
            for j = 1 : size(nn.W{l}, 2)
                nn_m = nn; nn_p = nn;
                nn_m.W{l}(i, j) = nn.W{l}(i, j) - epsilon;
                nn_p.W{l}(i, j) = nn.W{l}(i, j) + epsilon;
				rand('state',0)
                output = mynnff(nn_m, x);
                [e, L1] = computeLoss(y, output, nn.activation_functions{end});
              
                rand('state',0)
                output = mynnff(nn_p, x);
                [e, L2] = computeLoss(y, output, nn.activation_functions{end});
                
                
                dWapprox = (L1 - L2) / (2 * epsilon);
                e = abs(dWapprox - dW{l}(i, j));
                
                if e > er
                    keyboard
                end
%                 assert(e < er, 'numerical gradient checking failed');
            end
        end
    end
end
