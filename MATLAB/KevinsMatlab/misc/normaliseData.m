function data = normaliseData(trFcn, data)


if strcmpi(trFcn, 'linear')
   ymean = 0;
   ystd = 1;
   [data,PS] = mapstd(data,ymean,ystd);
   
elseif strcmpi(trFcn, 'sigm')
    data = data/max(data(:)); %255;
end