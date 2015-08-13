function [vW, vBiases] = initialisePreviousUpdateWeights(w, biases)

noLayers = length(w);

for i = 1:noLayers
   
    [r, c] = size(w{i});
    [rb, cb] = size(biases{i});
    
    vW{i} = zeros(r, c);
    vBiases{i} = zeros(rb, cb);
    
end