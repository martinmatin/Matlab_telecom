%=== CANAL ===

%Atténuation du canal par un paramètre Alpha
msg_att = msgDAC.*Att;
%Ajout de bruit blanc 
msg_noise = awgn(msg_att, noise_snr);

% % vecteur temps
% t_analog = 1/f_analog;
% T_canal = 0:t_analog:(length(msgDAC)-1)*t_analog;
% figure
%     plot(T_canal,msgDAC)
%     hold on
%     plot(T_canal,msg_noise)
%     hold off
%     ylabel('Amplitude')
%     xlabel('Temps (s)')
%     legend('Signal original','Signal atténue avec bruit blanc')