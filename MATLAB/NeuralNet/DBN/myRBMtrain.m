function [rbm, errorPerBatch, errorPerSample] = myRBMtrain(dataMatrix, dbnParams, numHid, layerType)


lrW = dbnParams.rbmParams.lrW; % Learning rate for weights 
lrVb = dbnParams.rbmParams.lrVb; % Learning rate for biases of visible units 
lrHb = dbnParams.rbmParams.lrHb; % Learning rate for biases of hidden units 


weightPenaltyL2  = dbnParams.rbmParams.weightPenaltyL2;
initialmomentum  = dbnParams.rbmParams.initMomentum;
finalmomentum    = dbnParams.rbmParams.finalMomentum;

batchsize = dbnParams.rbmParams.batchsize;

[numExamples numDims]=size(dataMatrix);


numbatches = ceil(numExamples / batchsize);

maxepoch = dbnParams.rbmParams.epochs;

vL_type = layerType{1};
hL_type = layerType{2};

if strcmpi(vL_type, 'linear') || strcmpi(hL_type,'linear') || strcmpi(hL_type,'ReLu') || strcmpi(vL_type, 'ReLu')
    lrW = dbnParams.rbmParams.lrW_linear; % Learning rate for weights 
    lrVb = dbnParams.rbmParams.lrVb_linear; % Learning rate for biases of visible units 
    lrHb = dbnParams.rbmParams.lrHb_linear; % Learning rate for biases of hidden units 
end

% Initializing weights and biases. Weights are initialised randomly and
% biases are set to 0 as in Hinton's code http://www.cs.toronto.edu/~hinton/MatlabForSciencePaper.html
  weights     = 0.1*randn(numDims, numHid);
  hidbiases  = zeros(1,numHid);
  visbiases  = zeros(1,numDims);
  
deltaW  = zeros(numDims,numHid);
deltaVisbias = zeros(1,numDims);
deltaHidbias = zeros(1,numHid);
  
errorPerBatch = zeros(1, maxepoch);
errorPerSample = zeros(1, maxepoch);

for epoch = 1:maxepoch,
    disp(['epoch = ',num2str(epoch)] ); 
    errSum = 0;
    randomorder = randperm(numExamples);
    
    if epoch > dbnParams.rbmParams.momentumEpochThres,
     momentum = finalmomentum;
    else
     momentum = initialmomentum;
    end
    
    for batch = 1:numbatches,
        
        if batch == numbatches       
            data = dataMatrix(randomorder(1+(batch-1)*batchsize:end), :);
        else
            data = dataMatrix(randomorder(1+(batch-1)*batchsize:batch*batchsize), :);
        end
        
        
        %%%%%%%%% START POSITIVE PHASE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

      [posHidProbs, posHidStates] = myRBMup(data, weights, hidbiases, hL_type);
 
       if dbnParams.rbmParams.type == 1
          
           posprods    = data' * posHidProbs;
             % activation of hidden units over all (batch) training examples
          poshidact   = sum(posHidProbs);
  
       elseif dbnParams.rbmParams.type == 2
           posprods    = data' * posHidStates;
             % activation of hidden units over all (batch) training examples
           poshidact   = sum(posHidStates);
  
       end
       
       % activation of input units over all (batch) training examples
       posvisact = sum(data);

       %%%%%%%%% END OF POSITIVE PHASE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


       %%%%%%%%% START NEGATIVE PHASE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       % batchSize x noDims, each row contains one example generated from the
       % hidden states through backpopagating their states multiplied by the
       % weights
  
      [negVisProbs, negVisStates] = myRBMdown(posHidStates, weights, visbiases, vL_type);
         
      % contains activations of hiiden units, batchSize x noHidden neurons  
 
      if dbnParams.rbmParams.type == 1
           
          [negHidProbs, negHidStates] = myRBMup(negVisProbs, weights, hidbiases, hL_type);
          negprods  = negVisProbs' * negHidProbs;
          negvisact = sum(negVisProbs); 
          err = sum(sum( (data - negVisProbs).^2 ));
           
      elseif dbnParams.rbmParams.type == 2
      
          [negHidProbs, negHidStates] = myRBMup(negVisStates, weights, hidbiases, hL_type);
          negprods  = negVisStates' * negHidProbs;
          negvisact = sum(negVisStates); 
          err = sum(sum( (data - negVisStates).^2 ));
      
      end
      
      neghidact = sum(negHidProbs);
      %%%%%%%%% END OF NEGATIVE PHASE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
      errSum = errSum + err;        

      %%%%%%%%% UPDATE WEIGHTS AND BIASES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
      gradEstimate = (posprods - negprods) / batchsize;
      deltaW = momentum * deltaW + lrW * (gradEstimate  - weightPenaltyL2 * weights);
    
      gradEstimateVisBias = (posvisact - negvisact) / batchsize;
      deltaVisbias = momentum * deltaVisbias + lrVb * gradEstimateVisBias;
    
      gradEstimateHidBias = (poshidact - neghidact) / batchsize;
      deltaHidbias = momentum * deltaHidbias + lrHb * gradEstimateHidBias;

      weights = weights + deltaW;
      visbiases = visbiases + deltaVisbias;
      hidbiases = hidbiases + deltaHidbias;

      nanVec = isnan(weights(:));
    
      if sum(nanVec) ~= 0
        keyboard
      end
      
      %%%%%%%%%%%%%%%% END OF UPDATES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    end
   
 
   
    errPerSample = err / (numExamples * numbatches);
    errPerBatch = err /  numbatches;
    disp(['Mean Squared Error per sample = ', num2str(errPerSample)]); 
    disp(['Mean Squared Error per Batch = ', num2str(errPerBatch)]); 
    errorPerBatch(epoch) = errPerBatch;
    errorPerSample(epoch) = errPerSample;
end

rbm.W = weights;
rbm.hidbiases = hidbiases;
rbm.visbiases = visbiases;
