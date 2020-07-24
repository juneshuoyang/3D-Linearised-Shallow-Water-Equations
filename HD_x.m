function result = HD_x(matrix, dx)

    Lmatrix = [matrix(:, 2 : end) matrix(:, 1)]; % left shift to obtain f(x + dx, y)
    LLmatrix = [Lmatrix(:, 2 : end) Lmatrix(:, 1)]; % left shift again to obtain f(x + 2dx, y)
    
    Rmatrix = [matrix(:, end) matrix(:, 1 : end - 1)]; % right shift to obtain f(x - dx, y)
    RRmatrix = [Rmatrix(:, end) Rmatrix(:, 1 : end - 1)]; % right shift again to obtain f(x - 2dx, y)
    
    result = (RRmatrix - 8 * Rmatrix + 8 * Lmatrix - LLmatrix) / (12 * dx);

end