

% loads all of the mat files in 01M and plays every one as a video.

%s = what; %look in current directory
%s = what('01M'); %change dir for your directory name 
s = what('LBP-TOP/Lips'); %change dir for your directory name 

matfiles = s.mat;

%load('sa1.mat');
for j = 1 %:numel(matfiles)
    video = load(char(matfiles(j)));
    %[x,y] = size(vid{j});
    %[x,y] = size(ROIs{1});
    %display(y);
    video = video.vid;
    [x,y] = size(video);
    for i = 1:y
            imshow(reshape(video(i,:),60,80)); %{1}{i});
            
    end
    text = 'DONE YET ANOTHER AMAZING VIDEO CLIP!';
    display(text);
end




