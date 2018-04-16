Ms = [1,0,1,1,0];
O = Ms.*ones(N,1);
Q = [O,randi([0 1],N,Md)];
Q = 2*Q-1