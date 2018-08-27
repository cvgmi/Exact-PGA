function [mu, mean_grad] = karcher_mean_sphere_recursive(X, varargin)


%   karcher_mean_sphere_recursive recursively calculates the intrinsic 
%   mean of the set of points X, on a sphere, with weight W.
%
%   mu = karcher_mean_sphere_recursive(X)
%   mu = karcher_mean_sphere_recursive(X, W)
%   mu = karcher_mean_sphere_recursive(X, W, xj)
%
%   X is a set of points on the sphere.
%   W is the weights.
%   mu is the Karcher mean of the set of points X, on the sphere, with 
%   weight W.


%   ...Number of samples...   %
X = squeeze(X);
[~, N] = size(X);

%   ...Weights... %
W = ones(1, N)/ N;

if nargin >= 3
    xj = varargin{2};
end
if nargin >= 2
    W = varargin{1};
    W = W/ sum(W);
end


%   ...Initializations...   %
wt = zeros(N, 1);
angle = zeros(1, N);


%   ...Compute the karcher mean of a set of points on oblique manifold...   %
mu = X(:, 1);
for i = 2 : N
    t = W(i)/ sum(W(1 : i));
    theta = acos(mu' * X(:, i));
    
    if theta ~= 0
        mu = (sin((1 - t) * theta) * mu + sin(t * theta) * X(:, i))/ sin(theta);
    end
    
    wt(i) = t;
    angle(i) = theta;
end


%   ...If nargout >= 2, find gradient of the mean w.r.t. the xj-th point... %
if nargout >= 2
    mean_grad = mean_gradient_sphere(wt, angle, xj);
end


end

