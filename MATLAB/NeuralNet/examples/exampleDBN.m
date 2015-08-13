
type = 1; % 1 is AE, 2 is classifier, 

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

load av_data;

% val_x = double(validate_x_AV);
% val_y = double(validate_y_AV);

%if no validation exists then
% val_x = [];
% val_y = [];

% train_x = double(train_x_AV);
% train_y = double(train_y_AV);
% 
% test_x  = double(test_x_AV);
% test_y  = double(test_y_AV);

inputSize = size(train_x,2);

if type == 1 % AE
   outputSize  = inputSize; % in case of AE it should be equal to the number of inputs

elseif type == 2 % classifier
    outputSize = size(train_y,2); % in case of classification it should be equal to the number of classes

end

dbnParams = mydbnsetup(type, hiddenActivationFunctions, hiddenLayers);
dbnParams.inputActivationFunction = 'linear'; %sigm for binary inputs, linear for continuous input
dbnParams.rbmParams.epochs = 1;

% normalise data
train_x = normaliseData(dbnParams.inputActivationFunction, train_x);
test_x = normaliseData(dbnParams.inputActivationFunction, test_x);

[dbn, errorPerBatch errorPerSample] = myDBNtrain(train_x, dbnParams);

%myVisualiseRBMs(dbn.W{1},visParams.col,visParams.row,visParams.noSubplots);

nn = mydbnunfoldtonn(dbnParams, dbn, outputSize);

nn.epochs = 1;

% % in case weight initialisation is needed, networks are pre-trained so
% it's not used here
% [W, biases] = initWeights(inputSize, weightInitParams, layers);

nn = useSomeDefaultNNparams(nn);

%if no validation
if type == 1 % AE
    [nn, Lbatch, L, L_val]  = mynntrain(nn, train_x, train_x, val_x, val_x);
elseif type == 2 % classifier
    [nn, Lbatch, L, L_val]  = mynntrain(nn, train_x, train_y, val_x, val_y);
end

nn.testing = 1; % make
output = mynnff(nn, test_x); 

