function [L, J] = fun_W(W, Bs, Bt, Xs, Xt, lambda1, lambda2, Grad_LDA)
L = lambda1 * trace(W'* Grad_LDA * W) / 2 + lambda2 * trace((Bs - Xs * W)' * (Bs - Xs * W) + (Bt - Xt * W)' * (Bt - Xt * W)) / 2;
J = lambda1 * (Grad_LDA * W) + lambda2 * (Xs' * Xs * W - Xs' * Bs + Xt' * Xt * W - Xt' * Bt);
end
