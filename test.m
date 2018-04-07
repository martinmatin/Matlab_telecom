W = 4*pi*1*(1/Tb);
x = linspace(0,2*Tb);
y1 = sin(x);
y2 = cos((pi/Tb)*3*x);


figure
plot(x,y1,x,y2)