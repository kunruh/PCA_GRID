function [ xbar ] = calcMean( matrix )
%CALCMEAN Summary of this function goes here
%   Detailed explanation goes here
    [M,N] = size(matrix);
    xbar = zeros(M,1);
    for i = 1:N
       xbar =  xbar + matrix(:,i);
    end
    xbar = xbar / N;

end

