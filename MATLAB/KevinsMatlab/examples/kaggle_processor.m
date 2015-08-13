%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% kaggle_processor.m 
% Loads emotion database into a neural network
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Select type of RBM (1 = AE, 2 = Classifier, 3 = Feature extractor)
type = 2;

% Uses Boltzmann equations to initialize the network / pre-train
dbnParams = mydbnsetup(type);

% Select activation function for the deep-belief network
% sigm for binary inputs (e.g. B&W) 
% linear for continuous input (e.g. grayscale)
dbnParams.inputActivationFunction = 'sigm';
dbnParams.outputSize = 10;

% parameters used for visualisation of first layer weights
params.noSubplots = dbnParams.hiddenLayers(1) / 50;
params.noSamples2Display = 20;
params.col = 28;
params.row = 28;

% Load dataset into Matlab
load mnist_uint8;

% Convert all data into doubles
train_x = double(train_x);
test_x  = double(test_x);
train_y = double(train_y);
test_y  = double(test_y);

% Normalize training and test inputs
train_x = normaliseData(dbnParams.inputActivationFunction, train_x);
test_x = normaliseData(dbnParams.inputActivationFunction, test_x);

% Used for autoencoder
inputDim = size(train_x,2);
dbnParams.inputSize = inputDim;
if dbnParams.type == 1 %i.e. if AE
    dbnParams.outputSize = dbnParams.inputSize;
end

% Number of training epochs for RBM (part of initialization)
dbnParams.rbmParams.epochs = 20;

% Initializing the DBN
[dbn, errorPerBatch errorPerSample] = myDBNtrain(train_x, dbnParams);

% Produces visualization for the RBN
myVisualiseRBMs(dbn.W{1},params.col,params.row,params.noSubplots);

% Convert RBN to neural network (unfolds DBN to NN)
nn = mydbnunfoldtonn(dbnParams, dbn);

% Set number of training epochs for the NN
nn.epochs = 20;

% In case weight initialization is needed but networks are pre-trained
% [W, biases] = initWeights(inputSize, weightInitParams, layers);
nn = useSomeDefaultNNparams(nn);

% If no validation (?)
[nn, Lbatch, L, L_val]  = mynntrain(nn, train_x, train_y);

% Sets testing parameter to 1 (?)
nn.testing = 1;
output = mynnff(nn, test_x);

