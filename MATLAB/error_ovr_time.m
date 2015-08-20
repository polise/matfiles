figure;

        plot(1:nn.epochs,L,1:nn.epochs,L_val);
        title('Loss Displayed Over Time');
        ylabel('Loss');
        xlabel('Epochs');
        legend('Training Set', 'Test Set');
    
        