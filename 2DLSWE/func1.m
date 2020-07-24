function w_t = func1(w, dx, lambda)

    wr = [w(:, end) w(:, 1 : end - 1)]; % right shift w once to obtain w(x - dx)
    wrr = [wr(:, end) wr(:, 1 : end - 1)]; % right shift w twice to obtain w(x - 2dx)

    wl = [w(:, 2 : end) w(:, 1)]; % left shift w once to obtain w(x + dx)
    wll = [wl(:, 2 : end) wl(:, 1)]; % left shift w twice to obtain w(x + 2dx)

    w_x = (wrr - 8 * wr + 8 * wl - wll) / (12 * dx);
    w_t = - lambda .* w_x;

end