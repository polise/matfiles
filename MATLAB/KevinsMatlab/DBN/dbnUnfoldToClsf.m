function [weightsClsf, biasesClsf, newActivationFunctions newHiddenLayers] = dbnUnfoldToClsf(dbnParams, dbn)

% if classification then last layer is softmax
newActivationFunctions = [dbnParams.hiddenActivationFunctions 'softmax'];

newHiddenLayers = [dbnParams.hiddenLayers dbnParams.outputSize];
     
% initialise weights/biases of new layer
% hinton in his code initialises the last layer like this
lastLayerW = 0.1*randn(newHiddenLayers(end - 1), dbnParams.outputSize);
lastLayerBiases = 0.1*randn(1, dbnParams.outputSize);

weightsClsf = [dbn.W lastLayerW];
biasesClsf = [dbn.hidbiases lastLayerBiases];


