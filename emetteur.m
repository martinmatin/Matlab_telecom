% === Message original ===
MSG = [Ms, randi([0 1],1,Md)]; % Contenu du message
T = 0:Tb:Tb*(length(MSG)-1);  % Vecteur temps pour les messages 

% === Message en symboles ===
MSG_symb = 2*MSG -1; % Codage des bits en symboles, si 0 --> -1, si 1 -->- +1

% === Cosinus surélevé ===
b = rcosdesign(rolloff,span,sps,'normal');  % la fonction rcos
b = b/max(b);  % la fonction ramenée à 1

tb = -128:1:128; 
tc = -Tb:(2*Tb)/(length(tb)-1):Tb; %vecteur 

% === Les porteuses ===
f = [0:N-1]; % Vecteur de 0 à  N-1
f = f*((pi/Tb)*4);  %Omega, coefficients des porteuses 
f = cos(f'.*tc) % Matrices de porteuses