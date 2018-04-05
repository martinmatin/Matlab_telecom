% === Message original ===
MSG = [Ms, randi([0 1],1,Md)]; % Contenu du message
T = 0:Tb:Tb*(length(MSG)-1);  % Ligne du temps définissant l'apparition de chaque bit

% === Message en symboles ===
MSG_symb = 2*MSG -1 % Codage des bits en symboles, si 0 --> -1, si 1 -->- +1


% % figures des messages
%     subplot(2,1,1)
%     stairs(T,MSG)
%     axis([-inf inf -1.5 1.5])
% 
%     subplot(2,1,2)
%     stairs(T,MSG_symb, '-.or')
%     axis([-inf inf -1.5 1.5])

% === Cosinus surélevé ===
b = rcosdesign(rolloff, span, sps);
figure
    subplot(2,1,1)
        stem(b)
    subplot(2,1,2)
        stem(fft(b))

