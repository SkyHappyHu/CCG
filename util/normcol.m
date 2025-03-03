function [D] = normcol(D)
% normalize column to 1

D = D./repmat(sqrt(sum(D.^2,1)), size(D,1), 1);