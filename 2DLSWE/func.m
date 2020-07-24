function w_t = func(w, dx, lambda)

    wr = [w(:, end) w(:, 1 : end - 1)]; % right shift w to obtain w(x - dx)
    wl = [w(:, 2 : end) w(:, 1)]; % left shift w to obtain w(x + dx)

    w_x = (wl - wr) / (2 * dx);
    w_t = - lambda .* w_x;

end