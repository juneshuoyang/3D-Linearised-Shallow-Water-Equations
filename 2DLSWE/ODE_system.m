function wave = ODE_system(p, T, OrderofSpaceDerivative)

    turb = @(x) 0.4 * exp(- (x * 2) .^ 2);    
    h0 = 1;

    %

    c0 = 1;

    R = [1 1; -c0 c0];
    Rinv = inv(R);

    lambda = [-c0; c0];

    %

    m = 2 ^ p * 100 + 1;
    dx = (5 - (-5)) / (m - 1); 

    xs = linspace(-5, 5, m);
    q1 = turb(xs);
    q2 = zeros(1, m);
    q = [q1; q2];
    w = Rinv * q;

    %

    dt = 1 * dx / c0; % CFL modification
    N = floor(T / dt);

    %

    switch OrderofSpaceDerivative

        case '2nd'

            for i = 1 : N
            
                Y1 = w;
                Y2 = w + 1/2 * dt * func(Y1, dx, lambda);
                Y3 = w + 1/2 * dt * func(Y2, dx, lambda);
                Y4 = w + dt * func(Y3, dx, lambda);
                w_Next = w + 1/6 * dt * (func(Y1, dx, lambda) + 2 * func(Y2, dx, lambda) + 2 * func(Y3, dx, lambda) + func(Y4, dx, lambda));

                w = w_Next;

            end

        case '4th'

            for i = 1 : N

                Y1 = w;
                Y2 = w + 1/2 * dt * func1(Y1, dx, lambda);
                Y3 = w + 1/2 * dt * func1(Y2, dx, lambda);
                Y4 = w + dt * func1(Y3, dx, lambda);
                w_Next = w + 1/6 * dt * (func1(Y1, dx, lambda) + 2 * func1(Y2, dx, lambda) + 2 * func1(Y3, dx, lambda) + func1(Y4, dx, lambda));

                w = w_Next;

            end        

    end

    q = R * w;
    wave = q(1, :) + h0;

    subplot(1, 2, 1)
%     turb = @(x) turb(x) + h0; 
%     fplot(turb, [-5 5]); hold on;
    plot(xs, wave);
    ylim([0.5 1.5])
    title(['\fontsize{12}{\it h} at {\it t} = ', num2str(T)])
    
    subplot(1, 2, 2)
    plot(xs, q(2, :));
    ylim([-0.5 0.5])
    title(['\fontsize{12}{\it hu} at {\it t} = ', num2str(T)])

    set(gcf, 'Units', 'Inches', 'Position', [0, 0, 20, 3], 'PaperUnits', 'Inches', 'PaperSize', [20, 3])
    
end