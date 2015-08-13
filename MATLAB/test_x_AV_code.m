

lips = what('Lips'); %change dir for your directory name 
matfiles = lips.mat;
%av_lips = cell(1,numel(matfiles));

test_x_AV = zeros(18562,4800);
row_cntr = 1;
for i = 1 :numel(matfiles)
    load(char(matfiles(i)));
    [X,Y] = size(vid);
    
    for j = 1:Y % Y = number of Frames    
       for k = 1:X % X = number of rows in data
           test_x_AV(row_cntr,k) = vid(k,j);
           
       end
       row_cntr = row_cntr + 1;
    end
    
    grand_counter = grand_counter + Y; 
    
    
end

test_y_AV = zeros(grand_counter,26);
to_thirty = 1; % make 30 rows of A
row_counter = 1;
column_counter = 1;
for k = 1:numel(matfiles)
    load(char(matfiles(k)));
    [X,Y] = size(vid);
    
    for j = 1:Y
        
    end
    

end

