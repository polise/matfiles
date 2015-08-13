function p = computeActivationsForSparsity(p, a, layersSize)

noHiddenLayers = length(layersSize) - 1;

for i = 1:noHiddenLayers
            
     
    p{i} = 0.99 * p{i} + 0.01 * mean(a{i}, 1);
 
end
         