function nn = mynnsetup(newLayers, activation_functions)
%NNSETUP creates a Feedforward Backpropagate Neural Network
% nn = nnsetup(architecture) returns an neural network structure with n=numel(architecture)
% layers, architecture being a n x 1 vector of layer sizes e.g. [784 100 10]

    nn.size   = newLayers;
    nn.n      = length(newLayers);

    nn.epochs = 1000;
    nn.batchsize = 100;
    nn.activation_functions              = activation_functions;   %  Activation functions of hidden layers: 'sigm' (sigmoid) or 'tanh_opt' (optimal tanh) or linear.
    
    nn.learningRateParams.lr             = 0.1;            %  learning rate Note: typically needs to be lower when using 'sigm' activation function and non-normalized inputs.
    nn.learningRateParams.scalingFactor  = 1;            %  Scaling factor for the learning rate (each epoch)
    nn.learningRateParams.lrEpochThres   = 100;
    nn.learningRateParams.schedulingType = 1; % 1 = lr*T / max(currentEpoch, T), 2 = scaling, 3 = lr / (1 + currentEpoch/T)
    nn.learningRateParams.initialLR      = 1; 
    
    nn.momParams.momentum                = 0.9;          %  Momentum
    nn.momParams.initialMomentum         = 0.5; 
    nn.momParams.finalMomentum           = 0.9; 
    nn.momParams.momentumEpochThres      = 100; 
    nn.momParams.scalingFactor           = 1;
    nn.momParams.schedulingType          = 1; %1 = linear increase between initial and final value, 2 = scaling
    
    nn.weightInitParams.type             = 1;% 1=  a gaussian is used with 0 mean and stdev sigma, 2 = applies only to sigmoid, initialise uniform from [-r,r] where r = 4*sqrt(6 /(fanIn+fanOut) )
    nn.weightInitParams.sigma            = 0.1;% st. dev. of gaussian used to initialse weights (mean=0, std = sigma), applies to type 1 only
    nn.weightInitParams.biasType         = 2; % 2 = constant, 1 = a gaussian is used with 0 mean and stdev sigma
    nn.weightInitParams.biasConstant     = 0;
    
    nn.weightPenaltyL2                  = 0;            %  L2 regularization
    nn.weightPenaltyL1                  = 0;            %  L1 regularisation
    nn.nonSparsityPenalty               = 0;            %  Non sparsity penalty
    nn.sparsityTarget                   = 0.05;         %  Sparsity target
    nn.maxNormConstraint                = 0;
    nn.inputZeroMaskedFraction          = 0;            %  Used for Denoising AutoEncoders
    nn.dropoutType                      = 0;   % 0 = no dropout, 1 = bernoulli droput, 2 = gaussian dropout 
    nn.dropoutPresentProbVis            = 0.8;   % use 1 if no input layer droput is needed
    nn.dropoutPresentProbHid            = 0.5;          %  Dropout level (http://www.cs.toronto.edu/~hinton/absps/dropout.pdf)
    nn.pretraining                      = 0;
    nn.testing                          = 0;            %  Internal variable. nntest sets this to one.
    nn.plot                             = 0;
    
    

