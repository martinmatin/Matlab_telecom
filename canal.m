%=== CANAL ===

%Att�nuation du canal par un param�tre Alpha
msg_att = msgDAC.*Att;
%Ajout de bruit blanc 
msg_noise = awgn(msg_att, noise_snr);
