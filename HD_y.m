function result = HD_y(matrix, dy)

    Umatrix = [matrix(2 : end, :); matrix(1, :)]; % upward shift to obtain f(x, y + dy)
    UUmatrix = [Umatrix(2 : end, :); Umatrix(1, :)]; % upward shift again to obtain f(x, y + 2dy)
    
    Dmatrix = [matrix(end, :); matrix(1 : end - 1, :)]; % downward shift to obtain f(x, y - dy)
    DDmatrix = [Dmatrix(end, :); Dmatrix(1 : end - 1, :)]; % downward shift again to obtain f(x, y - 2dy)
    
    result = (DDmatrix - 8 * Dmatrix + 8 * Umatrix - UUmatrix) / (12 * dy);

end