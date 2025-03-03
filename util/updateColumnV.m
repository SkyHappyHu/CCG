function V = updateColumnV(V, B, Sm, m_ind, bit, lambda, m, gama)
n = size(B, 1);
for i = 1:bit
    theta = lambda * B(m_ind, :) * V' / bit;
    A = (1 ./ (1 + exp(-theta)))';
    Bji = B(m_ind, i)';
    omega = Sm - A;
    omega(Sm == 0) = A(Sm == 0);
    omega = omega.^gama;
    p = lambda / bit * omega .* ((Sm - A) .* repmat(Bji, n, 1)) * ones(m, 1) + m *lambda^2 / (4 * bit^2) * V(:, i);
    V_sgn = ones(n, 1);
    V_sgn(p < 0) = -1;
    V(:, i) = V_sgn;
end
end