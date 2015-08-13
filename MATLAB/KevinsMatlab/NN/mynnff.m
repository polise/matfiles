function [output, layerActivations] = mynnff(nn, x)


weights = nn.W;
biases = nn.biases;
activation_functions = nn.activation_functions;
layerActivations = [];

noLayers = nn.n;
N = size(x,1);

% if nn.dropoutMaskInput > 0 && nn.testing == 0
%     x = x .* nn.dropoutMaskInput;
% end

x = [x ones(N,1)];

   for layerId = 1:noLayers
      w = [weights{layerId}; biases{layerId}];
      inp2Hid = x * w; 
     
      a = computeActivations(activation_functions{layerId}, inp2Hid);

      
      if  nn.dropoutType ~= 0 && layerId ~= noLayers && nn.testing == 0
            %dropout
                         
            a = a .* nn.dropoutMasks{layerId};
          
      end
      
      if nn.testing == 0
          
          layerActivations{layerId} = a;
          
      end
      
      a = [a  ones(N,1)];
      x = a;
      
      
   end
   
  
   output = a;
   output(:,end) = []; % remove last column, it's only ones
   
   

   
 
   