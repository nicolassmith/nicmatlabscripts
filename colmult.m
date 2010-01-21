function matrixOut = colmult(matrixIn,coeffs)
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

if size(coeffs,1) > 1
    error('Coefficints should be a row vector')
end

if size(matrixIn,2) ~= size(coeffs,2)
    error('Number of coefficients should match number of columns in matrix.')
end

matrixOut = matrixIn .* (ones(size(matrixIn,1),1) * coeffs);