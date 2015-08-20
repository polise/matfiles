%load('x_vals');
%load('y_vals');



[rows cols] = size(x_vals);
letters = 26;

% Videos 1-8: test, 9-22:train, 23-30: validate
train_x_histo = zeros((14*letters),cols);
train_y_histo = zeros((8*letters),letters);

test_x_histo = zeros((8*letters),cols);
test_y_histo = zeros((8*letters),letters);

val_x_histo = zeros((8*letters),cols);
val_y_histo = zeros((8*letters),letters);

to_thirty=1; % Each letter is spoken 30 times, 
% and all instances are clumped together in x_vals, in order

testrow = 1;  
trainrow = 1; 
valrow = 1; 
letter = 1;

% For all 780 Rows in test_x and test_y
for count = 1:rows
   
    % If to_thirty = 30, program has reached a new set of video data where
    % participants are speaking new letter (e.g., A -> B).
    if to_thirty == 31 
       to_thirty = 1;
       letter = letter + 1;
    end
    
    if to_thirty < 9
        test_x_histo(testrow, :) = x_vals(count,:);
        test_y_histo(testrow,:) = y_vals(count,:);
        testrow = testrow+1;
        
        
    elseif to_thirty < 23        
        train_x_histo(trainrow, :) = x_vals(count,:);
        train_y_histo(trainrow,:) = y_vals(count,:);
        trainrow = trainrow+1;
        
        
    else
        val_x_histo(valrow, :) = x_vals(count,:);
        val_y_histo(valrow,:) = y_vals(count,:);
        valrow = valrow+1;
           
    end
        
    to_thirty = to_thirty + 1;
    
    
    
    
end