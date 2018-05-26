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
%vecteur temps 
t_cheby = f_analog/2*(0:1:(msg_length-1))/msg_length; % -1 car on commence à 0


[b,a] = cheby1(15,0.5,50000,'low','s');


[d,c] = cheby1(10,0.05,Fc(1,:),'bandpass','s');

www = ifft(abs(freqs(b,a,t_cheby*2*pi)),'symmetric'); % Du ajouté 2 pi je sais pas pq
% wwww = conv(msg_noise,www)
wwww = conv2( 1,msg_noise, www);

figure
subplot(3,1,1)
    [freq,amp]= fftplot(msg_noise,f_analog);
    plot(freq,amp) 
    title('Message original')
    xlabel('f (Hz)')
    ylabel('|P1(f)|')
    xlim([0, (N-0.5)*2*1000])
    grid minor
subplot(3,1,2)
    plot(t_cheby*2*pi,abs(freqs(b,a,t_cheby*2*pi)))
    xlim([0 (N-0.5)*2*1000]);
    ylim([0 1.5])
    
    hold on 
    plot(t_cheby,abs(freqs(d,c,t_cheby)))
    hold off
subplot(3,1,3)
    [freqC,ampC]= fftplot(wwww,f_analog);
    plot(freqC,ampC) 

figure
    plot(wwww)
    hold on 
    plot(msg_noise)
    hold off
%% Réponse impulsionnelle
% For nearly conjugate symmetric vectors, you can compute the inverse
% Fourier transform faster by specifying the 'symmetric' option, which also
% ensures that the output is real. --> Donc pas besoin de mettre real
% devant

