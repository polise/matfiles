function [dW,dBiases] = mynnbp(nn, x, e, layerActivations)
%NNBP performs backpropagation
    
    
n = nn.noLayers;
    
outputActivFcn = nn.activation_functions{end};
    
if strcmpi(outputActivFcn, 'softmax')
   
    d = e;
else
    
    d_act = computeActivFcnDeriv(layerActivations{end}, outputActivFcn);
    d = e .* d_act;
    
end

N = size(x, 1);

for i = n : -1 : 2
    
    a = layerActivations{i-1};
    aBias = ones(N, 1);

    dW{i} = (a' * d) / N; % divide by batchsize
    dBiases{i} = (aBias' * d) / N;
        
    
    if isnan(dW{i}(1))
    
        keyboard
       
    end
    
    w = nn.W{i};
    d_act = computeActivFcnDeriv(a, nn.activation_functions{i-1});
        
    % Backpropagate first derivatives        
    d_prevLayer = (d * w')  .* d_act; 

    % for bernoulli dropout "kill" the error in the neurons that have
    % been dropped
    if nn.dropoutParams.dropoutType == 1 
        d_prevLayer = d_prevLayer .* nn.dropoutParams.dropoutMasks{i - 1};
    end
    
    d = d_prevLayer;
        
end

aBias = ones(N, 1);
dW{1} = (x' * d) / N;
dBiases{1} = (aBias' * d) / N;
       
    
