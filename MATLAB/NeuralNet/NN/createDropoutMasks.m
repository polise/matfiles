function dropoutMasks = createDropoutMasks(layersSize, batchSize, dropoutPresentProb, dropoutType)

noLayers = length(layersSize);

for i = 1:noLayers
    
    maskSize = [batchSize layersSize(i)];
    
    if dropoutType == 1 % Bernoulli
      
        dropoutMasks{i} = rand(maskSize) > (1 - dropoutPresentProb);
        
    elseif dropoutType == 2 % Gaussian
        
        sigma = sqrt((1-dropoutPresentProb) / dropoutPresentProb); % check dropout paper
        dropoutMasks{i} = 1 + sigma .* randn(maskSize);
    end
    
    
    
end