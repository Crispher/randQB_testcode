function [Q, B, errs] = svd_QB(A, k, ~)
    [U, S, V] = svd(A);
    errs = [];
    for i = 1:k
        Q = U(:, 1:i);
        B = S(1:i, 1:i) * V(:, 1:i)';      
        if (mod(i, 20) == 0)
            errs = [errs; errors(Q, B, A)];
        end
    end