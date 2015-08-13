lips = what('Lips'); %change dir for your directory name 
matfiles = lips.mat;

grand_counter = 0;

for i = 1 :numel(matfiles)

  
    load(char(matfiles(i)));
    [X,Y] = size(vid);
    
    grand_counter = grand_counter + Y; 
    
    
end
test_y_AV = zeros(grand_counter,26);

to_thirty = 1; % make 30 rows of A
row_counter = 1;
column_counter = 1;


for k = 1:numel(matfiles)
    load(char(matfiles(k)));
    [X,Y] = size(vid);
    
    if to_thirty == 31;
       to_thirty = 1;
       column_counter = column_counter + 1;
    end
    
    for j = row_counter:(row_counter+Y)
        %imshow(reshape(vid(:,j),60,80), [0,255])
        %av_lips{i}{j} = reshape(vid(:,j),60,80);
        test_y_AV(j,column_counter) = 1;
    
    end  
    row_counter = row_counter+Y+1;
    to_thirty = to_thirty+1;
end