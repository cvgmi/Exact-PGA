function [y] = calc_y(v, x, mu)


norm_v = norm(v);
t = atan((v'*x)/((mu'*x)*norm_v))/norm(v);
%t = atan(((v'*x)/(mu'*x)-(v'*mu))/norm_v)/norm(v);
if(norm_v)==0
    display('ppppppppp');
end;
y = cos(t*norm_v)*mu + sin(norm_v*t)*v./norm_v;


end
