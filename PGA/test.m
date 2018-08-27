% tensor field PGA test
clear all;
close all;
load fields.mat;

[d,d,row,col,N] = size(fields);
fields = reshape(fields, [d,d,row*col, N]);

[meanfield,latent,pcfields] = PGATF(fields);

% mean tensor field
meanfield = reshape(meanfield, [d,d,row,col]);
plotTensors(meanfield,0.006);drawnow;

% first PC
pfield = pcfields(:,:,:,1);
pfield = reshape(pfield, [d,d,row,col]);
pd1 = zeros(d,d,row,col);
for i=1:row
    for j=1:col
        pd1(:,:,i,j) = expmap(meanfield(:,:,i,j),10*pfield(:,:,i,j));
    end
end
figure;
plotTensors(pd1,0.006);

% second PC
pfield = pcfields(:,:,:,2);
pfield = reshape(pfield, [d,d,row,col]);
pd2 = zeros(d,d,row,col);
for i=1:row
    for j=1:col
        pd2(:,:,i,j) = expmap(meanfield(:,:,i,j),10*pfield(:,:,i,j));
    end
end
figure;
plotTensors(pd2,0.006);