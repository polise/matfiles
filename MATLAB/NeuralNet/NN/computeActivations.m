function activations = computeActivations(layerType, data)


outputSize = size(data, 2);

 if strcmpi(layerType,'sigm')
  
      activations = 1./(1 + exp(-data));  
      
 elseif strcmpi(layerType,'tanh')
  
     activations = 2 * (1./(1 + exp(-2*data))) - 1; % tanh(z) = 2*sigm(2z) - 1
     
  elseif strcmpi(layerType,'linear')
      
      activations =  data; 
      
  elseif strcmpi(layerType,'ReLu')
      
      activations =  max(0,data); 
      
 elseif strcmpi(layerType, 'leakyReLu')
     
     activations = max(0.01 * data, data);
     
 elseif strcmpi(layerType, 'softplus')
     
     activations = log(1 + exp(data));
     
 elseif strcmpi(layerType, 'softsign')
     
     activations = data ./ (1 + abs(data));
      
 elseif strcmpi(layerType, 'softmax')
     
      activNominator = exp(data);
      sumActiv = sum(activNominator, 2);
      activations = activNominator ./ repmat(sumActiv, 1, outputSize);
     
  end