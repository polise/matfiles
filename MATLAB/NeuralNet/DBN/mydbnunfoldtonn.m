function nn = mydbnunfoldtonn(dbnParams, dbn, outputSize)
%DBNUNFOLDTONN Unfolds a DBN to a NN
%   dbnunfoldtonn(dbn, outputsize ) returns the unfolded dbn with a final
%   layer of size outputsize added.

    
if dbnParams.type == 1 % AE
        

    disp('Unfolding DBN to AE')
    
    [weightsAE, biasesAE, newActivationFunctions newLayers] = dbnUnfoldToAE(dbnParams, dbn, outputSize);
    nn = mynnsetup(newLayers, newActivationFunctions);
    nn.W = weightsAE;
    nn.biases = biasesAE;
        
    
elseif dbnParams.type == 2 % classification

    disp('Unfolding DBN to Classifier')
    
    [weightsClsf, biasesClsf, newActivationFunctions newLayers] = dbnUnfoldToClsf(dbnParams, dbn, outputSize);
    nn = mynnsetup(newLayers, newActivationFunctions);   
    nn.W = weightsClsf;
    nn.biases = biasesClsf;
    
end


nn.pretraining = 1;
        


