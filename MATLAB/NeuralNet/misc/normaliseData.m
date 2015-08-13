function data = normaliseData(trFcn, data)

% in case of linear visible layer it is recommended by Hinton in "A practical guide 
%to training RBMs" to make each dimension of the feature vector to have
%zero mean and unit standard deviation.
if strcmpi(trFcn, 'linear')
   ymean = 0;
   ystd = 1;
   [data,PS] = mapstd(data,ymean,ystd);
   
% in case the activation function of the visible layer is "sigm" i.e. data
% are binary, then simply divide by the max value so the data are in the
% range [0, 1].
elseif strcmpi(trFcn, 'sigm')
    data = data/max(data(:)); %255;
end