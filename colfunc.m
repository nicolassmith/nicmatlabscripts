function matrixOut = colfunc(matrixIn,funHandles)
% to multiply the columns of a matrix by the elements of a row vector
%
% usage: newMat = colmult(oldMat,coeffs)
%
% This is take oldMat and multiply each nth column by the nth element of
% the coeffs vector.
%
% example:
% GG = colmult(MM,[1,2]);
% for MM with two columns, will return GG which has each element in the 
% second column multiplied by 2.

if size(funHandles,1) > 1
    error('Coefficints should be a row cell array')
end

if size(matrixIn,2) ~= size(funHandles,2)
    error('Number of coefficients should match number of columns in matrix.')
end

ncols = size(matrixIn,2);

matrixOut = zeros(size(matrixIn));

for j = 1:ncols
    matrixOut(:,j) = funHandles{j}(matrixIn(:,j));
end

end

