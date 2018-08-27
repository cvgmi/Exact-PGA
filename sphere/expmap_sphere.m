function [x] = expmap_sphere(p, v)


%   expmap_sphere maps the tangent vector v in T_{p}M to x on the unit
%   sphere.
%
%   x = expmap_sphere(p, v)
%
%   p and x are unit vectors (points on the unit sphere).
%   v is a tangent vector in T_{p}M.


if norm(v) < 1e-10
    x = p;
    return;
end

x = cos(norm(v)) * p + sin(norm(v)) * v/ norm(v);


end

