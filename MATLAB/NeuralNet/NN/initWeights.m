function [W, biases] = initWeights(inputSize, weightInitParams, layers)


type = weightInitParams.type;            
sigma = weightInitParams.sigma;            
biasType = weightInitParams.biasType;   
biasConstant = weightInitParams.biasConstant;

layerSize1 = inputSize;
noLayers = length(layers);    

    for i = 1 : noLayers
        
        layerSize2 = layers(i);
        
        % weights 
        if type == 1
          W{i} = sigma * randn(layerSize1, layerSize2);
        elseif type == 2
%         %this is good only for sigmoid neurons (logistic not tanh)
          W{i} = (rand(layerSize1, layerSize2) - 0.5) * 2 * 4 * sqrt(6 / (layerSize1 + layerSize2)); %initialise uniform from [-r,r] where r = 4*sqrt(6 /(fanIn+fanOut) )
        end
        
        if biasType == 1
            biases{i} =  sigma * randn(1, layerSize2);
           
        elseif biasType == 2
            biases{i} = biasConstant * ones(1, layerSize2); 
        end


        
        layerSize1 = layerSize2;
    end
    

    
