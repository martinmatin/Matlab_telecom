% === Message original ===
MSG = [Ms, randi([0 1],1,Md)]; % Contenu du message
T = 0:Tb:Tb*(length(MSG)-1);  % Ligne du temps d�finissant l'apparition de chaque bit

% === Message en symboles ===
MSG_symb = 2*MSG -1; % Codage des bits en symboles, si 0 --> -1, si 1 -->- +1


% figures des messages
%     subplot(2,1,1)
%     stairs(T,MSG)
%     axis([-0.002 inf -1.5 1.5])
% 
%     subplot(2,1,2)
%     stem(T,MSG_symb, '-.or')
%     axis([-0.002 inf -1.5 1.5])

% === Cosinus sur�lev� ===
b = rcosdesign(rolloff,span,sps,'normal');  % la fonction rcos
b = b/max(b);  % la fonction ramen�e � 1
f = [0:N-1]
f = f*((pi/Tb)*4*2)

tb = -128:1:128; 
tc = -Tb:(2*Tb)/(length(tb)-1):Tb;
c = cos(f(2)*tc);
f(2)
b1 = c.*b;

figure
        stem(tb, b1)
        hold on
        stem(tb, b)
        grid
        xticks([-128 -64 0 64 128])
        axis([-128 128 -1.5 1.5])
        
        
    %subplot(2,1,2)
        