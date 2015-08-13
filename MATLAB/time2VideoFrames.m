function [startFrame, endFrame] = time2VideoFrames(startTime, endTime, fps)

%disp(['startTime equal ',num2str(startTime)]);
%disp(['endTime equal ',num2str(endTime)]);
startTime = startTime/100000;
endTime = endTime/100000;
startFrame = (startTime * fps);%ceil(startTime * fps + 1);
endFrame = (endTime * fps); %floor(endTime * fps); 

startFrame = floor(startFrame/100)+1;
endFrame = ceil(endFrame/100);

