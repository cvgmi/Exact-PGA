function [X] = extract_texture_data()
l = dir('./textures/*.tiff');
for i = 1 : size(l,1)
    cd('./textures/');
    I = imresize(imread(l(i).name),0.5);
    cd('..');
    X{i} = compute_covariance_feature(I);
    i
end;



end