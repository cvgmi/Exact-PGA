function [v,mu] = PGA_hyper(X, L)

addpath(genpath('./Hyperboloid'));
mu = karcher_mean_hyper(X);
%v = zeros(size(X,1),L);
[dim,N]=size(X);

y = zeros(N,dim);

for i = 1 : N
	y(i,:) = logmap_hyper(mu, X(:,i));
end;
[v,~]=princomp(y);
v=v(:,1:L);



end
