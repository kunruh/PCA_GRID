function [ ndx ] = screeMethod( explained, threshold )
    ndx = find(cumsum(explained)>100*threshold,1);
end

