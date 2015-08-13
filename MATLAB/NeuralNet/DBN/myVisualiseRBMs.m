
function myVisualiseRBMs(weights,col,row,noSubplots)

[dd,N] = size(weights);

minValue = min(weights(:));
maxValue = max(weights(:));

noExPerSubplot = floor(N / noSubplots);

img2Disp = cell(noSubplots, noExPerSubplot);


for i = 1:noSubplots
    
    baseInd = (i - 1) * noExPerSubplot;  

    for j = 1:noExPerSubplot
    
        selInd =  baseInd + j;
              
        img = reshape(weights(:,selInd),row,col);

        img(:,end+1:end+3) = minValue; 
        img(end+1:end+3,:) = minValue; 
      
        img2Disp{i,j} = img;
 
    end
 
end

img2DispFinal = cell2mat(img2Disp);
imagesc(img2DispFinal,[minValue,maxValue]); colormap gray; axis equal; axis off;


drawnow;


