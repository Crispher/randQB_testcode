function [err] = errors(Q, B, A)
    approx_err = norm(Q*B-A, 'fro');
    ortho_err = norm(Q'*Q - eye(size(Q,2)));
    B_err = norm(B-Q'*A);
    err=[approx_err, ortho_err, B_err];