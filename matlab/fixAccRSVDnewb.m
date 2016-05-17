function [U, S, V]= fixAccRSVDnewb(A, acc_tol)
% new algorithm in [Martin2015](randbQB) + energy measurement
% get rank 271 (no change) for A3 matrix
% Stage A
[m, n]=size(A);
energyA= norm(A, 'fro')^2;
energy_tol= energyA* (1-acc_tol);
bs= 5;
Q=[];
B=[];
j=0;
% Ai= A;
while energyA> energy_tol,
    j=j+1;
    Omg= randn(n, bs);
    [Qi, temp]= qr(A*Omg, 0);
    if j>1,
        [Qi, temp]= qr(Qi-Q*Q'*Qi, 0);
    end
    Bi= Qi'*A;
    Q=[Q Qi];
    B= [B; Bi];
    A= A- Qi*Bi;
    energyA= norm(A, 'fro')^2;
end

% Stage B
[U1,S,V]= svd(B, 'econ');
U= Q*U1;


