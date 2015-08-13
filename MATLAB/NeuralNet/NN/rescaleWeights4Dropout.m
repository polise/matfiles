function w = rescaleWeights4Dropout(w, p)

for i =1:length(p)
   
    rescaleConstant = p(i);
    w{i} =  rescaleConstant * w{i};

end


