prompt = 'T = '; % final time
T = input(prompt);

prompt = 'Order of Space Derivative = '; % 2nd or 4th?
OrderofSpaceDerivative = input(prompt, 's');

disp('P  L1-error     L2-error     L_inf-error  ratio-1   ratio-2   ratio-3');

P = 0; % P in 2 ^ P * 100, number of grids
Q = ODE_system(P, T, OrderofSpaceDerivative); 

for k = 1 : 5
    
    P = P + 1;
    HQ = ODE_system(P, T, OrderofSpaceDerivative);
    
    dx = 2 * (5 - (-5)) / (2 ^ P * 100);

    diff = abs(Q - HQ(1 : 2 : end));
    diff = diff(2 : end);
    
    L1err = sum(diff) * dx;
    L2err = sqrt(sum(diff .^ 2) * dx);
    Linferr = max(diff);

    if k == 1

        row = [P L1err L2err Linferr];
        fprintf('%d  %0.8f   %0.8f   %0.8f\n', row);

    else
        
        ratio1 = former_L1err / L1err; 
        ratio2 = former_L2err / L2err;
        ratio3 = former_Linferr / Linferr;
        row = [P L1err L2err Linferr ratio1 ratio2 ratio3];
        fprintf('%d  %0.8f   %0.8f   %0.8f   %0.2f      %0.2f      %0.2f\n', row);

    end

    Q = HQ;
    former_L1err = L1err;
    former_L2err = L2err;
    former_Linferr = Linferr;

end 