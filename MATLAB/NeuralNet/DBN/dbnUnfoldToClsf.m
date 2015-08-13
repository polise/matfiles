function [weightsClsf, biasesClsf, newActivationFunctions newLayers] = dbnUnfoldToClsf(dbnParams,dbn,outputSize)



% if classification then last layer is softmax
newActivationFunctions = [dbnParams.hiddenActivationFunctions 'softmax'];

newLayers = [dbnParams.hiddenLayers outputSize];
     
% initialise weights/biases of new layer
% hinton in his code initialises the last layer like this
% http://www.cs.toronto.edu/~hinton/MatlabForSciencePaper.html
lastLayerW = 0.1*randn(newLayers(end - 1), outputSize);
lastLayerBiases = 0.1*randn(1, outputSize);

weightsClsf = [dbn.W lastLayerW];
biasesClsf = [dbn.hidbiases lastLayerBiases];


