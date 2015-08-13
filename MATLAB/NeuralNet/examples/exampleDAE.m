
type = 2; % 1 is AE, 2 is classifier, 

daeParams = mydaesetup(type);
daeParams.inputActivationFunction = 'sigm'; %sigm for binary inputs, linear for continuous input
daeParams.outputSize = 10;

% parameters used for visualisation of first layer weights
params.noSubplots = daeParams.hiddenLayers(1) / 50;
params.noSamples2Display = 20;
params.col = 28;
params.row = 28;

load mnist_uint8;
train_x = double(train_x);
test_x  = double(test_x);
train_y = double(train_y);
test_y  = double(test_y);


train_x = normaliseData(daeParams.inputActivationFunction, train_x);
test_x = normaliseData(daeParams.inputActivationFunction, test_x);

inputDim = size(train_x,2);
daeParams.inputSize = inputDim;

if type == 1 %i.e. if AE
    daeParams.outputSize = daeParams.inputDim;
end


% [frameData,PS] = mapstd(frameData',ymean,ystd);
% frameData = frameData';

% each image is zero normalised and divided by the std over all pixers over
% all images
% s = std(frameData(:));
% 
% [frameDataTemp,PS] = mapstd(frameData,ymean,ystd);
% PS.xstd = repmat(s,size(frameData, 1),1);
% [frameData,PS] = mapstd('apply',frameData,PS);

daeParams.nnParams.inputZeroMaskedFraction = 0.5;
daeParams.nnParams.epochs = 20;

[dae, errorPerBatch errorPerSample] = myDAEtrain(train_x, daeParams);

myVisualiseRBMs(dae.W{1},params.col,params.row,params.noSubplots);
%stopped here------------------------

nn = mydbnunfoldtonn(daeParams, dae);

nn.epochs = 10;

% % in case weight initialisation is needed, networks are pre-trained so
% it's not used here
% [W, biases] = initWeights(inputSize, weightInitParams, layers);

%}

% update some NN params to default values used in the literature
nn = useSomeDefaultNNparams(nn);

%if no validation
[nn, Lbatch, L, L_val]  = mynntrain(nn, train_x, train_y);
%if validation exists
% [nn, Lbatch, L, L_val]  = mynntrain(nn, train_x, train_y, val_x, val_y);

nn.testing = 1;
output = mynnff(nn, test_x); 

