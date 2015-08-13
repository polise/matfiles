function momentum = updateMomentum(momParams, currentEpoch)


if momParams.schedulingType == 1
      
    if currentEpoch >= momParams.momentumEpochThres
        
        momentum = momParams.finalMomentum;
        
    else
    % linear increase between initial and final values
        momentum = (currentEpoch / momParams.momentumEpochThres) * momParams.finalMomentum + ...initialMomentum
            (1 - currentEpoch / momParams.momentumEpochThres) * momParams.initialMomentum;
    end
    
elseif momParams.schedulingType == 2
       
    if  currentEpoch == 1
      currentMom = momParams.initialMomentum;
    else
      currentMom = momParams.momentum;
    end
    
    momentum = currentMom * momParams.scalingFactor;
        
end