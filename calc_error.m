function [ error ] = calc_error( X, v, mu )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[dim,N] = size(X);

error = 0;

for i = 1 : N
    
    y = calc_y(v, X(:,i), mu);
    error = error + abs(acos(mu'*y));
    
end;

error=error/N;


end

