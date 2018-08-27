function [v,mu] = PGA(X, L)

addpath(genpath('./sphere'));
mu = karcher_mean_sphere(X);
%v = zeros(size(X,1),L);
[dim,N]=size(X);

y = zeros(N,dim);

for i = 1 : N
	y(i,:) = logmap_sphere(mu, X(:,i));
end;
[v,~]=princomp(y);
v=v(:,1:L);



end
