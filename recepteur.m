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
signal = downsample(msg_noise,gam);
msg_length = ((lMsg+span)*beta);
t_cheby = R_os/2*(0:1:(msg_length-1))/msg_length; % -1 car on commence à 0

% 
% [b,a] = cheby1(10,0.5,300*2*pi,'low');
% figure('Name','freqs cheby')
% freqz(b,a,t_cheby*2*pi);

rc = (1000/R_os)*2;
[b,a] = cheby1(10,0.5,rc);
freqz(b,a)
dOut = filter(b,a,signal);



figure
subplot(2,2,1)
    [freq,amp]= fftplot(signal,R_os);
    plot(freq,amp) 
    title('Message original')
    xlabel('f (Hz)')
    ylabel('|P1(f)|')
    xlim([0, (N-0.5)*2*1000])
    grid minor
subplot(2,2,2)
    plot(signal)
subplot(2,2,3)
    [freq,amp]= fftplot(dOut,R_os);
    plot(freq,amp) 
    title('Message original')
    xlabel('f (Hz)')
    ylabel('|P1(f)|')
    xlim([0, (N-0.5)*2*1000])
    grid minor
subplot(2,2,4)
    plot(dOut)
    
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

