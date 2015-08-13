
function myVisualiseRBMs(weights,col,row,noSubplots)
% display a group of MNIST images 
% col=70;
% row=27;

[dd,N] = size(weights);
% imdisp=zeros(2*row,ceil(N/2)*col);

minValue = min(weights(:));
maxValue = max(weights(:));

noExPerSubplot = N/noSubplots;

img2Disp = cell(noSubplots, noExPerSubplot);

% 
% indSt = 1;
% indEnd = col;

for i = 1:noSubplots
    
    baseInd = (i - 1) * noExPerSubplot;  

    for j = 1:noExPerSubplot
    
      selInd =  baseInd + j;
        
      img = reshape(weights(:,selInd),row,col);

      img(:,end+1:end+3) = minValue; 
      img(end+1:end+3,:) = minValue; 
      
      img2Disp{i,j} = img;

%       img2Disp2(:,indSt:indEnd) = img2;
    
%       indSt = indSt + col;
%       indEnd = indEnd + col;
 
    end
 
end

img2DispFinal = cell2mat(img2Disp);
 imagesc(img2DispFinal,[minValue,maxValue]); colormap gray; axis equal; axis off;

% img2DispSub1 = [img2Disp1; img2Disp2];

% subplot(4,1,1), imagesc(img2DispSub1); colormap gray; axis equal; axis off;
% subplot(4,1,2), imagesc(img2DispSub2); colormap gray; axis equal; axis off;
% subplot(4,1,3), imagesc(img2DispSub3); colormap gray; axis equal; axis off;
% subplot(4,1,4), imagesc(img2DispSub4); colormap gray; axis equal; axis off;

% subplot(2,1,1), imagesc(img2Disp1); colormap gray; axis equal; axis off;
% subplot(2,1,2), imagesc(img2Disp2); colormap gray; axis equal; axis off;
drawnow;
% err=0; 

