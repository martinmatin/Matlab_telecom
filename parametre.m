% Ensemble des param�tres caract�risant le canal

% == EMETTEUR == 


Ms = [1,0,1,1,0]; % bits, nombre de bits de la s�quence pilote d'une trame
Md = 10; % nombre de bits de donn�es dans une trame
R = 1000; % bits/s, d�bit binaire
Tb = 1/R; % secondes par bit 
N = 4; % Nombre de canaux
K = 4; % Nombre de modules sur le r�seau
B = 16; % Beta, facteur multiplicateur de sur�chantillonnage, doit �tre sup. ou �gal � (4*N)-2
L = 2; % Longeur

if B < (4*N-2)
    error('Erreur dans le choix du param�tre Beta, il doit �tre sup. ou �gal � (4*N)-2')
end

%Generate the square-root, raised cosine filter coefficients.
rolloff = 0.4;     % Rolloff factor, appel� Alpha = facteur de descente
span = L;           % Filter span in symbols, 
sps = 64/Tb;            % Samples per symbol, cadence
