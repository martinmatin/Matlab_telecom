function [fHz,P1] = fftplot(signal,fs)
    Ln = length(signal);
    Y = fft(signal);
    P2 = abs(Y/Ln);
    P1 = P2(1:Ln/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    fHz = fs*(0:(Ln/2))/Ln;
end

