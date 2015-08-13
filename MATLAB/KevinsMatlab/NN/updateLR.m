function lr = updateLR(lrParams, currentEpoch)


if lrParams.schedulingType == 1
    
        lr = lrParams.initialLR * lrParams.lrEpochThres / max(currentEpoch, lrParams.lrEpochThres ); %from Bengio's practical recommendations
    
elseif lrParams.schedulingType == 2
       
        lr = lrParams.lr * lrParams.scalingFactor; % from Hintons dropout
        
elseif lrParams.schedulingType == 3
    
    lr = lrParams.lr / (1 + currentEpoch / lrParams.lrEpochThres);
end