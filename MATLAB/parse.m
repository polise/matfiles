% take one image and make some number of cell arrays

load('sa1.mat');
%matrix = cell2mat(cell);
% get number of frames minus one because WHY IS THERE ONE LESS FRAME IN
% 111?
[x,frames] = size(ROIs{1});
display(frames);




% size of each segment of video data

%display(size_slot); display(y);
%partitioned_image = cell(y,10,size_slot);
%partitioned_image{1}{2}{2} = 67;
%display(partitioned_image{1}{2});

% sample array size to create cell array for new data
array = ROIs{1}{1};
size_array = size(array);
rows = size_array(1);
cols = size_array(2); 
parse_rows = floor(rows/2);
parse_cols = floor(cols/5);

% create a new cell array to put this shit in. 
number_segments = 10;
data = zeros(parse_rows,parse_cols,number_segments,frames);


% for each run through, get the parse_height of height of frames, and the
% parse_width of width 


current_x = 1; current_y = 1; current_segment = 1; tier = 5;

for f = 1:frames
    array = ROIs{1}{f};
    
    % get number of rows, columns, and ideal parse size

    sz_array = size(array);
   
    
    
    for r = 1:parse_rows
        for c = 1:parse_cols
           data(r,c,current_segment,f) = array(r,c); % segment 1
           data(r,c,current_segment+tier,f) = array(r+parse_rows,c); % segment 6

           for count = 1:4
               if ( c+(count*parse_cols) > sz_array(2))
                   break;
               end
               data(r,c,current_segment+count,f) = array(r,c+(count*parse_cols));
                        
               data(r,c,current_segment+count+tier,f) = array(r+parse_rows,c+(count*parse_cols));
               
           end
           
            
        end
       
        
       
    end
    
          
          
           
   
end
    % you want the info to go into partitioned_image(i)(1)(stepcount)
    



