function [Q, B, errs]= nfixrandQB(A, k, p)
% the proposed algorithm
% QB decomposition is Stage A of randSVD 
[m, n]=size(A);
B= randn(k, n);    % origionally randn vectors
Q= A*B';           % ie. G matrix
H= A'*Q;
errs = [];
for i=1:k,
    Omg= B(i,:)';
    if i>1,
        y= Q(:,i)-Q(:,1:i-1)*(B(1:i-1,:)*Omg);
        normy= norm(y);
        q= y/normy;
%         q= q-Q(:,i-1)*(Q(:,i-1)'*q);  % re-ortho
%         q= q/norm(q);
        % modified G-S procedure
%         for j=1:i-1,
%             al= Q(:,j)'*q;
%             q= q- al*Q(:,j);
%         end
        q= q/norm(q);
        b= (H(:,i)'-Omg'*B(1:i-1,:)'*B(1:i-1,:))/normy;
    else
        y= Q(:,i);
        normy= norm(y);
        q= y/normy;
        b= H(:,i)'/normy;
    end
    Q(:, i)= q;
    B(i, :)= b;
    if (mod(i, 20) == 0)
        errs = [errs; [errors(Q(:,1:i), B(1:i,:), A), norm(b), norm(y)]];
%        errs = [errs; [norm(b), norm(y)]];
    end
end