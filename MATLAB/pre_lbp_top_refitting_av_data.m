% Made to change AV files in LIPS into uniform 9-frame files, from frames
% 2-10, in order to reduce size and complexity before passing them into
% LBP-TOP. Result is a file clled pre_lbp_top_refitted_av_files, which is a
% 9*780 file, consisting of 9 frames for 780 separate videos.

cd ('LBP-TOP/Lips');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tst = what('Lips');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = dir('*.mat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Create uniformly small amount of frames to deal with for this first go
%through.
pre_lbp_top_refitted_av_files = cell(9,numel(a));

for video = 1:size(a,1)
      ImgName = getfield(a, {video}, 'name');
      Imgdat = load(ImgName);
      
      
      
      for frame = 2:10
           pre_lbp_top_refitted_av_files{frame-1,video} = reshape(Imgdat.vid(:,frame),60,80);
      end
      
 
      
    
end
