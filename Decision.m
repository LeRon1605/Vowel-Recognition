function [vowel] = Decision(vector, db)
    dist = zeros(5, 1);
    for i = 1 : 5
        dist(i) = Euclidean(vector, db(i,:));
    end
    [minDis, index] = min(dist);
    
    if index == 1 
        vowel = 'a';
    elseif index == 2
        vowel = 'e';
    elseif index == 3
        vowel = 'i';
    elseif index == 4
        vowel = 'o';
    else
        vowel = 'u';
    end
    
end