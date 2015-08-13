function p = initialiseSparsity(layers)

noLayers = length(layers);

for i = 1 : noLayers - 1 % sparsity is not needed for the output layer
       
    layerSize = layers(i);
             
    % average activations (for use with sparsity)
   
    p{i}     = zeros(1, layerSize);   
            
end


