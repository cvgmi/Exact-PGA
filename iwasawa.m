function [D, R] = iwasawa(P)
%
%
D=zeros(size(P));
R=zeros(size(P,1)-1,size(P,1)-1);
Q=P;
for i = size(P,1):-1:2
v=Q(1:end-1,1:end-1);
c1=v\Q(1:end-1,end);
D(i,i) = Q(end,end)-c1'*v*c1;
R(1:length(c1),i-1)=c1';
Q=Q(1:end-1,1:end-1);
clear c1;
end
D(1,1) = Q(1,1);
end
