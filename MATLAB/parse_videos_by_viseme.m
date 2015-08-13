
%{
Program takes one volunteer's datafiles, and parses them by viseme (using
frames.txt), putting all of the data into one large cell array, aptly named
"cell_array";



%}

%s = what; %look in current directory
directory = what('01M'); %change dir for your directory name 
matfiles = directory.mat; %all of the .mat files in 01M become part of matfiles

file = fopen('frames.txt'); %frame/viseme data

%cell array with 40 frames for 60 different visemes (both [grave]
%overestimates).
p01M_cell_array = cell(1,100);

%current matfile
matfile = 1;

line = fgets(file); %get rid of initial title page
line = fgets(file); %0 27 sil

%load single .mat file (eg, sa1.mat)
load(char(matfiles(matfile)));
[X,no_frames] = size(ROIs{1});

viseme = 1;
while(~feof(file))
    
    
   num = textscan(line,'%d %d %s'); 
   A = num{1}; B = num{2}; str = num{3}{1}; % A=0; B=27, str=sil
   
   count = 1;
   
   for i = A:B
       if (i > no_frames)
           break;
       end
       
       p01M_cell_array{matfile}{viseme}{count} = ROIs{1}{i};
       count = count+1;
   end
   
   viseme = viseme + 1;
   
   
   %to avoid end of file error message 
   if(feof(file)) 
       break; 
   end
   
   line = fgets(file); % new line
   
   if(strcmp(line(1),'"')==1)
    
   
       
    % at a new matfile
    matfile = matfile+1;  
       
    %load single .mat file (eg, sa1.mat)
    load(char(matfiles(matfile)));

    % viseme count at 1 again
    viseme = 1;
    
    % Y = no frames 
    [X,no_frames] = size(ROIs{1});

    %[rows,cols] = size(ROIs{1}{1});

    %ignore intro file title
    line = fgets(file);


       
   end
   
   
end




















%{
line = fgets(file);
while(~feof(file))

    line = fgets(file);
    is_dot = line(1);
    if((strcmp(is_dot,'.')==0))
        
        output('end of a sentence');
        break;
        
    end
    % parse
    num = textscan(line, '%d %d %s');
    %keep track
    count = 1;
    
    for i=num{1}:num{2}

        cell_array{1}{frame}{count} = ROIs{1}{i};
        count = count + 1;

    end
    frame = frame + 1;
    
end



while(strcmp(line(1),'.')==0)
     line = fgets(file);
     count = 1;
     num = textscan(line,'%d %d %s');
     
     for i=num{1}:num{2}
         cell_array{1}{x}{count} = ROIs{1}{i};
         count = count+1;
     end
      
    x=x+1;
     
end

%}
%{
  if (strcmp(line(1),'.')==1)
           fprintf(converted,'%s',line);
           line = fgets(file);
           fprintf(converted,'%s',line);
           line = fgets(file);
            
        end

%}