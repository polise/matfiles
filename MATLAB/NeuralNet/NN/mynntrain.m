function [nn, L_perBatch, L, L_val ]  = mynntrain(nn, train_x, train_y, val_x, val_y)
%NNTRAIN trains a neural net


validation = 0;

if ~isempty(val_x) && ~isempty(val_y)
    validation = 1;
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
   
if nn.trainingMethod == 2 %1 = SGD, 2= rmsProp, 3 = cgd
    [mseW, mseBiases] = initialisePreviousUpdateWeights(nn.W, nn.biases);
else
    mseW = 0;
    mseBiases = 0;
    
end

for i = 1 : numepochs
    tic;

    randomorder = randperm(m);
    
    for batch = 1 : numbatches
         
        if batch == numbatches
            
            batch_x = train_x(randomorder((batch - 1) * batchsize + 1 : end), :);
            batch_y = train_y(randomorder((batch - 1) * batchsize + 1 : end), :);
        else
            
            batch_x = train_x(randomorder((batch - 1) * batchsize + 1 : batch * batchsize), :);
            batch_y = train_y(randomorder((batch - 1) * batchsize + 1 : batch * batchsize), :);
        end
        
        %Add noise to input (for use in denoising autoencoder)
        if(nn.inputZeroMaskedFraction ~= 0)
            batch_x = batch_x .* (rand(size(batch_x)) > nn.inputZeroMaskedFraction);
        end
        
       
        if nn.dropoutParams.dropoutType ~= 0
             %dropout for hidden layers
            dropoutMasks = createDropoutMasks(nn.layersSize(1:end-1), batchsize, nn.dropoutParams.dropoutPresentProbHid, nn.dropoutParams.dropoutType);
            nn.dropoutParams.dropoutMasks = dropoutMasks;
            
            %dropout for input layer
            dropoutMaskInput = createDropoutMasks(inputDim, batchsize, nn.dropoutParams.dropoutPresentProbVis, nn.dropoutParams.dropoutType);
            nn.dropoutParams.dropoutMaskInput = dropoutMaskInput;
            
             %apply dropout to input
             batch_x = batch_x .* dropoutMaskInput{1}; % same as inputZeroMaskedFraction above?
        end
        
        [output, layerActivations] = mynnff(nn, batch_x);
     
        [e, Lbatch] = computeLoss(batch_y, output, nn.activation_functions{end});
        
        [dW,dBiases] = mynnbp(nn, batch_x, e, layerActivations);
 
        % check gradients
%         mynnchecknumgrad(nn, batch_x, batch_y, dW);
        if nn.trainingMethod == 2 % i.e. rmsProp
        end

        [nn, vW, vBiases] = mynnapplygrads(nn, dW, dBiases, vW, vBiases);
        
        L_perBatch(i,batch) = Lbatch;
        
    end
    
    t = toc;
    disp(['epoch ' num2str(i) '/' num2str(numepochs) '. Took ' num2str(t) ' seconds'])
    disp(['Mini-batch mean error on training set is ' num2str(mean(L_perBatch(i,:)))]);

    disp(['lr = ',num2str(nn.learningRateParams.lr)]);
    disp(['mom = ', num2str(nn.momParams.momentum)]);     
    
    nn.learningRateParams.lr = updateLR(nn.learningRateParams, i);
    nn.momParams.momentum = updateMomentum(nn.momParams, i);
    
    % Test NN after each epoch on the entire trainings + validation sets
    %-------------------------
    originalW = nn.W;
    nn.testing = 1;
    
    %if bernoulli dropout then rescale the weights for testing
    if nn.dropoutParams.dropoutType == 1
        
        p =  [nn.dropoutParams.dropoutPresentProbVis ones(1,nn.noLayers - 1) * nn.dropoutParams.dropoutPresentProbHid];
        nn.W = rescaleWeights4Dropout(nn.W, p);
        
    end
        
    [output, layerActivations] = mynnff(nn, train_x); 
    [e, L(i)] = computeLoss(train_y, output, nn.activation_functions{end});
    disp(['Full-batch train err = ', num2str(L(i))])
    
    if validation == 1
        
        [output_Val, layerActivations_Val] = mynnff(nn, val_x);
        [e_val, L_val(i)] = computeLoss(val_y, output_Val, nn.activation_functions{end});
        disp(['Full-batch val err = ',  num2str(L_val(i))]);
        
    end
    
    % if classification compute CR on train and validation
    nn.testing = 0;
    nn.W = originalW;
    %-------------------------   
    
end
 
    %if bernoulli dropout then rescale the weights for testing
if nn.dropoutParams.dropoutType == 1

    p =  [nn.dropoutParams.dropoutPresentProbVis ones(1,nn.noLayers - 1) * nn.dropoutParams.dropoutPresentProbHid];
    nn.W = rescaleWeights4Dropout(nn.W, p);
    
end

