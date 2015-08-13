function [e, L] = computeLoss(targetOut, netOut, activFunction)


       
 N = size(targetOut,1);

 e = netOut - targetOut;
%  e = e / N;
 
switch activFunction
    case {'sigm','tanh', 'linear','ReLu'}  
        L = 0.5 * sum(sum(e .^ 2)) / N; 
    case 'softmax'   
        L = -sum(sum(targetOut .* log(netOut))) / N;
end






