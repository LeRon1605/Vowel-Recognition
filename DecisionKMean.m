function [ Vowel ] = DecisionKMean(MFCC, db_KMFCC, k)
    dist = zeros(5 * k, 1);
    for i = 1:5*k
        dist(i) = Euclidean(MFCC, db_KMFCC(i,:));
    end
    [value, index] = min(dist);
    if index <= 1*k 
        Vowel = 'a';
    else
        if index <= 2*k
            Vowel = 'e';
        else
            if index <= 3*k
                Vowel = 'i';
            else 
                if index <= 4*k
                    Vowel = 'o';
                else
                    Vowel = 'u';
                end
            end
        end
    end
end

