function wave = LSWE(dx, theta, X_range, Y_range, OrderofSpaceDerivative)

    h0 = 3;
    g = 9.8 * 10 ^ (-3);
    s0 = h0 * g;
    speed = sqrt(s0);

    dy = dx; 
    xa = X_range(1);
    xb = X_range(2);
    ya = Y_range(1);
    yb = Y_range(2);
    [X, Y] = meshgrid(xa : dx : xb, ya : dy : yb);

    l = 30;
    q1 = exp(- (cos(theta) * X + sin(theta) * Y) .^ 2 / (2 * l ^ 2));

    q2 = zeros(size(q1));
    q3 = zeros(size(q1));

    q(:, :, 1) = q1;
    q(:, :, 2) = q2;
    q(:, :, 3) = q3;

    dt = dx / speed; % CFL modification
    T = 3 * l / speed;
    N = floor(T / dt);

    switch OrderofSpaceDerivative

        case '2nd'

            for i = 1 : N

                Y1 = q;
                Y2 = q + 1/2 * dt * func(Y1, dx, dy, s0);
                Y3 = q + 1/2 * dt * func(Y2, dx, dy, s0);
                Y4 = q + dt * func(Y3, dx, dy, s0);

                q_Next = q + 1/6 * dt * (func(Y1, dx, dy, s0) + 2 * func(Y2, dx, dy, s0) + 2 * func(Y3, dx, dy, s0) + func(Y4, dx, dy, s0));

                q = q_Next;

            end

        case '4th'

            for i = 1 : N

                Y1 = q;
                Y2 = q + 1/2 * dt * Hfunc(Y1, dx, dy, s0);
                Y3 = q + 1/2 * dt * Hfunc(Y2, dx, dy, s0);
                Y4 = q + dt * Hfunc(Y3, dx, dy, s0);

                q_Next = q + 1/6 * dt * (Hfunc(Y1, dx, dy, s0) + 2 * Hfunc(Y2, dx, dy, s0) + 2 * Hfunc(Y3, dx, dy, s0) + Hfunc(Y4, dx, dy, s0));

                q = q_Next;

            end

    end        
    
    wave = q(:, :, 1) + h0;
    
    subplot(1, 2, 1)
    
    surf(X, Y, q1 + h0, 'EdgeColor', 'None')
    title('\fontsize{12}{\it h} at {\it t = 0}')
    
    zlim([3 4])    
    caxis manual
    caxis([3 4]);
    rotate3d on;

    subplot(1, 2, 2)
        
    surf(X, Y, wave, 'EdgeColor', 'None')   
    title('\fontsize{12}{\it h} at {\it t = 3l/s_0}')
    
    zlim([3 4])
    caxis manual
    caxis([3 4]);
    rotate3d on;
    
    %colorbar;
    
    set(gcf, 'Units', 'Inches', 'Position', [0, 0, 20, 5], 'PaperUnits', 'Inches', 'PaperSize', [20, 5])
    
end