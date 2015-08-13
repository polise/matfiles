function nn = useSomeDefaultNNparams(nn)

%i.e. if bernoulli dropout and pretraining is used then weights should be rescaled by
%1/p according to Dropout paper
if nn.pretraining == 1 && nn.dropoutType == 1 

        p =  1 ./ [nn.dropoutPresentProbVis ones(1,nn.n - 1) * nn.dropoutPresentProbHid];
    
        nn.W = rescaleWeights4Dropout(nn.W, p);
end


%if pretraining and dropout then use no weight constraints and a small
%learning rate
if nn.pretraining == 1 && nn.dropoutType ~= 0

        %according to the above paper no weight constraints should be used
        %and a small learning rate
        nn.learningRateParams.lr = 0.01; % or 0.1
        nn.learningRateParams.scalingFactor  = 1; %i.e., constant lr
        nn.learningRateParams.schedulingType = 2;
        
        nn.momParams.initialMomentum = 0.5;
        nn.momParams.finalMomentum = 0.9;
        nn.momParams.momentumEpochThres = 20;
        nn.momParams.schedulingType     = 1;
    
%     or
%     nn.momParams.momentum = 0.9;
%     nn.momParams.scalingFactor = 1; %i.e. constant
%     nn.momParams.schedulingType = 2;
        
        
        nn.weightPenaltyL1 = 0;
        nn.weightPenaltyL2 = 0;
        nn.maxNormConstraint = 0;
 
%if NO pretrainig and dropout then use preferably max-norm constraint and a
%high learning rate + momentum with scheduling
elseif nn.pretraining == 0 && nn.dropoutType ~= 0
    

%     e.g.
    nn.learningRateParams.lr = 10;
    nn.learningRateParams.scalingFactor = 0.998;
    nn.learningRateParams.schedulingType = 2;
    
    nn.momParams.initialMomentum = 0.5;
    nn.momParams.finalMomentum = 0.99;
    nn.momParams.momentumEpochThres = 500;
    nn.momParams.schedulingType     = 1;
    
%     or
    nn.momParams.momentum = 0.95;
    nn.momParams.scalingFactor = 1; %i.e. constant
    nn.momParams.schedulingType = 2;
    
    
    nn.weightPenaltyL1 = 0;
    nn.weightPenaltyL2 = 0;
    nn.maxNormConstraint = 3;
end


