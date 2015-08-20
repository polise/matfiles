

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
train_x = zeros(length_of_frame,8951*2);
val_x = zeros(length_of_frame,4797);
test_x = zeros(length_of_frame,4797); 

train_y = zeros(no_letters,8951*2); 
val_y = zeros(no_letters,4797);
test_y = zeros(no_letters,4797);

histogram_test_y = zeros(182,26); 
histogram_train_y = zeros(416,26); 
histogram_val_y = zeros(182,26);

no_frames_val = zeros(182,1); frame_cnt_val = 1;
no_frames_test = zeros(182,1); frame_cnt_test = 1;
no_frames_train = zeros(416,1); frame_cnt_train = 1;

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
    
    if (to_thirty<8)
        
        no_frames_test(frame_cnt_test,1) = Y;
        frame_cnt_test = frame_cnt_test+1;
        
        for j = 1:Y % Y = no. frames in video
            test_x(:,(testcolumn+j)) = vid(:,j);
            test_y(letter,(testcolumn+j)) = 1; % Train for all frames is at letter 'letter'

        end  
        
        histogram_test_y(testers,letter) = 1;
        testers = testers + 1;
        testrow = testrow + 4800;
        testcolumn = testcolumn + Y; 
    elseif (to_thirty<24)
        
        no_frames_train(frame_cnt_train,1) = Y;
        frame_cnt_train = frame_cnt_train+1;
        
        for j = 1:Y % Y = no. frames in video
           train_x(:,(traincolumn+j)) = vid(:,j);
           train_y(letter,(traincolumn+j)) = 1; % Train for all frames is at letter 'letter'
        end  
        histogram_train_y(trainers,letter) = 1;
        trainers = trainers + 1;
        trainrow = trainrow + 4800;
        traincolumn = traincolumn + Y;
        
    else
        
        no_frames_val(frame_cnt_val,1) = Y;
        frame_cnt_val = frame_cnt_val+1;    
        for j = 1:Y % Y = no. frames in video
            
            val_x(:,(validatecolumn+j)) = vid(:,j); 
            val_y(letter,(validatecolumn+j)) = 1; % Train for all frames is at letter 'letter'

        end  
        histogram_val_y(validators,letter) = 1;
        validators = validators + 1;
        validaterow = validaterow + 4800;
        validatecolumn = validatecolumn + Y;
        
    end
    
    to_thirty = to_thirty+1;
end

train_x(:,8952:17902) = train_x(:,1:8951);
train_y(:,8952:17902) = train_y(:,1:8951);
test_x = test_x';
test_y = test_y';
train_x = train_x';
train_y = train_y';
val_x = val_x';
val_y = val_y';
