function result = func(array, dx, dy, s0)
    
    q_t(:, :, 1) = D_x(array(:, :, 2), dx) + D_y(array(:, :, 3), dy);
    q_t(:, :, 2) = s0 * D_x(array(:, :, 1), dx);
    q_t(:, :, 3) = s0 * D_y(array(:, :, 1), dy);
    
    result = -q_t;

end