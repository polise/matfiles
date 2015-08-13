function [activations, states] = myRBMup(data, weights, hidbiases, hL_type)

[numExamples numDims]=size(data);

%  input to hidden neurons - batchSize x noHidden neurons, each row
%  contains the input to the hidden units
  hidInp = data * weights; 
  % create biases matrix
  hidBiasesMatrx = repmat(hidbiases,numExamples,1);
  
  finalHidInp = hidInp + hidBiasesMatrx;
  
  
  % contains activations of hiiden units, batchSize x noHidden neurons
 
  activations = computeActivations(hL_type, finalHidInp);
  
  % create hidden states activations
states = computeStates(hL_type, activations, finalHidInp);