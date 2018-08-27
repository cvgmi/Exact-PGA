function [y] = calc_y(v, x, mu)


norm_v = abs(inner_prod(v,v));
t = atanh(inner_prod(v,x)/(-inner_prod(mu,x)*norm_v))/norm(v);
%t = atan(((v'*x)/(mu'*x)-(v'*mu))/norm_v)/norm(v);
if(norm_v)==0
    display('ppppppppp');
end;
y = cosh(t*norm_v)*mu + sinh(norm_v*t)*v./norm_v;


end
