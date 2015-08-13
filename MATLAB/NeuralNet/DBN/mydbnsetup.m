function dbnParams = mydbnsetup(type,hiddenActivationFunctions, hiddenLayers, inputSize, outputSize)

rbmParams.epochs = 10;
rbmParams.batchsize = 100;
rbmParams.lrW = 0.1; % learningRate for weights
rbmParams.lrVb = 0.1; % learningRate for visible biases
rbmParams.lrHb = 0.1; % learningRate for hidden biases

rbmParams.lrW_linear = 0.001; % learning for weights when one layer is linear
rbmParams.lrVb_linear = 0.001; % learning for visible biases when one layer is linear
rbmParams.lrHb_linear = 0.001; % learning for hidden biases when one layer is linear

rbmParams.weightPenaltyL2  = 0.0002;% L2 regularisation  

rbmParams.initMomentum = 0.5; % initial momentum
rbmParams.finalMomentum = 0.9; % final momentum

rbmParams.momentumEpochThres = 5; %threshold after which the final momentum is used

rbmParams.type = 1; %1 is what Hinton suggests in "A practical guide to training RBMs", 2 is consistent with theory
%check myRBMtrain

dbnParams.rbmParams = rbmParams;

dbnParams.type = type; %1 is AE, 2 is classifier, 3 is simply a FF NN where the output
%layer produces features
dbnParams.inputActivationFunction = 'sigm';

dbnParams.hiddenActivationFunctions = hiddenActivationFunctions;
dbnParams.hiddenLayers = hiddenLayers;







