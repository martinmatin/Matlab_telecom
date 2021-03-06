close all;


%% Declarations


fs = 64000; %sampling rate
fc = 500; % Fr�quence de coupure

n = 4; % Ordre du filtre


%% Preparation


%% Filtering Stage
Wn = fc/(fs/2); 
[b,a] = butter(n, Wn);
% filteredSignal = filter(b, a, canalOut(1,:));

figure(2)
freqz(b,a,length(FreqAxis),fs);



%% Plotting

figure(1)
subplot(3,1,1)
plot(FreqAxis, abs(fftshift(fft(canalOut(1,:)))))
title('Signal original')
xlim([0 2000])
grid minor

subplot(3,1,2)
plot(FreqAxis, abs(fftshift(fft(filteredSignal))))
title('Signal flitr�')
xlim([0 2000])
grid minor

subplot(3,1,3)
% plot(FreqAxis, abs(h))
% title('Signal')
% xlim([0 2000])
plot(mag2db(f));%,length(FreqAxis),fs);
grid minor


