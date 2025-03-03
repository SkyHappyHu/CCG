function R = updateR(B, Y, G)
singular = B' * Y * G;
[UB, ~, UA] = svd(singular);    
R = UA * UB';
end