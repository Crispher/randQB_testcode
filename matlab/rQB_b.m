function [Q, B, errs] = rQB_b(A, k, block_size, p)
    [m, n]  = size(A);
    Q = zeros(m, 0);
    B = zeros(0, n);
    Omg = randn(n, k);
    G = A * Omg;
    H = A' * G;
    errs = [];
    r = 1;
    while r < k
        t = B * Omg(:, r:r+block_size-1);
        y = G(:, r:r+block_size-1) - (Q * t);
        [q, R] = qr(y, 0);
        
%         [q, R1] = qr(q - Q * (Q' * q), 0);
%         R = R1 * R;
           
        % b = inv(R')*((H(:, r:r+block_size-1))' - t'*B);
        b = R' \ ((H(:, r:r+block_size-1))' - t'*B);
        
        Q = [Q, q];
        B = [B; b];
        r = r + block_size;
        errs = [errs; errors(Q, B, A)];
    end
end
