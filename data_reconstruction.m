function [ X_bar ] = data_reconstruction( X,v )
% X_[dim, N]

addpath(genpath('./sphere'));
[dim, N]=size(X);
[~,num]=size(v)
mu = karcher_mean_sphere(X);
princip_comp = zeros(dim,num,N);

for i = 1 : N
    for j = 1 : num
        princip_comp(:,j,i)=calc_y(v(:,j), X(:,i), mu);
        princip_comp(:,j,i) = princip_comp(:,j,i)./norm(princip_comp(:,j,i));
    end;
end;

%X_bar = squeeze(princip_comp(:,1,:));
X_bar = rand(dim,N);
for i = 1 : N
	X_bar(:,i) = X_bar(:,i)./norm(X_bar(:,i));
end;
for j = 1 : N
    for k = 1 : num
        b = (mu'*squeeze(princip_comp(:,k,j)))^2 + (mu'*X_bar(:,j))^2;
        d = -(mu'*squeeze(princip_comp(:,k,j)))^2;
        v_bar = paralleltranslateAtoB_sphere(mu, X_bar(:,j), v(:,k));
        v_bar = v_bar./norm(v_bar);
        w = logmap_sphere(mu, X_bar(:,j));
        w_bar = paralleltranslateAtoB_sphere(mu, squeeze(princip_comp(:,k,j)), w./norm(w));
        a = ((mu'*X_bar(:,j))*(w_bar'*X_bar(:,j))*(v_bar'*squeeze(princip_comp(:,k,j))))^2 - (mu'*X_bar(:,j))^2;
        
        alpha = sqrt((-b+sign(a)*sqrt(b^2-4*a*d))/(2*a));
        X_bar(:,j) = cos(alpha)*X_bar(:,j) + sin(alpha)*v_bar;
    end;
end;


end

