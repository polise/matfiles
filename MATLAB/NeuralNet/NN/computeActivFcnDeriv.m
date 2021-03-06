function d_act = computeActivFcnDeriv(a, activationFunction)


% Derivative of the activation function
           
switch activationFunction 
          
    case 'sigm'
    
        d_act = a .* (1- a);
        
    case 'tanh'
    
        d_act = 1 - a.^2;
        
    case 'linear'
        
        d_act = 1;
        
    case 'ReLu'
        
        
        d_act = zeros(size(a));
        d_act(a > 0) = 1;
        
    case 'leakyReLu'
        
        d_act = 0.01*ones(size(a));
        d_act(a > 0) = 1;
        
    case 'softplus'
        
        x = log(exp(a) - 1);
        
        d_act = 1 ./ (1 + exp(-x));
        
    case 'softsign'
        
        x = zeros(size(a));
        
        indPos = find(a>0);
        indNeg = find(a<0);
        
        x(indPos) = a(indPos) ./ (1 - a(indPos));
        x(indNeg) = a(indNeg) ./ (1 + a(indNeg));
        
        d_act = 1 ./ ((1 + abs(x)) .^ 2);
        
      
end
        
