function [dW,dBiases] = mynnbp(nn, x, e)
%NNBP performs backpropagation
    
    n = nn.n;
    sparsityError = 0;
    
    outputActivFcn = nn.activation_functions{end};
    
    if strcmpi(outputActivFcn, 'softmax')
    
        d = e;
    else
        d_act = computeActivFcnDeriv(nn.a{end}, outputActivFcn);
    
        d = e .* d_act;
    end
    
    
    N = size(x, 1);
    
    for i = n : -1 : 2

        a = nn.a{i-1};
                
        aBias = ones(N, 1);

        
        dW{i} = (a' * d) / N; % divide by batchsize
        dBiases{i} = (aBias' * d) / N;
        
        if isnan(dW{i}(1))
            keyboard
        end

        w = nn.W{i};
        
        d_act = computeActivFcnDeriv(a, nn.activation_functions{i-1});
        
            if(nn.nonSparsityPenalty>0)
                 pi = repmat(nn.p{i - 1}, size(a, 1), 1);
                sparsityError = [zeros(size(a,1),1) nn.nonSparsityPenalty * (-nn.sparsityTarget ./ pi + (1 - nn.sparsityTarget) ./ (1 - pi))];
            end
        
        % Backpropagate first derivatives        
            d_prevLayer = (d * w' + sparsityError) .* d_act; % Bishop (5.56)

        % for bernoulli dropout "kill" the error in the neurons that have
        % been dropped
        if nn.dropoutType == 1 
            d_prevLayer = d_prevLayer .* nn.dropoutMasks{i - 1};
        end
        
        d = d_prevLayer;
        

    end
    
    aBias = ones(N, 1);
    
    dW{1} = (x' * d) / N;
    dBiases{1} = (aBias' * d) / N;
       
    
end
