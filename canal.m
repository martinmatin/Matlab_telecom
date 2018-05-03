

%=== CANAL ===
canalOut = convFirMat*(1-alpha); % Sortie emetteur avec atténuation

WhiteNoise = randn(1, 10000); % Bruit blanc
lpFilt = designfilt('lowpassiir','FilterOrder',8,'PassbandFrequency',(2*N)/Tb,'PassbandRipple',0.8,'SampleRate',200e3);
WhiteNoise = filter(lpFilt, abs(WhiteNoise)); % bruit blanc filtré

figure('Name','Canal')
subplot(2,2,1)

    canalOut = sum(canalOut);
    plot(canalOut)
    
subplot(2,2,2)
    plot(abs(fft(WhiteNoise)))

subplot(2,2,3)
    plot(abs(fft(canalOut)))
    
subplot(2,2,4)
    plot(abs(fft(WhiteNoise)))
    
% shifted_data = delayseq(convFirMat(:,:)',250);
% 
% figure
% plot(shifted_data)

