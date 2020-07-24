prompt = 'w = ';
theta = input(prompt);

prompt = 'X-range = ';
X_range = input(prompt);

prompt = 'Y-range = ';
Y_range = input(prompt);

prompt = 'Order of Space Derivative = '; % 2nd or 4th?
OrderofSpaceDerivative = input(prompt, 's');

disp('dx        L1-error     L2-error     L_inf-error  ratio-1   ratio-2   ratio-3');

dx = 2;
wave = LSWE(dx, theta, X_range, Y_range, OrderofSpaceDerivative);

for k = 1 : 4
   
    dx = dx / 2;
    Hwave = LSWE(dx, theta, X_range, Y_range, OrderofSpaceDerivative);
   
    diff = abs(Hwave(1 : 2 : end, 1 : 2 : end) - wave);
    diff = diff(2 : end, 2 : end); 
    
    L1err = sum(sum(diff)) * (dx * 2) ^ 2; % dy = dx
    L2err = sqrt(sum(sum(diff .^ 2))) * (dx * 2);
    Linferr = max(max(diff));
    
    if k == 1
        
        row = [dx L1err L2err Linferr];
        fprintf('%0.5f   %0.8f   %0.8f   %0.8f\n', row);
        
    else
        
        ratio1 = former_L1err / L1err;
        ratio2 = former_L2err / L2err;
        ratio3 = former_Linferr / Linferr;
        
        row = [dx L1err L2err Linferr ratio1 ratio2 ratio3];
        fprintf('%0.5f   %0.8f   %0.8f   %0.8f   %0.5f   %0.5f   %0.5f\n', row);
        
    end
    
    wave = Hwave;
    former_L1err = L1err;
    former_L2err = L2err;
    former_Linferr = Linferr;
     
end