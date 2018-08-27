function [v] = optimize_calc(X, mu)
[dim,N] = size(X);
 
v = rand(dim,1);
v = v./sqrt(abs(inner_prod(v,v)));
eta=10;
prev_error = 1000;
error = 0;
while abs(error-prev_error)>0.000000001
    
    prev_error = error;
   
    sum_grad = 0;
    
    for i = 1: N
        t1 = inner_prod(X(:,i),v);
        t2 = -inner_prod(X(:,i),mu);
        y=X(:,i);
        y(1,1)=-y(1,1);
        sum_grad = sum_grad + abs((atanh(t1/t2)*y)/(t2*(1-(t1/t2)^2))); 
    end;
    
    sum_grad = sum_grad*2/N;
    
    v = v - eta*sum_grad;
    v = v + inner_prod(v,mu)*mu;
    if(norm(v)<1e-6)
        display('pppppppppppppppppppppp');
    end;
    v = v./sqrt(abs(inner_prod(v,v)));
    error = calc_error(X,v,mu);
    if(error<prev_error)
        eta=0.9*eta;
    end;

end; 

%display('end');
end
