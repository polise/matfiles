

lips = what('Lips'); %change dir for your directory name 
matfiles = lips.mat;
av_lips = cell(1,numel(matfiles));
%frames_per_video = [1,numel(matfiles)]; % frames in each video in AV code
grand_counter = 0;

for i = 1 :numel(matfiles)

  
    load(char(matfiles(i)));
    [X,Y] = size(vid); % X = data points in picture (4800); Y = no. frames (variable)
    
    grand_counter = grand_counter + Y; % counts number of frames in total
  %  frames_per_video(1,i) = Y;
    
end

no_letters = 26;
space_for_frames = 7800;
length_of_frame = 4800;
no_matfiles = 800; %actually 780 but to make things easy, round up

% create a matrix of the right size for each test and train and validation
% set, X and Y % calculated by hand and put in because something went wrong
train_x_AV = zeros(length_of_frame,8951);
val_x_AV = zeros(length_of_frame,4797);
test_x_AV = zeros(length_of_frame,4797); 

train_y_AV = zeros(no_letters,8951); 
val_y_AV = zeros(no_letters,4797);
test_y_AV = zeros(no_letters,4797);

%keep track of how many videos have been processed in order to incriment
%letter
to_thirty = 1; 
letter = 1;

% Keep track of number of elements you've put in train, test, validate
testrow = 0; testcolumn = 0; 
trainrow = 0; traincolumn = 0;
validaterow = 0; validatecolumn = 0;

%Number of each that end up existing
trainers = 1; testers = 1; validators =1;



for k = 1:numel(matfiles) %780
    
    
    % load next video
    load(char(matfiles(k)));
    [X,Y] = size(vid);
    
    % Every letter is spoken 30 times, in order. 
    % To keep track of where to put 1 in y matrices.
    if to_thirty == 31 
       to_thirty = 1;
       letter = letter + 1;
    end
    
    if (to_thirty<9)
        for j = 1:Y % Y = no. frames in video

      
            test_x_AV(:,(testcolumn+j)) = vid(:,j);
            test_y_AV(letter,(testcolumn+j)) = 1; % Train for all frames is at letter 'letter'

        end  
        
        testers = testers + 1;
        testrow = testrow + 4800;
        testcolumn = testcolumn + Y; 
    elseif (to_thirty<23)
        for j = 1:Y % Y = no. frames in video

            
           
           train_x_AV(:,(traincolumn+j)) = vid(:,j);
           train_y_AV(letter,(traincolumn+j)) = 1; % Train for all frames is at letter 'letter'
        end  
        
        trainers = trainers + 1;
        trainrow = trainrow + 4800;
        traincolumn = traincolumn + Y;
        
    else
        for j = 1:Y % Y = no. frames in video

            
            
            validate_x_AV(:,(validatecolumn+j)) = vid(:,j); 
            validate_y_AV(letter,(validatecolumn+j)) = 1; % Train for all frames is at letter 'letter'

        end  
        
        validators = validators + 1;
        validaterow = validaterow + 4800;
        validatecolumn = validatecolumn + Y;
        
    end
    
    to_thirty = to_thirty+1;
end


test_x_AV = test_x_AV';
test_y_AV = test_y_AV';
train_x_AV = train_x_AV';
train_y_AV = train_y_AV';
val_x_AV = val_x_AV';
val_y_AV = val_y_AV';
