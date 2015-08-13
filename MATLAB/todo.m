% Convert all data into doubles
% ** WHAT IS THE DIFFERENCE HERE BETWIXT TRAIN AND TEST? IS THIS ALREADY
% PRESUPPLIED IN MNIST_UINT8? train tests, test evaluates the performance. 
% x is the input, y is the target. target = one of the visemes. (convert 
% the visemes into a number ) binary presentation: 40 classes, 40 outputs and each 
% out put corresponds to a class (100000)**
% check the thesis to see how they divide the data into test, train and
% whatnot.
% stavros thinks that the data is divided by subjects. 
% subject dependent vs independent ( dependent: examples of the same
% subject appear in both the training and the test set )
% divide data into train, validation and test. validation: whenever there
% is a parameter to optimize, use this set. ( try a bunch of different
% parameters, and train and then test via validation test. parameter that
% give you the best value is the one you use in your model ) .
% start training some models. start with an autoencoder. input, and try to
% reproduce the output on the way out. 
% size of data: 40,040. solutions:
% divide into ten regions ( 2 x 5 ) train an autoencoder to reproduce (
% sans LBP TOP ) to reproduce the mouth region.CHECK
% 0) download viseme mapping CHECK
% 1) create training and validation and test sets according to the thesis.
% 2) ~15 classes ( visemes ) 
%   you should have examples of subjects saying a plethora of classes
%   (visemes) every sample will be a number of frames. (124 frames in every
%   video) every frame is 140*286
% 3) check and see if txt files are frames or seconds - need to convert
% into frames ( there is a function that converts time to frames ) 
% 4) for each viseme, extract only the corresponding frames. you'll end up
% having short sequences of visemes for each subject (cell array: each cell
% is a frame ) each example should be separate.make sure that the training
% examples are the same as the test examples. you want to make sure that
% all of them are in different folders so actually do this first. 
% 5) divide the sets of data into 2x5 regions of interest. they used a
% system to extract per frame and then also use a temporal model. even if
% you have something that works per frame, that can do something better
% than random. a second step can be putting a temporal model on top, and
% then as a third step, you could have another model that models the
% sequence of visemes. as a second experiment you could use this database
% you could recognise digits. 
% 6) ten autoencoders, one for each segment. you can reduce each segment
% from 4000 elements to something like 50 ( you can play with this ). Once
% you have 50, you can concatonate all of these, and make a 500 element
% array. then, you can use that in the classifier. but for now, the
% classifier is the second step. you can also experiment with the number of
% regions that you use. you need to decide if you take the pixels
% columnwise or rowwise, and you have to do this the same for every
% instance, and it must be converted into a vector.
% meet on friday and then wednesday. 
% for now, use default parameters. we'll discuss those in greater detail
% later.