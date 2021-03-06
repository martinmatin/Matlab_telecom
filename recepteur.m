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


%On divise Fc par R_os car il s'agit de dire le poid par sample = Fc
%normalis�e
Fc = Fc./R_os.*2;

% => Pour le premier canal
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



%% D�modulation

fir_demod = bm_norm(1,:);

%On cr�e une matrice qiu contiendra tous les signaux d�modul�s
signal_demod = signal_sep;

for i =2:N
   signal_demod(:,i) = amdemod(signal_sep(:,i),f_coef(i),R_os);
end

%% Application filtre adapt�
signal_fir = conv2(fir_demod',1,signal_demod);
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
msg_sample= msg_final;

% figure
% plot(signal_fir)
for i=1:N
    % On construit les messages en fonction de la p�riode d'�chantillonnage
    % Beta
    
    msg_construct = signal_fir(start_sync:beta:start_sync+((lMsg-1)*beta),i);
    msg_sample(:,i) = msg_construct;
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
%Figure montrer codage sur signaux
% figure
%     %vecteur temps �chantillons
%     T_msg_sample = start_sync:beta:start_sync+((lMsg-1)*beta);
%     %vecteur temps messages
%     %T_msg = 0:T_os:length(signal_fir(
%     plot(signal_fir(:,2))
%     hold on
%     stem(T_msg_sample,msg_sample(:,2))
%     hold off
%     xlabel('Nombre �chantilllon')



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

%% Taux d'erreur binaire
%Calcul� pour le premier canal, msg under test
msg_ut = msg_final(:,1);
err = sum(xor(MSG',msg_ut))/length(MSG);


bnr_test = 10:-0.5:1;

bnr_result = [0,0,0,0,0,0,9.97e-05,9.9701e-05,1.9940e-04,1.99401e-04,0,1.9940e-04,7.976071784646061e-04, 0.001495513459621, 0.002293120638086,0.003688933200399,0.003589232303091,0.004386839481555,0.007178464606181];
bnr_val = [bnr_test' bnr_result']

%Courbe th�orique
% 
% t_pe = 1:0.1:10;
% pe=0.5*erfc(10.^sqrt(t_pe));
t = linspace(0, 10, 1e3);
    y = 1/2 * erfc(sqrt(10.^(t/10)));
figure
    semilogy(t,y)
    hold on
    plot(bnr_val (:,1), bnr_val (:,2), 'x', 'LineWidth', 2, 'MarkerSize',10);
    xlabel('Eb/N0 (dB)')
    ylabel('BER')


