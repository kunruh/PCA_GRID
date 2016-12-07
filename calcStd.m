function [ stdev ] = calcStd( matrix, xbar )
%CALCSTD Summary of this function goes here
%   Detailed explanation goes here
    N = size(matrix,2);
    s = 0;
    for i = 1:N
        s = s + norm(matrix(:,i)-xbar)^2/N;
    end
    stdev = sqrt(s);
end

