% == RESULTATS == 

figure
% suptitle('Exo Télécom')
  subplot(2,2,1) % Le message de symboles
    stem(T,MSG_symb, '-.or')
    axis([-0.002 inf -1.5 1.5])
    title('Message')
    xlabel('xlabel')
    ylabel('ylabel')
    
    
  subplot(2,2,3)  % Les filtres FIR
    hold on 
        for freq = 1:N
            plot(tb, (f(freq,:).*b))
        end
    hold off
    grid
    xticks([-128 -64 0 64 128])
    axis([-128 128 -1 1])
    title('Filtre FIR')
    xlabel('xlabel')
    ylabel('ylabel')
    legend('y = label1','y = label2)','Location','northwest')
    
  subplot(2,2,2)  % Le message convolué avec le filtre FIR
    hold on
        for freq = 1:N
            if freq == 1
                yo = upfirdn(MSG_symb,(f(freq,:).*b),64);
                convFirMat = yo; % matrice avec l'ensemble des message convolués
                plot(yo)

            else 
                yo = upfirdn(MSG_symb,(f(freq,:).*b),64);
                convFirMat = [convFirMat;yo]; % matrice avec l'ensemble des message convolués
                plot(yo);
            end
        end
    hold off
    grid 
    title('Message convolué avec filtre FIR')
    xlabel('xlabel')
    ylabel('ylabel')
    legend('y = label1','y = label2)','Location','southwest')
     
  subplot(2,2,4)  % Le fft du message convulé
    hold on
        for freq = 1:N
            plot(abs(fft(convFirMat(freq,:)))) % Pour chaque canal, on prend l'absolu de la FFT.  
        end
    hold off
    title('FFT du message convolué')
    xlabel('xlabel')
    ylabel('ylabel')
    legend('y = label1','y = label2)','Location','north')