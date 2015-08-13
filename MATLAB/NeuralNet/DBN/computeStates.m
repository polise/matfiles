function states = computeStates(layerType, probs, data)

[numExamples,numHid] = size(probs);

if strcmpi(layerType,'sigm')
  
      states = probs > rand(numExamples,numHid);
  
  elseif strcmpi(layerType,'linear')
      
      states = probs + randn(numExamples,numHid); 
      
  elseif strcmpi(layerType,'ReLu')
      

      sigma = 1./(1 + exp(-data));
      noise = sigma .* randn(numExamples, numHid);
      states =  max(0,data + noise); 
      
end


