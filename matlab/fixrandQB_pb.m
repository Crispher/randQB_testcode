function [Q, B, err]= fixrandQB_pb(A, k, b, p)
% the algorithm in the [Martin2015] paper
% QB decomposition is Stage A of randSVD 
[m, n]=size(A);
s= round(k/b);
k= s*b;
Q= zeros(m, k);
B= zeros(k, n);
ins= 1;
len= b-1;
A_copy = A;
Aomg= zeros(m,b);
QQ= zeros(m,b);
err = [];
for j=1:s,
    Omg= randn(n, b);
    Aomg= A*Omg;
    [Qi, temp]= qr(Aomg, 0);
    for i=1:p,
        [Qi, temp]= qr(A'*Qi, 0);
        [Qi, temp]= qr(A*Qi, 0);
    end
    if j>1,
        for i=1:j-1,
            temp1= Q(:,(i-1)*b+1:i*b)'*Qi;
            QQ= QQ+ Q(:,(i-1)*b+1:i*b)*temp1;
        end 
        [Qi, temp]= qr(Qi-QQ, 0);
    end
    Bi= Qi'*A;
    Q(:, ins:ins+len)= Qi;
    B(ins:ins+len, :)= Bi;
    ins= ins+b;
    A= A- Qi*Bi;
    err = [err; errors(Q(:,1:j*b-1), B(1:j*b-1,:), A_copy)];
end


