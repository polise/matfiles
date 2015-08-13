function [output, layerActivations] = mynnff(nn, x)


weights = nn.W;
biases = nn.biases;
activation_functions = nn.activation_functions;
layerActivations = [];

noLayers = nn.noLayers;
N = size(x,1);

x = [x ones(N,1)];

for layerId = 1:noLayers %changed to two

    w = [weights{layerId}; biases{layerId}]; %

    inp2Hid = x*w; %changed from x*w 
      
    a = computeActivations(activation_functions{layerId}, inp2Hid);

    % if dropout is used AND for hidden layers only AND NN is not used for
    % testing, i.e.m we are in the training phase
    if  nn.dropoutParams.dropoutType ~= 0 && layerId ~= noLayers && nn.testing == 0
            
        %dropout
        a = a .* nn.dropoutParams.dropoutMasks{layerId};
            
    end
    
    % save activations only when NN is in training phase
    if nn.testing == 0
        layerActivations{layerId} = a;
            
    end
    
    a = [a  ones(N,1)];
    x = a;   
   
end

output = a;
output(:,end) = []; % remove last column, it's only ones
  
   
   

   
 
   