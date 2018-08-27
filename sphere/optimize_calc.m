function [v] = optimize_calc(X, mu)
[dim,N] = size(X);
 
v = rand(dim,1);
v = v./norm(v);
eta=10;
prev_error = 1000;
error = 0;
while abs(error-prev_error)>0.000000001
    
    prev_error = error;
   
    sum_grad = 0;
    
    for i = 1: N
        t1 = X(:,i)'*v;
        t2 = X(:,i)'*mu;
        sum_grad = sum_grad + (atan(t1/t2)*X(:,i))/(t2*(1+(t1/t2)^2)); 
    end;
    
    sum_grad = sum_grad*2/N;
    
    v = v + eta*sum_grad;
    v = v - (v'*mu)*mu;
    if(norm(v)<1e-6)
        display('pppppppppppppppppppppp');
    end;
    v = v./norm(v);
    error = calc_error(X,v,mu);
    if(error<prev_error)
        eta=0.9*eta;
    end;

end; 

%display('end');
end
