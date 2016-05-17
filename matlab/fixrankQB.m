function [Q, B]= fixrankQB(A, k)
% standard algorithm in review'2011 paper
% Stage A
[m, n]=size(A);
Omg= randn(n, k);
Y= A*Omg;
[Q, ~]= qr(Y, 0);
B= Q'*A;

