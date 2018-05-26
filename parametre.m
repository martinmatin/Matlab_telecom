% Ensemble des paramètres caractérisant le canal

% == EMETTEUR == 

Ms = [1,0,1,0]; % bits, nombre de bits de la séquence pilote d'une trame
Md = 1; % nombre de bits de données dans une trame
lMsg = length(Ms)+Md; % Longueuur d'une trame
R = 1000; % bits/s, débit binaire
Tb = 1/R; % secondes par bit 
N = 3; % Nombre de canaux
K = 4; % Nombre de modules sur le réseau


Zc = 50; %Ohms pour une ligne coaxiale
P = 0.020; % Puissance voulue en Watt par canal

U = sqrt(P*Zc); % Tension nécessaire sur le canal pour respecter la puissance voulue

G = U ; % Le gain d'amplification du signal = la tension car de base on a une tension de 1


 

%Generate the square-root, raised cosine filter coefficients.
roll = 0.4;     % Rolloff factor, appelé Alpha = facteur de descente
span = 8;           % Filter span in symbols, 
beta = N*4;            % Samples per symbol, surénchantillonnage
L= span/2;         % troncage. Il y a un facteur 2 entre rcosfir et rcosdesign

R_os = beta*R;  % Fréquence de suréchantillonnage
Tb_os = 1/R_os;
gam = N*10; % Suréchantillonnage ADC
f_analog = beta*gam*R;

if beta < (4*N-2)
    error('Erreur dans le choix du paramètre Beta, il doit être sup. ou égal à (4*N)-2')
end


%=== CANAL ===
Att = 0.9; % atténuation du signal du au canal
noise_snr = 17; % Puissance du bruit déterminé par le signal/noise ratio

%===Filter ===
filter_order = 10;