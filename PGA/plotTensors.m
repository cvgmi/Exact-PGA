%----------------------------------------------
%plotTensors(D)
%
%This function plots a 2D field of 3D tensors
%as ellipsoidal glyphs. The 3D tensors must be
%in the form of 3x3 symmetric positive definite
%matrices. The field can contain either a single
%tensor, or row of tensors or a 2D field of tensors.
%
%example 1: plotTensors(D)
%where D is of size 3x3 or 3x3xN or 3x3xNxM
%
%example 2: plotTensors(D,delta)
%where delta is a scalar that controls the size 
%of a voxel in the field. Default: delta=2
%----------------------------------------------
%
%Downloaded from Angelos Barmpoutis' web-page.
%
%This program is freely distributable without 
%licensing fees and is provided without guarantee 
%or warrantee expressed or implied. This program 
%is NOT in the public domain. 
%
%Copyright (c) 2009 Angelos Barmpoutis. 
%
%VERSION : 20090524
%
%-----------------------------------------------
function plotTensors(D,delta)

if nargin==1
    delta=2;
end

sz=size(D);
if length(sz)==2
    nx=1;ny=1;
elseif length(sz)==3
    nx=sz(3);ny=1;
elseif length(sz)==4
    nx=sz(3);ny=sz(4);
end

n=size(D,3);
for i=1:nx
    for j=1:ny
        %i,j
        [v,l]=eig(D(:,:,i,j));
        [m,ii]=max(diag(l));
        clr([1:3],i,j)=v(:,ii).^2;
        [X,Y,Z]=ellipsoid(0,0,0,l(1,1),l(2,2),l(3,3),10);
        sz=size(X);
        for x=1:sz(1)
            for y=1:sz(2)
                A=[X(x,y) Y(x,y) Z(x,y)]';
                A=v*A;
                X(x,y)=A(1);Y(x,y)=A(2);Z(x,y)=A(3);
            end
        end
        X=X+(i-1)*delta;
        Y=Y+(j-1)*delta;
        h(i)=surf(X,Y,Z); 
        if i==1 & j==1
            hold
         end
    end
end
axis equal
view([0 90]);
set(gca,'GridLineStyle','none')
set(gca,'XTick',[])
set(gca,'YTick',[])
set(gca,'ZTick',[])
shading interp
lighting phong
light('Position',[2 2 2],'Style','infinite');

h_=get(gca,'Children');
for i=1:nx
    for j=1:ny        
     %   set(h_(length(h_)-((i-1)*ny+j)+1),'FaceColor',clr(:,i,j));
    end
end