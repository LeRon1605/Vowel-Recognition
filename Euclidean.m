function [dist] = Euclidean(vector1,vector2)
    dist = sqrt(sum((vector2-vector1).^2));
%    dist = sum((vector1 - mean(vector1)).*(vector2 - mean(vector2)))/sqrt(sum((vector1 - mean(vector1)).^2).*sum((vector2 - mean(vector2)).^2));
end