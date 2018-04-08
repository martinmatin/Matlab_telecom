% Ensemble des paramètres caractérisant le canal

% == EMETTEUR == 


Ms = [1,0,1,1,0]; % bits, nombre de bits de la séquence pilote d'une trame
Md = 4; % nombre de bits de données dans une trame
R = 1000; % bits/s, débit binaire
Tb = 1/R; % secondes par bit 
N = 4; % Nombre de canaux
K = 4; % Nombre de modules sur le réseau



%Generate the square-root, raised cosine filter coefficients.
rolloff = 0.4;     % Rolloff factor, appelé Alpha = facteur de descente
span = 4;           % Filter span in symbols, 
sps = 64;            % Samples per symbol, surénchantillonnage
if sps < (4*N-2)
    error('Erreur dans le choix du paramètre Beta, il doit être sup. ou égal à (4*N)-2')
end
