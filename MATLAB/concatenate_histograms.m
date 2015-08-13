% Concatonate Histograms.

load('av_data_histogram');

x_vals = zeros(length(Histogram),length(Histogram{1,1}));
y_vals = zeros(length(Histogram),26);

to_thirty  = 1;
letter = 1;
for i = 1:780
    
   y_vals(i,letter) = 1; 
   to_thirty = to_thirty + 1;
   if (to_thirty == 31)
      to_thirty = 1;
      letter = letter+1;
   end
   
   new_amazing_array = reshape(Histogram{i},1,177);
 
   for j = 1:177
        x_vals(i,j) = new_amazing_array(1,j);
   end
end

% 
% 
% for i = 1:780
% 
%     
%         x_vals(i,:) = reshape(Histogram{i},1,177);
%         
%     
%     
%     
% end





%new_histo = Histogram(:,:)*100;
%  axis([0 0.2 0 0.2 0 0.2]);
% for i = 1:length(new_histo)
%     
%     x = Histogram(1,i);
%     y = Histogram(2,i);
%     z = Histogram(3,i);
%     plot3(x,y,z)
%    
%    hold on 
% end