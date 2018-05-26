% A utiliser pour la génération de bruit :
https://stackoverflow.com/questions/41091218/lowpass-butterworth-filtering-on-matlab

% The noise you add with rand() has a uniform distribution in the range (0,1),
% which offsets the input on average by 0.5. For an unbiased noise you might 
% want to use either (2*rand(...)-1) (uniform distribution in the range (-1,1)) 
% or randn(...) (Gaussian distribution).