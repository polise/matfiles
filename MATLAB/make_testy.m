
y_vals = cell(1); % y_vals cell

for i = 1:26
    
    y_vals{1}{i} = zeros(26,30); % vectors are row-wise: every row is an input
    
    
end



[X,Y] = size(y_vals{1}); % y = 26
letter = 1;
spot_in_column = 1;

for letter = 1:26 
    
    
    for j = 1:26
        
       y_vals{letter}{1}(j,letter) = 1; 
    end
    
    
    letter = letter+1;
end
