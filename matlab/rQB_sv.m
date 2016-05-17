function [Q, B, errs] = rQB_sv(A, k, p)
    [m, n] = size(A);
    Q = zeros(m, 0);
    B = zeros(0, n);
    Omg = randn(n, k);
    G = A * Omg;
    H = A' * G;
    while p > 0
        Omg = H;
        G = A * Omg;
        H = A' * G;
        p = p - 1;
    end
    errs = [];
    r = 0;
    while r < k
        r = r + 1;
        t = B * Omg(:, r);
        y = G(:, r) - (Q * t);
        q = y / norm(y);
        b = ((H(:, r))' - t'*B) / norm(y);
        Q = [Q, q];
        B = [B; b];
        if mod(r, 20) == 0
            errs = [errs; errors(Q, B, A)];
        end
    end
end
