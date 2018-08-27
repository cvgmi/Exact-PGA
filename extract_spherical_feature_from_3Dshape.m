function [sq] = extract_spherical_feature_from_3Dshape(I)

%   ...Parameters...    %
tau = exp(-4);

%   ...Dimensions...    %
[Xsize, Ysize, Zsize] = size(I);

%   ...Find boundary... %
x1 = [];
I = round(I);
for i = 1 : Xsize
    B = bwboundaries(squeeze(I(i, :, :)));
    if ~isempty(B)
        x1 = cat(1, x1, [i * ones(length(B{1}), 1), B{1}]);
    end
end
x1 = x1 ./ max(x1(:));

%   ...SDT...   %
xmin = min(x1);
xmax = max(x1);

Xsize = Xsize-1;
Ysize = Ysize-1;
Zsize = Zsize-1;

[Xmesh,Ymesh,Zmesh] = meshgrid(xmin(1):(xmax(1)-xmin(1))/Xsize:xmax(1),...
    xmin(2):(xmax(2)-xmin(2))/Ysize:xmax(2),...
    xmin(3):(xmax(3)-xmin(3))/Zsize:xmax(3));

X = Xmesh(:);
Y = Ymesh(:);
Z = Zmesh(:);

X = repmat(X, 1, length(x1));
Y = repmat(Y, 1, length(x1));
Z = repmat(Z, 1, length(x1));

X = X - repmat(x1(:, 1)', length(X), 1);
Y = Y - repmat(x1(:, 2)', length(Y), 1);
Z = Z - repmat(x1(:, 3)', length(Z), 1);

r = sqrt(X .^ 2 + Y .^ 2 + Z .^ 2);

phi = sum(exp(-r/ tau), 2);
phi = phi./ sum(phi);
sq = sqrt(phi);

end