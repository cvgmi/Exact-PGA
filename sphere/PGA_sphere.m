function [meanfield,latent,pcfields] = PGATF(fields)
%compute mean tensor field and PGA
%Input: fields: d-by-d-by-m-by-N, m is number of voxels and N is number of
%               input fields
%output: meanfield: d-by-d-by-m (SPD matrix)
%        latent:    eigenvalues
%        pcs:       principal components
% Note: pcs are vectors (symmetric matrices) on tangent plane. 
[d,d,m,N] = size(fields);
meanfield = zeros(d,d,m);
disp('Start to compute mean field.');
parfor i=1:m
    meanfield(:,:,i) = meanTensor(squeeze(fields(:,:,i,:)));
end
%map each tensor field to tangent space
disp('Map each tensor field to the tangent space.');
tfield = zeros(d,d,m,N);
for i=1:m
    for j=1:N
        tfield(:,:,i,j) = logmap(meanfield(:,:,i),fields(:,:,i,j));
    end
end
%compute G field, where M=G*G'
gfield = zeros(d,d,m);
parfor i=1:m
    [u,L] = eig(meanfield(:,:,i));
    gfield(:,:,i) = u*sqrt(L);
end

%pull the mean to I
for i=1:m
    invg = inv(gfield(:,:,i));
    for j=1:N
        tfield(:,:,i,j) = invg*tfield(:,:,i,j)*invg';
    end
end
%treat each field as column vectors
disp('Treat each field as column vectors.');
T = zeros(d*(d+1)/2,m,N);
for i=1:m
    for j=1:N
        T(1,i,j) = tfield(1,1,i,j);
        T(2,i,j) = tfield(2,2,i,j);
        T(3,i,j) = tfield(3,3,i,j);
        T(4,i,j) = sqrt(2)*tfield(1,2,i,j);
        T(5,i,j) = sqrt(2)*tfield(2,3,i,j);
        T(6,i,j) = sqrt(2)*tfield(1,3,i,j);
    end
end

T = reshape(T,[6*m,N]);
disp('Start PCA.');
[pc, score, latent] = princomp(T);
pcs = T*pc;
disp('Normalize PCs');
parfor i=1:N
    pcs(:,i) = pcs(:,i)/norm(pcs(:,i));
end

%reshape pcs
disp('Reshape PCs.');
pcs = reshape(pcs, [6,m,N]);
pcfields = zeros(d,d,m,N);
for i=1:N
    for j=1:m
        pcfields(:,:,j,i) = [pcs(1,j,i)         pcs(4,j,i)/sqrt(2) pcs(6,j,i)/sqrt(2)
                             pcs(4,j,i)/sqrt(2) pcs(2,j,i)         pcs(5,j,i)/sqrt(2)
                             pcs(6,j,i)/sqrt(2) pcs(5,j,i)/sqrt(2) pcs(3,j,i)];
    end
end

%pull the coordinate back to M
for i=1:N
    for j=1:m
        pcfields(:,:,j,i) = gfield(:,:,j)*pcfields(:,:,j,i)*gfield(:,:,j)';
    end
end
