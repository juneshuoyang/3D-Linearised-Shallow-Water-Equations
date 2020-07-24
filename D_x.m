function result = D_x(matrix, dx)

    Lmatrix = [matrix(:, 2 : end) matrix(:, 1)]; % left shift to obtain f(x + dx, y)
    Rmatrix = [matrix(:, end) matrix(:, 1 : end - 1)]; % right shift to obtain f(x - dx, y)
 
    result = (Lmatrix - Rmatrix) / (2 * dx);

end