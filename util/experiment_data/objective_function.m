function [loss] = objective_function(W, Bs, Bt, R1, R2, G, V, Xs, Xt, Ys, Yt, lambda, lambda1, lambda2, lambda3, gama, S, bit, Grad_LDA)
l1 = trace(W'* Grad_LDA * W);
l2 = trace((Bt - Xt * W)' * (Bt - Xt * W)) + trace((Bs - Xs * W)' * (Bs - Xs * W));
l3 = trace((Bt - Yt * G * R1)' * (Bt - Yt * G * R1)) + trace((Bs - Ys * G * R2)' * (Bs - Ys * G * R2));

B = [Bs; Bt];
theta = lambda * B * V' / bit;
A = 1 ./ (1 + exp(-theta));
omega = S - A;
omega(S == 0) = A(S == 0);
omega = omega.^gama;
p = omega .* (S .* theta - log(1 + exp(theta)));
l4 = sum(sum(p));

loss = lambda1 / 2 * l1 + lambda2 / 2 * l2 + lambda3 / 2 * l3 - l4;
end
