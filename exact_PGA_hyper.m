function [v,mu] = exact_PGA_hyper(X, L)

addpath(genpath('./Hyperboloid'));
new_X = X;
mu = karcher_mean_hyper(X);
v = zeros(size(X,1),L);
[dim,N]=size(X);


for i = 1 : L
    v(:,i) = optimize_calc(new_X, mu);
    for j = 1 : N
        y = calc_y(v(:,i), new_X(:,j), mu);
        if inner_prod(y,y)<0
            y = y./sqrt(-inner_prod(y,y));
        end;
        new_v = logmap_hyper(y, new_X(:,j));
        transported_v = paralleltranslateAtoB_hyper(y, mu, new_v);
       % transported_v = paralleltranslate(new_v, mu);
        transported_v = transported_v./sqrt(abs(inner_prod(transported_v, transported_v)));
        new_X(:,j) = calc_y(transported_v, new_X(:,j), mu);
        if inner_prod(new_X(:,j),new_X(:,j))<0
            new_X(:,j) = new_X(:,j)./sqrt(-inner_prod(new_X(:,j),new_X(:,j)));
        end;
    end;
  
    i
end;




end
