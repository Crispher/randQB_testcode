function [U, S, V]= fixAccRSVDnew(A, acc_tol)
% new algorithm in [Martin2015] + energy measurement
% get rank 271 for A3 matrix
% Stage A
[m, n]=size(A);
energyA= norm(A, 'fro')^2;
energy_tol= energyA* (1-acc_tol);
Q=[];
B=[];
j=0;
while energyA> energy_tol,
    j=j+1;
    Omg= randn(n, 1);
    q= A*Omg;
    q= q/norm(q);
    b= q'*A;
    Q=[Q q];
    B= [B; b];
    A= A- q*b;
    energyA= norm(A, 'fro')^2;
end

% Stage B
[U1,S,V]= svd(B, 'econ');
U= Q*U1;


