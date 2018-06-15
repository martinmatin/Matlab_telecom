% === RESULTATS === 

%% Emetteur
% 
%% Message
% figure('Name','Message de base')
%     subplot(2,1,1)
%         stem(T,MSG,'-.or')
%         title('Message original')
%     subplot(2,1,2)
%         stem(T,MSG_symb,'-.or')
%         title('Message original avec PAM 2')
% figure ('Name','Message QAM')
%     subplot(2,1,1)
%         stem(T,MSG_symb, '-.or')
%         title('Message original avec PAM 2')
%     subplot(2,1,2)
%         stem(T_os,MSG_symb_os)
%          title('Message suréchantillonné par beta')

%% Convolution avec filtres


% figure('Name','Convolution')
%     subplot(2,2,1)
%         plot(bm_norm')
%         title('Filtre FIR')
%     subplot(2,2,2)
%         stem(msgConv')
%         title('Convolution du message et des filtres FIR')
%     subplot(2,2,3)
%         plot(msgDAC')
%         title('Sortie du message du ADC')
%     subplot(2,2,4)
%         fs = beta*R*gam;
%         [freq,amp]= fftplot(msg_noise,fs);
%         plot(freq,amp) 
%         title('Single-Sided Amplitude Spectrum of X(t)')
%         xlabel('f (Hz)')
%         ylabel('|P1(f)|')
%         xlim([0, (N-0.5)*2*1000])
%         grid minor
%         
        
%% Canal
figure('Name','Canal')
    plot(msgDAC')
    hold on
    plot(msg_noise')
    hold off
    
%% Filtrage
% figure('Name','Filtre de réception')
%     subplot(2,2,1)
%         [freq,amp]= fftplot(msg_noise,f_analog);
%         plot(freq,amp) 
%         title('Message original')
%         xlabel('f (Hz)')
%         ylabel('|P1(f)|')
%         xlim([0, (N-0.5)*2*1000])
%         grid minor
%     subplot(2,2,2)

%% Séparation des signaux plus autre chose

% figure
% subplot(2,2,1)
%     [freq,amp]= fftplot(s1,R_os);
%     plot(freq,amp) 
%     title('Signal original')
%     xlabel('f (Hz)')
%     ylabel('|P1(f)|')
%     xlim([0, (N-0.5)*2*1000])
%     grid minor
% subplot(2,2,2)
%      stem(signal_sep)
%      xlabel('Nombre échantillon')
% subplot(2,2,3)
%     for i = 1:N
%         
%         [freq,amp]= fftplot(signal_sep(:,i),R_os);
%         plot(freq,amp) 
%         hold on
%         title('Signaux séparés')
%         xlabel('f (Hz)')
%         ylabel('|P1(f)|')
%         xlim([0, (N-0.5)*2*1000])
%         grid minor
%     end
%     hold off
% subplot(2,2,4)
%     
%     
%     %plot(tt,signal_mod',ttt,wwtt,'o')
%     plot(signal_fir)

%% Démodulation et filtrage idéal

figure('Name','SEP')
    subplot(3,1,1)
    plot(signal_sep)
    subplot(3,1,2)
    plot(signal_demod)
    subplot(3,1,3)
    plot(signal_fir)
    
 