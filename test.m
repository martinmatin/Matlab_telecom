A = [1,2,3,4,5,6];

B = [1,4,9,10,12,17];

C = [1,2,5,6];

D = [1,3,4,5]

figure
    subplot(2,1,1)
        plot(B,A)
        xlim([0,20])
    subplot(2,1,2)
        plot(D,C)
        xlim([0,20])