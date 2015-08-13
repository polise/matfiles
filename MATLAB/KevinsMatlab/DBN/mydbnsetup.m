function dbnParams = mydbnsetup(type)

rbmParams.epochs = 10;
rbmParams.batchsize = 100;
rbmParams.lrW = 0.1;
rbmParams.lrVb = 0.1;
rbmParams.lrHb = 0.1;

rbmParams.lrW_linear = 0.001;
rbmParams.lrVb_linear = 0.001;
rbmParams.lrHb_linear = 0.001;

rbmParams.weightPenaltyL2  = 0.0002;  

rbmParams.initMomentum = 0.5;
rbmParams.finalMomentum = 0.9;

rbmParams.momentumEpochThres = 5;

rbmParams.type = 1; %1 is what Hinton suggests, 2 is consistent with theory
%check myRBMtrain

dbnParams.rbmParams = rbmParams;

% Should match #emotions (1 = happy, 2 = sad, ... 6 = angry)
dbnParams.outputSize = 10;
% Should match #pixels input
dbnParams.inputSize = 10;

dbnParams.type = type; 
% 1 = AE, 2 = classifier, 3 = FF NN where the output layer produces features
dbnParams.inputActivationFunction = 'sigm';

if type == 1 % AE
   dbnParams.hiddenActivationFunctions = {'sigm','sigm','sigm','linear'}; 
   dbnParams.hiddenLayers = [1000 500 250 50]; % hidden layers sizes, does not include input or output layers
elseif type == 2 % Classification
    dbnParams.hiddenActivationFunctions = {'sigm','sigm','sigm','sigm'};
    dbnParams.hiddenLayers = [500 500 500 200 ];
elseif type == 3 % Feature extraction
    dbnParams.hiddenActivationFunctions = {'sigm','sigm','sigm','sigm'};
    dbnParams.hiddenLayers = [500 500 500 200 ];
end
