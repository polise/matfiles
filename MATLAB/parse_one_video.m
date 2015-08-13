
%{
Program takes one volunteer's datafiles, and parses them by viseme (using
frames.txt), putting all of the data into one large cell array, aptly named
"cell_array";



%}

%s = what; %look in current directory
directory = what('01M'); %change dir for your directory name 
matfiles = directory.mat; %all of the .mat files in 01M become part of matfiles

file = fopen('shorter.txt'); %frame/viseme data

%cell array with 40 frames for 60 different visemes (both [grave]
%overestimates).
one_vid_cell_array = cell(1,60);

%current matfile
matfile = 1;

line = fgets(file); %get rid of initial title page
line = fgets(file); %0 27 sil

%load single .mat file (eg, sa1.mat)
load(char(matfiles(matfile)));
 
% Y = no frames 
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
       
       cell_array{viseme}{count} = ROIs{1}{i};
       count = count+1;
   end
   
   viseme = viseme + 1;
   
   
   %to avoid end of file error message 
   if(feof(file)) 
       break; 
   end
   
   line = fgets(file); % new line
   

   
   
end