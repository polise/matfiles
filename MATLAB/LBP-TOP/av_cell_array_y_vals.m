
% test y values for theoretically pixel by pixel inserted data from 9
% frames of each av file, put into a 9*780 cell array, each column
% representing a video, each row representing a frame of that video.

av_file_cell_array_y_vals = cell(9,780);

pointer = 1;

for i = 1:26
    for j = pointer:(pointer+30)
        for k = 1:9
            av_file_cell_array_y_vals{k,j} = zeros(26,1);
            av_file_cell_array_y_vals{k,j}(i,1) = 1;
        end
    end
    
    
    
    
    
    pointer = pointer+30;
end
