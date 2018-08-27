function [ X, data_var, rec_var, ext_var, t1, t2, t3, m, m_rec, m_ext  ] = generate_lognormal( dim, sigma, n )
%GENERATE_LOGNORMAL Summary of this function goes here
%   Detailed explanation goes here
%mu = [zeros(1,dim-1) 1];

for i = 1:n
    %r = [mvnrnd([0 0],ones(1,2)*sigma) 0];
    %X(i,:) = expmap_sphere(mu, r);
    theta = rand*sigma;
    phi = rand*4*sigma;
    X(i,:) = [sin(theta)*cos(phi) sin(theta)*sin(phi) cos(theta)];
    X(n+i,:) = [sin(theta)*cos(pi/4+phi) sin(theta)*sin(pi/4+phi) cos(theta)];
    X(2*n+i,:) = [sin(theta)*cos(pi/2+phi) sin(theta)*sin(pi/2+phi) cos(theta)];
    X(3*n+i,:) = [sin(theta)*cos(3*pi/4+phi) sin(theta)*sin(3*pi/4+phi) cos(theta)];
end;
tic
m = karcher_mean_sphere(X');
t1 = toc;

tic
m_rec = karcher_mean_sphere_recursive(X');
t2 = toc;

tic
m_ext = sum(X,1)'/norm(sum(X,1));
t3 = toc;

data_var = 0;
rec_var = 0;
ext_var = 0;
for i=1:n
    data_var = data_var + acos(X(i,:)*m)^2;
    rec_var = rec_var + acos(X(i,:)*m_rec)^2;
    ext_var = ext_var + acos(X(i,:)*m_ext)^2;
end;

data_var = data_var/n;
rec_var = rec_var/n;
ext_var = ext_var/n;

end

