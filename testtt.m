fc = 300;
fs = 1000;
t_cheby = /2*(0:1:(msg_length-1))/msg_length; % -1 car on commence à 0

[b,a] = butter(6,fc/(fs/2));
freqz(b,a)