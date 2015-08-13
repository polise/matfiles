function [dbn, errorPerBatch errorPerSample] = myDBNtrain(dataMatrix, dbnParams)

activationFunctionsAllLayers = [dbnParams.inputActivationFunction, dbnParams.hiddenActivationFunctions];

hiddenLayers = dbnParams.hiddenLayers;
nHidLayers = length(hiddenLayers);

for i = 1:nHidLayers 

    noHidNeurons = hiddenLayers(i);
    [numExamples, numDims] = size(dataMatrix);

    fprintf(1,'Pretraining Layer %d with RBM: %d-%d \n',i, numDims,noHidNeurons);

    
    hLayer = activationFunctionsAllLayers(i + 1);
    vLayer = activationFunctionsAllLayers(i);
    
    trFctnLayers = [vLayer hLayer];
    
    [rbm, errorPerBatch{i}, errorPerSample{i}] = myRBMtrain(dataMatrix, dbnParams, noHidNeurons, trFctnLayers);
  
    dbn.W{i} = rbm.W; 
    dbn.hidbiases{i} = rbm.hidbiases;
    dbn.visbiases{i} = rbm.visbiases;
    
    [posHidProbs, posHidStates] = myRBMup(dataMatrix, rbm.W, rbm.hidbiases, hLayer);
    
    dataMatrix = posHidProbs;

end

disp('DBN training done')