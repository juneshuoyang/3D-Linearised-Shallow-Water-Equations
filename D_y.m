function result = D_y(matrix, dy)

    Umatrix = [matrix(2 : end, :); matrix(1, :)]; % upward shift to obtain f(x, y + dy)
    Dmatrix = [matrix(end, :); matrix(1 : end - 1, :)]; % downward shift to obtain f(x, y - dy)
    
    result = (Umatrix - Dmatrix) / (2 * dy);

end