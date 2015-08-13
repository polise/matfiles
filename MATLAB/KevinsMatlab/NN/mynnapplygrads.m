function [nn, vW, vBiases] = mynnapplygrads(nn, dW, dBiases, vW, vBiases)
%NNAPPLYGRADS updates weights and biases with calculated gradients
% nn = nnapplygrads(nn) returns an neural network structure with updated
% weights and biases
    
    for i = 1 : nn.n
        
        if(nn.weightPenaltyL2 > 0)
            dW{i} = dW{i} + nn.weightPenaltyL2 * nn.W{i};
        end
        
        if(nn.weightPenaltyL1 > 0)
            dW{i} = dW{i} + nn.weightPenaltyL1 * sign(nn.W{i});
        end
        
        dW{i} = - nn.learningRateParams.lr * dW{i};
        dBiases{i} = - nn.learningRateParams.lr * dBiases{i};
        
        if(nn.momParams.momentum > 0)
            dW{i} = nn.momParams.momentum * vW{i} + dW{i};
            dBiases{i} = nn.momParams.momentum * vBiases{i} + dBiases{i};
            
            vW{i} = dW{i};
            vBiases{i} = dBiases{i};
        end
            
         tempW = nn.W{i} + dW{i};
         
         if nn.maxNormConstraint > 0
             tempW = applyMaxNormRegularisation(tempW, nn.maxNormConstraint);
         end
         
        nn.W{i} = tempW;
        nn.biases{i} = nn.biases{i} + dBiases{i};
    end
end
