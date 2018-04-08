% === Message original ===
MSG = [Ms, randi([0 1],1,Md)]; % Contenu du message
T = 0:Tb:Tb*(length(MSG)-1);  % Ligne du temps d�finissant l'apparition de chaque bit

% === Message en symboles ===
MSG_symb = 2*MSG -1; % Codage des bits en symboles, si 0 --> -1, si 1 -->- +1



% === Cosinus sur�lev� ===
b = rcosdesign(rolloff,span,sps,'normal');  % la fonction rcos
b = b/max(b);  % la fonction ramen�e � 1

tb = -128:1:128; 
tc = -Tb:(2*Tb)/(length(tb)-1):Tb;

% === Les porteuses ===
f = [0:N-1]; % Vecteur de 0 �  N-1
f = f*((pi/Tb)*4);  %Omega, coefficients des porteuses 
f = cos(f'.*tc) % Matrices de porteuses
     
figure
  subplot(2,2,1) % Le message de symboles
    stem(T,MSG_symb, '-.or')
    axis([-0.002 inf -1.5 1.5])
  subplot(2,2,3)  % Les filtres FIR
    hold on 
        for freq = 1:N
            plot(tb, (f(freq,:).*b))
        end
    hold off
    grid
    xticks([-128 -64 0 64 128])
    axis([-128 128 -1 1])
  subplot(2,2,2)  % Le message convolu� avec le filtre FIR
    hold on
        for freq = 1:N
            if freq == 1
                yo = upfirdn(MSG_symb,(f(freq,:).*b),64);
                convFirMat = yo; % matrice avec l'ensemble des message convolu�s
                plot(yo)

            else 
                yo = upfirdn(MSG_symb,(f(freq,:).*b),64);
                convFirMat = [convFirMat;yo]; % matrice avec l'ensemble des message convolu�s
                plot(yo);
            end

        end

    hold off
  subplot(2,2,4)  % Le fft du message convul�
    hold on
        for freq = 1:N
            plot(abs(fft(convFirMat(freq,:))))
        end
    hold off

