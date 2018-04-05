% Ensemble des paramètres caractérisant le canal

% == EMETTEUR == 


Ms = [1,0,1,1,0]; % bits, nombre de bits de la séquence pilote d'une trame
Md = 10; % nombre de bits de données dans une trame
R = 1000; % bits/s, débit binaire
Tb = 1/R; % secondes par bit 
N = 4; % Nombre de canaux
K = 4; % Nombre de modules sur le réseau
B = 16; % Beta, facteur multiplicateur de suréchantillonnage, doit être sup. ou égal à (4*N)-2
L = 2; % Longeur

if B < (4*N-2)
    error('Erreur dans le choix du paramètre Beta, il doit être sup. ou égal à (4*N)-2')
end

%Generate the square-root, raised cosine filter coefficients.
rolloff = 0.4;     % Rolloff factor, appelé Alpha = facteur de descente
span = L;           % Filter span in symbols, 
sps = 64/Tb;            % Samples per symbol, cadence
