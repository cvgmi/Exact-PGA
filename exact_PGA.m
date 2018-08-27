function [v,mu] = exact_PGA(X, L)

addpath(genpath('./sphere'));
new_X = X;
mu = karcher_mean_sphere(X);
v = zeros(size(X,1),L);
[dim,N]=size(X);

tic;
for i = 1 : L
    v(:,i) = optimize_calc(new_X, mu);
    for j = 1 : N
        y = calc_y(v(:,i), new_X(:,j), mu);
        y = y./norm(y);
        new_v = logmap_sphere(y, new_X(:,j));
        transported_v = paralleltranslateAtoB_sphere(y, mu, new_v);
       % transported_v = paralleltranslate(new_v, mu);
        transported_v = transported_v./norm(transported_v);
        new_X(:,j) = calc_y(transported_v, new_X(:,j), mu);
        new_X(:,j) = new_X(:,j)./norm(new_X(:,j));
    end;
  
    i
end;
toc;



end
