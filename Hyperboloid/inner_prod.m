function prod = inner_prod(mu,x)

prod = -mu(1,1)*x(1,1);
for i=2:size(mu,1)
    prod=prod+mu(i,1)*x(i,1);
end;

end