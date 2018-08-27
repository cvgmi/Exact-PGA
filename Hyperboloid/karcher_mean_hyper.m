function [mu] = karcher_mean_hyper(X, varargin)


%   karcher_mean_sphere calculates the intrinsic mean of the set of points
%   X, on sphere, with weight W.
%
%   mu = karcher_mean_sphere(X)
%   mu = karcher_mean_sphere(X, W)
%   mu = karcher_mean_sphere(X, W, max_iter)
%   mu = karcher_mean_sphere(X, W, max_iter, lambda)
%
%   X is a set of points on sphere.
%   W is the weights.
%   max_iter is the maximum number of iterations.
%   lambda is the learning rate of the gradient descent algorithm.
%   mu is the Karcher mean of the set of points X, on sphere, with weight
%   W.


%   ...Dimension and number of samples...   %
[n, N] = size(X);

%   ...learning rate, maximum number of iterations and Weights... %
lambda = 0.9;
max_iter = 1000;
W = ones(1, N)/ N;

if nargin >= 4
    lambda = varargin{3};
end
if nargin >= 3
    max_iter = varargin{2};
end
if nargin >= 2
    W = varargin{1};
    W = W/ sum(W);
end


%   ...Compute the karcher mean through gradient descent...   %

%   ...Initializations...   %
iter = 0;
error = realmax;
mu = X(:, randi(N));

%   ...Gradient descent...  %
while true
    mu_old = mu;
    error_old = error;
    gradient = zeros(n, 1);
    
    for i = 1 : N
        gradient = gradient + W(i) * logmap_hyper(mu, X(:, i));
    end
    gradient = 2 * gradient/ N;
    mu = expmap_hyper(mu, lambda * gradient);
    inner_prod(mu,mu)
    %   ...Calculate mean square error...   %
    error = 0;
    for i = 1 : N
        error = error + W(i) * dist_hyper(mu, X(:, i)) ^ 2;
    end
    error = error/ N;
    
    %   ...Check whether to consider the new mean or not...   %
    if error < error_old
        iter = iter + 1;
    else
        mu = mu_old;
        error = error_old;
        lambda = 0.95 * lambda;
    end
    
    %   ...Check if the current mean is acceptable, then stop...   %
    if (iter >= max_iter) || (norm(gradient) < 1e-4) || (lambda < 0.9)
        break;
    end
    
    %error
    %lambda
    %norm(gradient)
end


end

