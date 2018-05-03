% === Message original ===
MSG = [Ms, randi([0 1],1,Md)]; % Contenu du message
T = 0:Tb:Tb*(length(MSG)-1);  % Vecteur temps pour les messages 

% === Message en symboles ===
MSG_symb = 2*MSG -1; % Codage des bits en symboles, si 0 --> -1, si 1 -->- +1

% === Cosinus sur�lev� ===
b = rcosdesign(rolloff,span,sps,'normal');  % la fonction rcos
b = b/max(b);  % la fonction ramen�e � 1

tb = -128:1:128; 
tc = -Tb:(2*Tb)/(length(tb)-1):Tb; %vecteur 

% === Les porteuses ===
f = [0:N-1]; % Vecteur de 0 �  N-1
f = f*((2/Tb));  % coefficients des porteuses 
f = cos(2*pi.*f'.*tc); % Matrices de porteuses

% == Sortie Emetteur ==
figure('Name','Sortie Emetteur')
% suptitle('Exo T�l�com')
  subplot(2,2,1) % Le message de symboles
    stem(T,MSG_symb, '-.or')
    axis([-0.002 inf -1.5 1.5])
    title('Message')
    xlabel('xlabel')
    ylabel('ylabel')
    
    
  subplot(2,2,3)  % Les filtres FIR
    hold on 
        for freq = 1:N
            plot(tb, (f(freq,:).*b))
        end
    hold off
    grid
    xticks([-128 -64 0 64 128])
    axis([-128 128 -1 1])
    title('Filtre FIR')
    xlabel('xlabel')
    ylabel('ylabel')
    legend('y = label1','y = label2)','Location','northwest')
    
  subplot(2,2,2)  % Le message convolu� avec le filtre FIR
    hold on
        for freq = 1:N
            if freq == 1 % Je fais la premi�re fr�quence diff�rement des autres pour cr�er la matrice de messages convolu�s,
                yo = upfirdn(MSG_symb,(f(freq,:).*b),64); 
                yo = yo*G;
                convFirMat = yo; % matrice avec l'ensemble des message convolu�s, on multiplie chaque fois le signal avec le gain
                plot(yo);
                plot(ones(size(yo)) * G);

            else 
                yo = upfirdn(MSG_symb,(f(freq,:).*b),64);
                yo = yo*G;
                convFirMat = [convFirMat;yo]; % matrice avec l'ensemble des message convolu�s
                plot(yo);
            end
        end
    hold off
    grid 
    title('Message convolu� avec filtre FIR')
    xlabel('xlabel')
    ylabel('Volts')
    legend('y = label1','y = label2)','Location','southwest')
     
  subplot(2,2,4)  % Le fft du message convul�
    hold on
        for freq = 1:N
            NSamples = length(convFirMat(freq,:));
            fftEmetteur = fft(convFirMat(freq,:)); 
            fftEmetteur = abs(fftEmetteur)/numel(fftEmetteur);
            %FreqAxis = NSamples/2*linspace(-1,1,NSamples);
            Fs = R*sps;
            stem(fftEmetteur(1:Fs));
            grid minor
            
            
        end
    hold off
    title('FFT du message convolu�')
    xlabel('xlabel')
    ylabel('ylabel')
    legend('y = label1','y = label2','Location','northwest')
   
    
% == Sortie canal ===