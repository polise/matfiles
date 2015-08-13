function  [activations, states] = myRBMdown(data, weights, visbiases, vL_type)

% batchSize x noDims, each row contains one example generated from the
% hidden states through backpopagating their states multiplied by the
% weights
        numExamples = size(data, 1);

        inpFromHidden = data * weights';
        
        visBiasesMatrix = repmat(visbiases,numExamples,1);
        
        finalVisInput = inpFromHidden + visBiasesMatrix; 

 %same inpFromHidden but it contains the probabilities
        activations = computeActivations(vL_type, finalVisInput);

          % create hidden states binary activations
        states = computeStates(vL_type, activations, finalVisInput);
