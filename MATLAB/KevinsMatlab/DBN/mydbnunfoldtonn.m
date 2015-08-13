function nn = mydbnunfoldtonn(dbnParams, dbn)
%DBNUNFOLDTONN Unfolds a DBN to a NN
%   dbnunfoldtonn(dbn, outputsize ) returns the unfolded dbn with a final
%   layer of size outputsize added.

    if dbnParams.type == 1 % AE
        
        [weightsAE, biasesAE, newActivationFunctions newLayers] = dbnUnfoldToAE(dbnParams, dbn);
        nn = mynnsetup(newLayers, newActivationFunctions);
        nn.W = weightsAE;
        nn.biases = biasesAE;
        
    elseif dbnParams.type == 2 % classification
        
        
        [weightsClsf, biasesClsf, newActivationFunctions newHiddenLayers] = dbnUnfoldToClsf(dbnParams, dbn);
        nn = mynnsetup(newHiddenLayers, newActivationFunctions);
        
        nn.W = weightsClsf;
        nn.biases = biasesClsf;
        
    elseif dbnParams.type == 3
        % haven't checked this
        nn = mynnsetup(dbnParams.hiddenLayers, dbnParams.hiddenActivationFunctions);
        nn.W = dbn.W;
        nn.biases = dbn.hidbiases;
    
    end
    
    nn.pretraining = 1;
        
end

