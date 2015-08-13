function [nn, L_perBatch, L, L_val ]  = mynntrain(nn, train_x, train_y, val_x, val_y)
%NNTRAIN trains a neural net


validation = 0;

if nargin == 5
    validation = 1;
end

fhandle = [];
if nn.plot == 1
    fhandle = figure();
end

[m, inputDim] = size(train_x);

batchsize = nn.batchsize;
numepochs = nn.epochs;

numbatches = ceil(m / batchsize);

% loss per epoch on the training set
L = zeros(1, numepochs); 
% loss per epoch on the validation set
L_val = zeros(1, numepochs); 
% loss per epoch, batch on the training set
L_perBatch = zeros(numepochs, numbatches);

%initialise vW, vBiases to zeros in case momentum is
% used
if nn.momParams.momentum > 0
    [vW, vBiases] = initialisePreviousUpdateWeights(nn.W, nn.biases);
else
    vW = 0;
    vBiases = 0;
    
end
    
if nn.nonSparsityPenalty > 0
    nn.p = initialiseSparsity(nn.size);
end

for i = 1 : numepochs
    % Starts stopwatch
    tic;

    randomorder = randperm(m);
    
    % For all batches ...
    for batch = 1 : numbatches
        
        % If it's the last batch, just shuffle from current position to end
         if batch == numbatches
            
            batch_x = train_x(randomorder((batch - 1) * batchsize + 1 : end), :);
            batch_y = train_y(randomorder((batch - 1) * batchsize + 1 : end), :);
        % Otherwise shuffle the training examples from the current pos to
        % next batch starting point
        else
            
            batch_x = train_x(randomorder((batch - 1) * batchsize + 1 : batch * batchsize), :);
            batch_y = train_y(randomorder((batch - 1) * batchsize + 1 : batch * batchsize), :);
        end
        
        % Add noise to input (for use in denoising autoencoder)
        if(nn.inputZeroMaskedFraction ~= 0)
            % A random subsample of the original batch is zeroed out 
            % ipnutZeroMaskedFraction % of the time 
            batch_x = batch_x .* (rand(size(batch_x)) > nn.inputZeroMaskedFraction);
        end
        
       
        if nn.dropoutType ~= 0
             %dropout for hidden layers
            dropoutMasks = createDropoutMasks(nn.size(1:end-1), batchsize, nn.dropoutPresentProbHid, nn.dropoutType);
            nn.dropoutMasks = dropoutMasks;
            
            %dropout for input layer
            dropoutMaskInput = createDropoutMasks(inputDim, batchsize, nn.dropoutPresentProbVis, nn.dropoutType);
            nn.dropoutMaskInput = dropoutMaskInput;
            
             %apply dropout to input
             batch_x = batch_x .* dropoutMaskInput{1}; % same as inputZeroMaskedFraction above?
        end
        
        [output, layerActivations] = mynnff(nn, batch_x);
        nn.a = layerActivations;
        
        if nn.nonSparsityPenalty > 0
           p = computeActivationsForSparsity(nn.p, layerActivations, nn.size);
           nn.p = p;
        end
        
        [e, Lbatch] = computeLoss(batch_y, output, nn.activation_functions{end});
        
        [dW,dBiases] = mynnbp(nn, batch_x, e);
 
        % check gradients
%         mynnchecknumgrad(nn, batch_x, batch_y, dW);
        
        [nn, vW, vBiases] = mynnapplygrads(nn, dW, dBiases, vW, vBiases);
        
        L_perBatch(i,batch) = Lbatch;
        
    end
    
    t = toc;
    
    originalW = nn.W;
    nn.testing = 1;
    
    %if bernoulli dropout then rescale the weights for testing
    if nn.dropoutType == 1
        
        p =  [nn.dropoutPresentProbVis ones(1,nn.n - 1) * nn.dropoutPresentProbHid];
    
        nn.W = rescaleWeights4Dropout(nn.W, p);
    end
        
    [output, layerActivations] = mynnff(nn, train_x); 
    [e, L(i)] = computeLoss(train_y, output, nn.activation_functions{end});
    str_perf = sprintf('; Full-batch train err = %f', L(i));
    disp(str_perf)
    
    if validation == 1
        [output_Val, layerActivations] = mynnff(nn, val_x);
        [e_val, L_val(i)] = computeLoss(val_y, output_Val, nn.activation_functions{end});
        
        str_perf = sprintf('; Full-batch val err = %f',  L_val(i));
        disp(str_perf)
    end
        
        % if classification compute CR on train and validation
         
    
    if ishandle(fhandle)
        nnupdatefigures(nn, fhandle, loss, opts, i);
    end
        
    disp(['epoch ' num2str(i) '/' num2str(numepochs) '. Took ' num2str(t) ' seconds' '. Mini-batch mean error on training set is ' num2str(mean(L_perBatch(i,:)))]);
    
    nn.learningRateParams.lr = updateLR(nn.learningRateParams, i);
    nn.momParams.momentum = updateMomentum(nn.momParams, i);
    
    disp(['lr = ',num2str(nn.learningRateParams.lr)]);
    disp(['mom = ', num2str(nn.momParams.momentum)]);
    
    nn.testing = 0;
    nn.W = originalW;
    
end
 
    %if bernoulli dropout then rescale the weights for testing
if nn.dropoutType == 1

        p =  [nn.dropoutPresentProbVis ones(1,nn.n - 1) * nn.dropoutPresentProbHid];
    
        nn.W = rescaleWeights4Dropout(nn.W, p);
    
end



end

