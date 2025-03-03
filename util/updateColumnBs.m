function Bs = updateColumnBs(V, B, Bs, Xs, W, Ys, G, R, Sm, m_ind, bit, lambda, m, gama, ns, lambda2, lambda3)
n = size(B, 1);
for i = 1:bit
    theta = lambda * B * V(m_ind, :)' / bit;
    A = 1 ./ (1 + exp(-theta));
    Vji = V(m_ind, i)';
    omega = Sm - A;
    omega(Sm == 0) = A(Sm == 0);
    omega = omega.^gama;
    Km = lambda / bit * omega .* ((Sm - A) .* repmat(Vji, n, 1)) * ones(m, 1);
    
    p =  Km(1: ns) ...
        + (m * lambda^2 / (4 * bit^2)+ lambda2 + lambda3) * Bs(:, i) ...
        + lambda2 * (Bs(:, i) - Xs * W(:, i)) ...
        + lambda3 * (Bs(:, i) - Ys * G * R(:, i));
    Bs_sgn = ones(ns, 1);
    Bs_sgn(p < 0) = -1;
    Bs(:, i) = Bs_sgn;
end
end