tic

test_no=3;

if test_no == 1
    [Q, B, e1] = rQB_sv(A, 1000, 0);
    semilogy(e1);
end
if test_no == 2
    [Q, B, e2] = svd_QB(A, 1000, 0);
    semilogy(e2);
end
if test_no == 3
    [Q, B, e3] = rQB_b(A, 1000, 20, 0);
    semilogy(e3);
end
if test_no == 4
    [Q, B, e4] = nfixrandQB(A, 1000, 0);
    semilogy(e4);
end
if test_no == 5
    [Q, B, e5] = fixrandQB_pb(A, 1000, 20, 0);
    semilogy(e5);
end

toc