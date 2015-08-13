function [e, L] = computeLoss(targetOut, netOut, activFunction)

     
 N = size(targetOut,1);

 e = netOut - targetOut;
 
switch activFunction
     
    case 'softmax'   
        
        L = -sum(sum(targetOut .* log(netOut))) / N; % cross-entropy loss function
        
    otherwise
        
        L = 0.5 * sum(sum(e .^ 2)) / N; %MSE loss function
end






