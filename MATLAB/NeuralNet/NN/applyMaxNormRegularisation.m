function regW = applyMaxNormRegularisation(w, c)

regW = w;

w2 = w .^ 2;
normW = sqrt(sum(w2));

ind = find(normW > c);

for i = 1:length(ind)
    colInd = ind(i);
    regW(:,colInd) = regW(:,colInd) * (c / normW(colInd) ); 
    
end
