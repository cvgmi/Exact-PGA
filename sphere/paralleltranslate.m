function [w] = paralleltranslate(v,Y)

w = v - (Y'*v)*Y;

end
