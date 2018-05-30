% == RECEPTEUR == 

%% Fréquence de coupure -
% Calcul de la bande passante
bp = (1 + roll )/(2*Tb);

% Génération d'une matrice contenant N fois la bande passante
Fc = repmat([-bp,bp],N-1,1);
% On additionne cette matrice avec les porteuses correspondantes. Pour
% rappel, la matrice avec les porteuses en Hz se nomme "f_coef"
% On obtient un matrice avec les fréquences de coupure sauf pour la bande de base
Fc = bsxfun(@plus,Fc,f_coef(2:N)');


%% Génération des filtres

% Diminution du sampling
s1 = downsample(msg_noise,gam)';


%On divise Fc par R_os car il s'agit de dire le poid par sample
Fc = Fc./R_os.*2;

% => Pour le premier cana
% On définit la fréquence de coupure
rca = (bp/R_os)*2;
% On créer les coefficients du filtre 
[b,a] = cheby1(10,0.5,rca);
%Réponse temporelle
filter_low = ifft(freqz(b,a,filter_lg,'Whole',R_os));
%création d'une matrice de filtre à partir de ce filtre pour pouvoir ajoute
%les filtres des autres canaux
filter_mat = repmat(filter_low,1,N);

for i= 2:N   
    [b,a] = cheby1(10,0.5,Fc(i-1,:));
    filter_mat(:,i) = ifft(freqz(b,a,filter_lg,'Whole',R_os));
end
% On convolue pour séparer les canaux
s2 = conv2(s1,1,filter_mat);




figure
subplot(2,2,1)
    [freq,amp]= fftplot(s1,R_os);
    plot(freq,amp) 
    title('Message original')
    xlabel('f (Hz)')
    ylabel('|P1(f)|')
    xlim([0, (N-0.5)*2*1000])
    grid minor
subplot(2,2,2)
     plot(msgConv')
subplot(2,2,3)
    for i = 1:N
        
        [freq,amp]= fftplot(s2(:,i),R_os);
        plot(freq,amp) 
        hold on
        title('Message original')
        xlabel('f (Hz)')
        ylabel('|P1(f)|')
        xlim([0, (N-0.5)*2*1000])
        grid minor
    end
    hold off
subplot(2,2,4)
    stem(s2)
    
% 
% rate = f_analog;
% freq = 3000;

% fc = 300;
% fs = 1000;
% 
% [b,a] = butter(6,fc/(fs/2));
% freqs(b,a)
% % fc = 300;
% % fs = 10000;
% 
% 
% 
% fvtool(b,a)
% 
% [d,c] = cheby1(10,0.05,Fc(1,:),'bandpass','s');
% 
% www = ifft(abs(freqs(b,a,t_cheby*2*pi)),'symmetric'); % Du ajouté 2 pi je sais pas pq
% % wwww = conv(msg_noise,www)
% wwww = conv2( 1,msg_noise, www);

% figure
% subplot(3,1,1)
%     [freq,amp]= fftplot(msg_noise,f_analog);
%     plot(freq,amp) 
%     title('Message original')
%     xlabel('f (Hz)')
%     ylabel('|P1(f)|')
%     xlim([0, (N-0.5)*2*1000])
%     grid minor
% subplot(3,1,2)
%     plot(t_cheby*2*pi,abs(freqs(b,a,t_cheby*2*pi)))
%     xlim([0 (N-0.5)*2*1000]);
%     ylim([0 1.5])
%     
%     hold on 
%     plot(t_cheby,abs(freqs(d,c,t_cheby)))
%     hold off
% subplot(3,1,3)
%     [freqC,ampC]= fftplot(y,f_analog);
%     plot(freqC,ampC) 
% 
% figure
%     plot(y)
%     hold on 
%     plot(msg_noise)
%     hold off
%% Réponse impulsionnelle
% For nearly conjugate symmetric vectors, you can compute the inverse
% Fourier transform faster by specifying the 'symmetric' option, which also
% ensures that the output is real. --> Donc pas besoin de mettre real
% devant

