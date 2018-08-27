function [ ] = call_exact_PGA_hyper( X )
%CALL_EXACT_PGA_HYPER Summary of this function goes here
%   Detailed explanation goes here
s1=size(X,2);
s2=size(X{1},2);
   c=1;
for j=1:s2
    %data=zeros(11,s1);
 
    for i=1:s1
        y=zeros(1,10);
        y(1:2:9) = X{i}{j}.mean/sqrt(2);
        y(2:2:end) = diag(X{i}{j}.D)';
        if sum(isnan(y)) == 0
        data(1:11,c) = poincare_to_hyperboloid(y);
        c=c+1;
        end
    end;

    
    
end;
      [v,mu] = exact_PGA_hyper(data, 2);  

end

