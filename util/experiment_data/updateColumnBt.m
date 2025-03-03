function Bt = updateColumnBt(V, B, Bt, Xt, W, Yt, G, R, Sm, m_ind, bit, lambda, m, gama, ns, nt, lambda2, lambda3)
n = size(B, 1);
for i = 1:bit
    theta = lambda * B * V(m_ind, :)' / bit;
    A = 1 ./ (1 + exp(-theta));
    Vji = V(m_ind, i)';
    omega = Sm - A;
    omega(Sm == 0) = A(Sm == 0);
    omega = omega.^gama;
    Km = lambda / bit * omega .* ((Sm - A) .* repmat(Vji, n, 1)) * ones(m, 1);
    
    p =  Km(ns + 1: n) ...
        + (m * lambda^2 / (4 * bit^2)+ lambda2 + lambda3) * Bt(:, i) ...
        + lambda2 * (Bt(:, i) - Xt * W(:, i)) ...
        + lambda3 * (Bt(:, i) - Yt * G * R(:, i));
    Bt_sgn = ones(nt, 1);
    Bt_sgn(p < 0) = -1;
    Bt(:, i) = Bt_sgn;
end
end