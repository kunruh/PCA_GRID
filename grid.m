function [ a ] = grid( X , Nc, Ng)
%GRID Summary of this function goes here
%   Detailed explanation goes here
    [M,N] = size(X);
    a = zeros(1,N);
    a(1) = 1;
    ej = a;
    for i = 1:Nc
       theta = linspace(-pi()/(2^i),pi()/(2^i),Ng);
       maxS = 0;
       maxTHETA = 0;
       for j=1:N
           ej = zeros(1,N);
           ej(j) = 1;
           
           for angle=theta
                a_cos_sin = cos(angle)*a + sin(angle)*ej;
                a_cos_sin = a_cos_sin ./norm(a_cos_sin);
                v = sqrt(var(a_cos_sin * X'));
                if(v > maxS)
                    maxS = v;
                    maxTHETA = angle;
                end
           end
           a = cos(maxTHETA)*a + sin(maxTHETA)*ej;
           a = a./norm(a);
       end
       
    end

end

