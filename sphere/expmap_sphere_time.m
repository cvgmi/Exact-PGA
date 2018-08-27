function [x] = expmap_sphere_time(p, v, t)


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

x = cos(norm(v)*t) * p + sin(norm(v)*t) * v/ norm(v);


end

