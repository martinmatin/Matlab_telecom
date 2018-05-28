%% === Message original ===
% Message avec la séquence de démarrage
MSG = [Ms, randi([0 1],1,Md)];
% Vecteur temps pour les messages 
T = 0:Tb:Tb*(length(MSG)-1);  

%Codage PAM
MSG_symb = 2*MSG -1; % Codage des bits en symboles, si 0 --> -1, si 1 -->- +1
%Suréchantillonnage Msg
MSG_symb_os = upsample(MSG_symb, beta); % over sample
% Vecteur temps pour les messages suréchantillonnés 
T_os = 0:Tb_os:Tb_os*((length(MSG)*beta)-1);  

% === Cosinus surélevé ===
% Filtre fir
b = rcosdesign(roll,span,beta,'normal');

%vecteur temps pour le filtre FIR
t_fir = -Tb*L:Tb_os:Tb*L;
        

%% Modulation

tb = -128:1:128; % a supprimer

% === Les porteuses ===
f = [0:N-1]; % Vecteur de 0 à  N-1
rad_coef = f*(4*pi*(1/Tb));  % coefficients des porteuses  en rad
f_coef = rad_coef.*(1/(2*pi)); % coefficients des porteuses  en Hertz
f = cos(rad_coef'.*t_fir); % Matrices de porteuses


%Matrice des FIR modulés en amplitude selon la fréquence
bm = f.*b;

%% Normalisatoin 
% On met l'ensemble des points au carré
bm_2 = bm.^2;
% On somme chaque vecteurs
bm_2_sum = sum(bm_2');
% On divise par beta
bm_2_sum_beta = bm_2_sum./beta;
% On prend la racine carré et on obtient une matrice avec les facteurs de
% normalisation
bm_facteur = sqrt(bm_2_sum_beta');
%On divise chaque ligne par le facteur correspondant
bm_norm = bm./bm_facteur;


%% Convolution
msgConv = conv2(1,MSG_symb_os,bm_norm);

%% DAC
%Vecteur temps DAC. 
%Nombre de symbole * nbr sample par symb * suréchantilonnage gamma ADC
% msg_length = ((lMsg+span)*beta*gam);
% Sortie = somme des intérpolations
msgDAC = sum(interpft(msgConv,((lMsg+span)*beta*gam),2));

%% 
