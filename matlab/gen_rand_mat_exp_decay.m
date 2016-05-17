function A = gen_rand_mat_exp_decay(m, n, t)
    L = randn(m, m);
    R = randn(n, n);
    [U, ~] = qr(L);
    [V, ~] = qr(R);
    S = zeros(m, n);
    for i = 1:min(m, n)
        S(i, i) = exp(-i/t);
    end
    A = U * S * V;

