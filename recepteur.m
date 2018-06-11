% == RECEPTEUR == 

%% Fr�quence de coupure -
% Calcul de la bande passante
bp = (1 + roll )/(2*Tb);

% G�n�ration d'une matrice contenant N fois la bande passante
Fc = repmat([-bp,bp],N-1,1);
% On additionne cette matrice avec les porteuses correspondantes. Pour
% rappel, la matrice avec les porteuses en Hz se nomme "f_coef"
% On obtient un matrice avec les fr�quences de coupure sauf pour la bande de base
Fc = bsxfun(@plus,Fc,f_coef(2:N)');


%% G�n�ration des filtres

% Diminution du sampling
s1 = downsample(msg_noise,gam)';


%On divise Fc par R_os car il s'agit de dire le poid par sample
Fc = Fc./R_os.*2;

% => Pour le premier cana
% On d�finit la fr�quence de coupure
rca = (bp/R_os)*2;
% On cr�er les coefficients du filtre 
[b,a] = cheby1(10,0.5,rca);

% Pour plotter les filtres
% figure
%     freqz(b,a,filter_lg,R_os)
%     hold on

%R�ponse temporelle
filter_low = ifft(freqz(b,a,filter_lg,'Whole',R_os));
%cr�ation d'une matrice de filtre � partir de ce filtre pour pouvoir ajoute
%les filtres des autres canaux
filter_mat = repmat(filter_low,1,N);

for i= 2:N   
    [b,a] = cheby1(10,0.5,Fc(i-1,:));
    
    filter_mat(:,i) = ifft(freqz(b,a,filter_lg,'Whole',R_os));
end
%% S�paration des canaux
% On convolue pour s�parer les canaux
signal_sep = conv2(s1,1,filter_mat);
bm_test = bm_norm';
signal_demod = signal_sep;
%cr�ation d'une matrice
%% D�modulation

for i =2:N
   signal_demod(:,i) = amdemod(signal_sep(:,i),f_coef(i),R_os);
end

signal_fir = conv2(bm_test(:,1),1,signal_demod);
signal_fir = signal_fir/7;


%% Cor�lation
% On g�n�re la s�quence de base d�marrage pour voir o� commence le message
msg_start = 2*Ms-1;
msg_start = upsample(msg_start, beta);
% On convolue avec le fir
msg_start_fir = conv(msg_start,bm(1,:));

% D�terminer o� commencer � l'aide de la corr�lation
[r, lags] = xcorr(msg_start_fir,signal_fir(:,1));
[max_r, index_max_r]=max(r);
start_ind = lags(index_max_r);
start_sync = abs(start_ind)+((L)*beta)+1;

%% Construction des messages �chantillonn�s Beta
% Construction d'une matrice qui accueilla les messages
msg_final = zeros(lMsg,N);
figure
plot(signal_fir)
for i=1:N
    % On construit les messages en fonction de la p�riode d'�chantillonnage
    % Beta
    i
    msg_construct = signal_fir(start_sync:beta:start_sync+((lMsg-1)*beta),i);
    % Le message est pass� dans l'algorithme de d�cision
    for j=1:length(msg_construct)
        
        if msg_construct(j)> 0
            msg_construct(j)=1;
        else
            msg_construct(j)=0;
        end
    end
    msg_final(:,i) = msg_construct;
end    
msg_final
% figure
%     subplot(3,1,1)
%     stem(T,MSG_symb, '-.or')
%     subplot(3,1,2)
%     stem(msg_construct)
%     subplot(3,1,3)
%     plot(signal_fir)


%% R�ponse impulsionnelle
% For nearly conjugate symmetric vectors, you can compute the inverse
% Fourier transform faster by specifying the 'symmetric' option, which also
% ensures that the output is real. --> Donc pas besoin de mettre real
% devant

