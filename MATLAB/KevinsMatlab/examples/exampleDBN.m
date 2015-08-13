% 1 is AE, 2 is classifier, 3 is used for feature extraction from top layer
type = 1; 

% Uses Boltzmann equations to initialize the network / pre-train
dbnParams = mydbnsetup(type);
dbnParams.inputActivationFunction = 'sigm'; 
% sigm for binary inputs (e.g. B&W), linear for continuous input (e.g. grayscale)
dbnParams.outputSize = 10;

% parameters used for visualisation of first layer weights
params.noSubplots = dbnParams.hiddenLayers(1) / 50;
params.noSamples2Display = 20;
params.col = 28;
params.row = 28;

% f = load('C:\OuluMouthROIs\AllFramesTogether.mat');
% dataMatrix = f.data;
% dataMatrix = normaliseData(dbnParams.inputActivationFunction, dataMatrix);

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
dbnParams.rbmParams.epochs = 2; %20

% Initializing the DBN
[dbn, errorPerBatch errorPerSample] = myDBNtrain(train_x, dbnParams);

% Produces visualization for the RBN
%myVisualiseRBMs(dbn.W{1},params.col,params.row,params.noSubplots);

% Convert RBN to neural network (unfolds DBN to NN)
nn = mydbnunfoldtonn(dbnParams, dbn);

% Set number of training epochs for the NN
nn.epochs = 2; %20

% % in case weight initialisation is needed, networks are pre-trained so
% it's not used here
% [W, biases] = initWeights(inputSize, weightInitParams, layers);
nn = useSomeDefaultNNparams(nn);

%if no validation
[nn, Lbatch, L, L_val]  = mynntrain(nn, train_x, train_x); %for AE, train_x Train_x no y
%if validation exists
% [nn, Lbatch, L, L_val]  = mynntrain(nn, train_x, train_y, val_x, val_y);

nn.testing = 1;
output = mynnff(nn, test_x);

