function [v] = logmap_hyper(p, x)


%   logmap_sphere maps x on sphere to the tangent space T_{p}M.
%
%   v = logmap_sphere(p, x)
%
%   p and x are unit vectors (points on the unit sphere).
%   v is a tangent vector in T_{p}M.


if norm(p - x) < 1e-10
    v = zeros(size(p));
    return;
end

theta = dist_hyper(p, x);
v = theta * (x - p * cosh(theta))/ sinh(theta);


end

