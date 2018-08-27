function [kappa] = kernel_func_sphere(p, x, varargin)

ker_n = 3;
varargin = varargin{1};

if nargin >= 3
    ker_n = varargin{1};
end


if ker_n == 1
    %	...Kernel function 1...	%
    
elseif ker_n == 2
    %	...Kernel function 2...	%
    n = 500;
    
    if nargin >= 4
        b = varargin{2};
        if length(b) == 1
            if  nargin >= 5
                n = varargin{3};
            end
            b = b * ones(n, 1);
        else
            n = length(b);
        end
    else
        b = ones(n, 1)/ n;
    end
    kappa = sum(b .* ((p' * x) .^ ((1 : n)')));
    
elseif ker_n == 3
    %	...Kernel function 3...	%
    b = 1;
    if nargin >= 4
        b = varargin{2};
    end
    kappa = acos(p' * x);
    kappa = exp(-b * kappa);
    
elseif ker_n == 4
    %	...Kernel function 4...	%
    b = 1;
    if nargin >= 4
        b = varargin{2};
    end
    kappa = exp(b * p' * x);

end


end

