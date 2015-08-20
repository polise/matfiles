function nn = useSomeDefaultNNparams(nn)

%i.e. if bernoulli dropout and pretraining is used then weights should be rescaled by
%1/p according to "Improving neural networks by preventing co-adaptation of
%feature detectors" by Hinton et al. (arxiv 2012)

if nn.pretraining == 1 && nn.dropoutParams.dropoutType == 1 

        p =  1 ./ [nn.dropoutParams.dropoutPresentProbVis ones(1,nn.noLayers - 1) * nn.dropoutParams.dropoutPresentProbHid];
    
        nn.W = rescaleWeights4Dropout(nn.W, p);
end


%if pretraining and dropout then use no weight constraints and a small
%learning rate according the paper above (sections A1, A2)
if nn.pretraining == 1 && nn.dropoutParams.dropoutType ~= 0

        %according to the above paper no weight constraints should be used
        %and a small learning rate
        nn.learningRateParams.lr = 0.05; 
        nn.learningRateParams.scalingFactor  = 1; %i.e., constant lr
        nn.learningRateParams.schedulingType = 2;
        
        nn.momParams.initialMomentum = 0.5;
        nn.momParams.finalMomentum = 0.99;
        nn.momParams.momentumEpochThres = 500;
        nn.momParams.schedulingType     = 1;
    
        %or
        %nn.momParams.momentum = 0.9;
        %nn.momParams.scalingFactor = 1; %i.e. constant
        %nn.momParams.schedulingType = 2;
        
        nn.weightConstraints.weightPenaltyL1 = 0;
        nn.weightConstraints.weightPenaltyL2 = 0;
        nn.weightConstraints.maxNormConstraint = 0;
 
%if NO pretrainig and dropout then use preferably max-norm constraint and a
%high learning rate + momentum with scheduling
elseif nn.pretraining == 0 && nn.dropoutParams.dropoutType ~= 0
    

%     e.g.
    nn.learningRateParams.lr = 10;
    nn.learningRateParams.scalingFactor = 0.998;
    nn.learningRateParams.schedulingType = 2;
    
    nn.momParams.initialMomentum = 0.5;
    nn.momParams.finalMomentum = 0.99;
    nn.momParams.momentumEpochThres = 500;
    nn.momParams.schedulingType     = 1;
    
%     or 
%     from �Dropout: A simple way to prevent neural networks from overfitting� by Srivastava at al. JMLR 2014 
%     nn.momParams.momentum = 0.95;
%     nn.momParams.scalingFactor = 1; %i.e. constant
%     nn.momParams.schedulingType = 2;
    
    
    nn.weightConstraints.weightPenaltyL1 = 0;
    nn.weightConstraints.weightPenaltyL2 = 0; %suggested 3 or 4, default 0.
    nn.weightConstraints.maxNormConstraint = 3; % L2: weight on any given neuron,#
    % Max norm: overall on all neuron
end


