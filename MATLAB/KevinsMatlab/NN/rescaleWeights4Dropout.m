function w = rescaleWeights4Dropout(w, p)

for i =1:length(p)
   
    rescaleConstant = p(i);
    
%     if rescaleConstant ~= 0
       w{i} =  rescaleConstant * w{i};
%     end
    
end


