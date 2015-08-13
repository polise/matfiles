

% loads all of the mat files in 01M and plays every one as a video.

%s = what; %look in current directory
%cd ('LBP-TOP/Lips');
p = what('LBP-TOP/Lips'); %change dir for your directory name 
lipfiles = p.mat;

%load('sa1.mat');
for j = 1 %:numel(lipfiles)
    load(char(lipfiles(j)));
    
    [x,y] = size(vid);
    %
    for i = 1:y
        reshaped = reshape(vid(:,i),60,80);
        imshow(reshape(vid(:,i),60,80));
        %imshow(vid{:}{i});
        
    end
    text = 'DONE YET ANOTHER AMAZING VIDEO CLIP!';
    display(text);
end




