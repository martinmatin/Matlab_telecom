%=== CANAL ===

%Atténuation du canal par un paramètre Alpha
msg_att = msgDAC.*Att;
%Ajout de bruit blanc 
msg_noise = awgn(msg_att, noise_snr);
