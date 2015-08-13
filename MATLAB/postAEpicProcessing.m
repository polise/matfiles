test_1 = reshape(test_x(20,:),60,80); % change number
test_2 = reshape(outputAE(20,:),60,80); 

% subplot(1,2,1),imshow(test_1);
% subplot(1,2,2),imshow(test_2);

ChangeFigure     = figure;
subplot(1,2,1), imshow(test_1);  subplot(1,2,2), imshow(test_2);
%title('Original and Recreated Image Through Use of AutoEncoder');
% AxesH    = findobj(FigH, 'Type', 'Axes');
% XLabelHC = get(AxesH, 'Original ** Autoencoder');
% XLabelH  = [XLabelHC{:}];
% set(XLabelH, 'String', 'No Epochs: RBM: 10, NN: 20')
% TitleHC  = get(AxesH, 'Original and Recreated Image Through Use of Autoencoder');
% TitleH   = [TitleHC{:}];
% set(TitleH, 'String', 'The title');