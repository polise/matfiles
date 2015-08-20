type = 2; % 1 is AE, 2 is classifier, 

hiddenActivationFunctions = {'sigm','sigm','sigm','sigm'};
hiddenLayers = [500 500 500 200 ]; % hidden layers sizes, does not include input or output layers
%if type = 1, i.e., AE then the last layer should be linear and usually a
% series of decreasing layers are used
% hiddenActivationFunctions = {'sigm','sigm','sigm','linear'}; 
% hiddenLayers = [1000 500 250 50]; 

% parameters used for visualisation of first layer weights
visParams.noExamplesPerSubplot = 50;
visParams.noSubplots = floor(hiddenLayers(1) / visParams.noExamplesPerSubplot);
visParams.col = 28;
visParams.row = 28;

load hist_av_data;

inputSize = size(train_x,2);
outputSize = size(train_y,2); % in case of classification it should be equal to the number of classes


dbnParams = mydbnsetup(type, hiddenActivationFunctions, hiddenLayers);
dbnParams.inputActivationFunction = 'linear'; %sigm for binary inputs, linear for continuous input
dbnParams.rbmParams.epochs = 10;
dbnParams.rbmParams.lrW = 0.05; %uncomment and run

% normalise data
train_x = normaliseData(dbnParams.inputActivationFunction, train_x);
test_x = normaliseData(dbnParams.inputActivationFunction, test_x);
[dbn, errorPerBatch errorPerSample] = myDBNtrain(train_x, dbnParams);


nn = mydbnunfoldtonn(dbnParams, dbn, outputSize);
nn.epochs = 10;

% % in case weight initialisation is needed, networks are pre-trained so
% it's not used here
% [W, biases] = initWeights(inputSize, weightInitParams, layers);

nn = useSomeDefaultNNparams(nn);
nn.batchsize = 416;

nn.weightConstraints.weightPenaltyL2  = 0; % L2 regularization coefficient
nn.weightConstraints.weightPenaltyL1  = 0; % L1 regularisation coefficient
nn.weightConstraints.maxNormConstraint= 3; % ???

nn.learningRateParams.lr             =  0.025; % 0.1; %  learning rate Note: typically needs to be lower when using 'sigm' activation function and non-normalized inputs.
nn.learningRateParams.scalingFactor  = 0.999; %  Scaling factor for the learning rate (each epoch)
nn.learningRateParams.lrEpochThres   = 100;
nn.learningRateParams.schedulingType = 1; % 1 = lr*T / max(currentEpoch, T), 2 = scaling, 3 = lr / (1 + currentEpoch/T)
nn.learningRateParams.initialLR      = 0.1; 

nn.dropoutParams.dropoutType         = 1; % 0 = no dropout, 1 = bernoulli droput, 2 = gaussian dropout 

%if no validation
[nn, Lbatch, L, L_val]  = mynntrain(nn, train_x, train_y, val_x, val_y);


nn.testing = 1; % make
output = mynnff(nn, test_x); 

