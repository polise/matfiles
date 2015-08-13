function lr = updateLR(lrParams, currentEpoch)


if lrParams.schedulingType == 1
    
      
    lr = lrParams.initialLR * lrParams.lrEpochThres / max(currentEpoch, lrParams.lrEpochThres ); %from 'Practical Recommendations 
    %for Gradient-Based Training of Deep Architectures' by Y. Bengio
    
elseif lrParams.schedulingType == 2
       
      
    if  currentEpoch == 1
    
        currentLR = lrParams.initialLR;
        
    else
        currentLR = lrParams.lr;   
    end
    
    lr = currentLR * lrParams.scalingFactor; % from 'Improving neural networks by preventing co-adaptation of feature detectors' by Hinton et al. (arxiv)
        
elseif lrParams.schedulingType == 3
    
    lr = lrParams.initialLR / (1 + currentEpoch / lrParams.lrEpochThres); % from 'Dropout:  A Simple Way to Prevent Neural Networks from
%Overfitting' by Srivastava et al.
end