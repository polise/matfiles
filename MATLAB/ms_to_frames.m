
%old file
file = fopen('volunteer_labelfiles.txt');

%new file
converted = fopen('frames.txt','wt');
twice = 0;
line = fgets(file);
line = fgets(file);
fprintf(converted,'%s',line);
while (~feof(file))
        
        
        line = fgets(file);

        if (strcmp(line(1),'.')==1)
           %fprintf(converted,'%s',line);
           line = fgets(file);
           fprintf(converted,'%s',line);
           line = fgets(file);
            
        end
        
        
        %parse info
        
        num = textscan(line,'%d %d %s');
      
        
        % convert into time.
        [A,B] = time2VideoFrames(num{1},num{2},30);
        viseme = num{3}{1};
        %put into new file
        fprintf(converted,'%d %d %s \n',A,B,viseme);

end

