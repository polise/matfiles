function [weightsAE, biasesAE, newActivationFunctions newLayers] = dbnUnfoldToAE(dbnParams, dbn, outputSize)

noLayers = length(dbnParams.hiddenLayers); 

% create encoding layers
 
weightsAE = dbn.W;
biasesAE = dbn.hidbiases;
inputSize = size(dbn.W{1},1);

if inputSize ~= outputSize
    error('Input size is different that output size. In an AE they should have the same size')
end
 
ind = 1;
% create decoding layers, where weights/biases are mirrored from the
% encoding layer
for i = noLayers + 1:2*noLayers
    
    index = i - ind;
    weightsAE{i} = dbn.W{index}';
    biasesAE{i} = dbn.visbiases{index};
    
    ind = ind + 2;
    
end

% create new activation functions (activFcn from encoding layer + same
% activFcn flipped for decoding layer + outputActivFcn same as inputActivFcn
newActivationFunctions = [dbnParams.hiddenActivationFunctions fliplr(dbnParams.hiddenActivationFunctions(1:end-1)) dbnParams.inputActivationFunction];
% same as above for hidden layers
newLayers = [dbnParams.hiddenLayers fliplr(dbnParams.hiddenLayers(1:end-1)) outputSize];



