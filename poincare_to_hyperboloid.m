function x = poincare_to_hyperboloid(y)
s=0;
for i=1:length(y)
    s=s+y(i)^2;
end;

if s~=1
    x(1) = (1+s)/(1-s);
    for i=1:length(y)
        x(i+1) = 2*y(i)/(1-s);
    end;
else
      x(1) = (1-s)/(1+s);
    for i=1:length(y)
        x(i+1) = 2*y(i)/(1+s);
    end;
end;

end